import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:spa_client_app/config/bloc_config.dart';
import 'package:spa_client_app/domain/service/db_services/user_related_services/db_roles_service/db_roles_service.dart';
import 'package:spa_client_app/domain/service/db_services/user_related_services/db_user_service/db_user_service.dart';
import 'package:spa_client_app/domain/service/user_auth_service/user_auth_service.dart';
import 'package:spa_client_app/global/global_snack.dart';
import 'package:spa_client_app/models/server/user_models/user_data_model/user_data.dart';
import 'package:spa_client_app/models/server/user_models/user_role_model/user_role.dart';

class LoginBlocState {
  final ServerUserData? user;
  final bool loading;
  final bool obscurePassword;

  LoginBlocState(
      {required this.user,
      required this.loading,
      required this.obscurePassword});

  factory LoginBlocState.initial() {
    return LoginBlocState(user: null, loading: false, obscurePassword: false);
  }

  LoginBlocState copyWith(
      {ServerUserData? user, bool? loading, bool? obscurePassword}) {
    return LoginBlocState(
      user: user ?? this.user,
      loading: loading ?? this.loading,
      obscurePassword: obscurePassword ?? this.obscurePassword,
    );
  }
}

class LoginBloc extends Cubit<LoginBlocState> {
  LoginBloc() : super(LoginBlocState.initial());
  //** Email and password controllers
  final List<TextEditingController> controllers = [
    TextEditingController(),
    TextEditingController(),
  ];

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final RegExp emailRegExp = RegExp(
      r'^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+(?:\.[a-zA-Z]+)?$',
      caseSensitive: false);

  /// Login the user using the provided email and password from the controllers.
  ///
  /// This method performs the following steps:
  /// 1. Validates the email format using a regular expression.
  /// 2. Checks if the email and password fields are not empty.
  /// 3. Calls the `UserAuthService.userLogin` method to authenticate the user.
  /// 4. Retrieves the current user and user roles from the database.
  /// 5. Checks if the user exists and is allowed to log in.
  /// 6. Sends an email verification if the user's email is not verified.
  /// 7. Navigates to the `Landing` page if the login is successful.
  /// 8. Clears the text fields in the controllers.
  ///
  /// Displays appropriate snack bar messages for different error cases.
  ///

  void swapPasswordVisivility() =>
      emit(state.copyWith(obscurePassword: !state.obscurePassword));

  /// [context] The build context to show snack bars and navigate.
  Future<void> login(BuildContext context) async {
    if (!emailRegExp.hasMatch(controllers[0].text)) {
      GlobalSnack.show(context: context, message: 'Invalid email');
      return;
    }
    state.copyWith(loading: true);
    if (controllers[0].text.isEmpty || controllers[1].text.isEmpty) {
      GlobalSnack.show(context: context, message: 'Please fill all fields');
      state.copyWith(loading: false);
      return;
    }
    await UserAuthService.userLogin(
            email: controllers[0].text, pass: controllers[1].text)
        .then((resp) async {
      if (resp == null) {
        state.copyWith(loading: false);
        if (!context.mounted) return;
        GlobalSnack.show(context: context, message: 'Invalid credentials');
        return;
      }
      final currentUser = await DbUserService.read();
      final List<UserRole> userRoles = await DbUserRolesService.getUserRoles();

      if (currentUser == null) {
        state.copyWith(loading: false);
        await UserAuthService.userLogout();
        if (!context.mounted) return;
        GlobalSnack.show(context: context, message: 'User not found');
        return;
      }
      if (!context.mounted) return;
      if (!await _isUserAllowed(currentUser, userRoles, context)) return;

      if (!resp.user!.emailVerified) {
        state.copyWith(loading: false);
        FirebaseAuth.instance.currentUser!.sendEmailVerification();
        if (!context.mounted) return;
        GlobalSnack.show(context: context, message: 'Verification email sent');
      } else {
        state.copyWith(loading: false);
        if (!context.mounted) return;
        // Navigator.pushAndRemoveUntil(
        //     context,
        //     MaterialPageRoute(
        //       builder: (_) => const Landing(),
        //     ),
        //     (route) => false);
        for (var element in controllers) {
          element.clear();
        }
      }
    });
    await Future.delayed(const Duration(milliseconds: 500));
    state.copyWith(loading: false);
  }

  /// Checks if the current user is allowed based on their role.
  ///
  /// This method verifies if the `currentUser` has a role of either 'Manager' or 'Coach'
  /// by comparing the `roleId` of the `currentUser` with the IDs of the roles in `userRoles`.
  /// If the user is not allowed, it sets `isLoading` to false, logs the user out using
  /// `UserAuthService.userLogout()`, and shows a snack bar with the message 'User not allowed'.
  ///
  /// Returns `true` if the user is allowed, otherwise returns `false`.
  ///
  /// - Parameters:
  ///   - currentUser: The current user data.
  ///   - userRoles: A list of user roles to check against.
  ///   - context: The build context to show the snack bar.
  /// - Returns: A `Future` that resolves to `true` if the user is allowed, otherwise `false`.
  Future<bool> _isUserAllowed(ServerUserData currentUser,
      List<UserRole> userRoles, BuildContext context) async {
    final managerId =
        userRoles.firstWhere((element) => element.role == 'Manager').id;
    final coachId =
        userRoles.firstWhere((element) => element.role == 'Coach').id;
    if (currentUser.roleId != managerId && currentUser.roleId != coachId) {
      state.copyWith(loading: false);
      await UserAuthService.userLogout();
      if (!context.mounted) return false;
      GlobalSnack.show(context: context, message: 'User not allowed');
      return false;
    }
    return true;
  }

  /// Handles the forgot password functionality.
  ///
  /// This method retrieves the email from the first controller, validates it,
  /// and triggers the password reset process if the email is valid. It also
  /// displays appropriate messages using `GlobalSnack`.
  ///
  /// - Parameters:
  ///   - context: The `BuildContext` to show snack messages.
  ///
  /// The method performs the following steps:
  /// 1. Retrieves the email from the first controller.
  /// 2. Checks if the email is empty and shows a message if it is.
  /// 3. Validates the email format and shows a message if it is invalid.
  /// 4. Calls the `UserAuthService.userForgotPassword` method to initiate the
  ///    password reset process.
  /// 5. Shows a message indicating that the password reset email has been sent.
  void forgotPassword(BuildContext context) {
    final email = controllers[0].text;
    if (email.isEmpty) {
      GlobalSnack.show(context: context, message: 'Please enter your email');
      return;
    }
    if (!emailRegExp.hasMatch(email)) {
      GlobalSnack.show(context: context, message: 'Invalid email');
      return;
    }
    UserAuthService.resetPassword(email: controllers[0].text);
    GlobalSnack.show(context: context, message: 'Password reset email sent');
  }

  /// Signs out the current user and navigates to the Login screen, removing all previous routes.
  ///
  /// This method calls the `userLogout` function from `UserAuthService` to log out the user.
  /// It then uses `Navigator.pushAndRemoveUntil` to navigate to the Login screen and remove all
  /// previous routes from the navigation stack.
  ///
  /// Parameters:
  /// - `context`: The `BuildContext` used to navigate to the Login screen.
  void signOut(BuildContext context) {
    UserAuthService.userLogout();
    // Navigator.pushAndRemoveUntil(context,
    //     MaterialPageRoute(builder: (_) => const Login()), (route) => false);
  }

  // void register(BuildContext context) async {
  //   await UserAuthService.userRegister(
  //     state: ServerUserData(
  //       name: 'Carlos Diaz',
  //       email: 'teutones92@gmail.com',
  //       phone: '5027010691',
  //       dateOfBirth: '08-04-1992',
  //       height: 5.11,
  //       weight: 220,
  //       levelOfPlay: 'Pro',
  //       mph: 90,
  //       photo: '',
  //       roleId: 'ipvtqsQbeMnkui2VOpBP',
  //       disable: false,
  //       notifications: false,
  //       createdAt: DateTime.now().toString(),
  //     ),
  //   );
  // }
}
