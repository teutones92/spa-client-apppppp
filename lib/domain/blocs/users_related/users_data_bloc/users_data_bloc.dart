import 'dart:async';

import 'package:flutter/material.dart';
import 'package:spa_client_app/config/bloc_config.dart';
import 'package:spa_client_app/domain/blocs/profile_bloc/profile_bloc.dart';
import 'package:spa_client_app/domain/service/db_services/user_related_services/db_roles_service/db_roles_service.dart';
import 'package:spa_client_app/domain/service/db_services/user_related_services/db_user_service/db_user_service.dart';
import 'package:spa_client_app/models/server/user_models/user_data_model/user_data.dart';
import 'package:spa_client_app/models/server/user_models/user_role_model/user_role.dart';

class UserDataBlocState{
  final ServerUserData? userData;
  final List<ServerUserData> userDataList;
  final bool loadgin;

  UserDataBlocState({
    this.userData,
    this.userDataList = const [],
    this.loadgin = false,
  });

  factory UserDataBlocState.initial() => UserDataBlocState();


  UserDataBlocState copyWith({
    ServerUserData? userData,
    List<ServerUserData>? userDataList,
    bool? loadgin,
  }) => UserDataBlocState(
    userData: userData ?? this.userData,
    userDataList: userDataList ?? this.userDataList,
    loadgin: loadgin ?? this.loadgin,
  );



}



/// A BLoC (Business Logic Component) that manages the state of user data.
///
/// This BLoC extends the `Cubit` class and holds a list of `ServerUserData`.
/// It provides functionality to manage user roles and selected roles.
///
/// Properties:
/// - `userRolesTabCtrl`: A `TabController` to manage user roles tabs.
/// - `selectedRole`: A `ValueNotifier` to keep track of the currently selected role.
/// - `_temPList`: A temporary list of `ServerUserData` cast from the current state.
class UsersDataBloc extends Cubit<UserDataBlocState> {
  UsersDataBloc() : super(UserDataBlocState.initial());
 

  /// Reads user data and emits a filtered list of users based on their roles.
  ///
  /// This method first retrieves the current user's profile state and user roles
  /// from the database. If the current user has a 'Manager' role, it calls
  /// `_readUsersExpectManager` to read users excluding the manager and returns.
  ///
  /// Otherwise, it reads all user data from the database and filters out users
  /// with 'Manager' and 'Coach' roles. The filtered list of users is then emitted.
  ///
  /// The method ensures that the context is still mounted before performing
  /// operations that depend on it.
  ///
  /// [context] - The BuildContext used to read the ProfileBloc state and check
  /// if the context is still mounted.
  ///
  /// Throws an exception if the role 'Manager' or 'Coach' is not found in the roles list.
  Future<void> readUserData(BuildContext context) async {
    final profileBLocState = context.read<ProfileBloc>().state;
    final roles = await DbUserRolesService.getUserRoles();
    if (profileBLocState.userData != null &&
        profileBLocState.userData!.roleId ==
            roles.firstWhere((element) => element.role == 'Manager').id) {
      if (context.mounted) await _readUsersExpectManager(context, roles);
      return;
    }
    final userData = await DbUserService.readAllUserData();
    if (!context.mounted) return;
    final managerRoleId =
        roles.firstWhere((element) => element.role == 'Manager').id;
    final coachRoleId =
        roles.firstWhere((element) => element.role == 'Coach').id;
    final userDataList = userData
        .where((element) =>
            element.roleId != managerRoleId && element.roleId != coachRoleId)
        .toList();
    userDataList.sort((a, b) => a.name.compareTo(b.name));
    // _temPList.clear();
    // _temPList.addAll(userDataList);
    emit(state.copyWith(userDataList: userDataList));
  }

  /// Reads all user data except for users with the 'Manager' role and emits the result.
  ///
  /// This method fetches all user data from the database, filters out users with the 'Manager' role,
  /// and emits the remaining user data.
  ///
  /// The method performs the following steps:
  /// 1. Initializes an empty list to store user data.
  /// 2. Finds the role ID for the 'Manager' role from the provided list of roles.
  /// 3. Fetches all user data from the database.
  /// 4. Filters out users with the 'Manager' role and adds the remaining users to the list.
  /// 5. Emits the filtered user data list.
  ///
  /// Args:
  ///   context (BuildContext): The build context.
  ///   roles (List<UserRole>): A list of user roles to identify the 'Manager' role.
  ///
  /// Returns:
  ///   Future<void>: A future that completes when the user data has been read and emitted.
  Future<void> _readUsersExpectManager(
      BuildContext context, List<UserRole> roles) async {
    final List<ServerUserData> userDataList = [];
    final managerRoleId =
        roles.firstWhere((element) => element.role == 'Manager').id;
    final userData = await DbUserService.readAllUserData();
    userDataList
        .addAll(userData.where((element) => element.roleId != managerRoleId));
    userDataList.sort((a, b) => a.name.compareTo(b.name));
    // _temPList.clear();
    // _temPList.addAll(userDataList);
    emit(state.copyWith(userDataList: userDataList));
  }

  /// Reads all user data from the database, excluding the current user.
  ///
  /// This method fetches all user data from the database using `DbUserService.readAllUserData()`,
  /// filters out the current user based on their UID, and emits the remaining user data.
  ///
  /// Returns a [Future] that completes with no value when the operation is done.
  // Future<void> readAllUsersNoCurrentUser() async {
  //   final uid = FirebaseAuth.instance.currentUser?.uid;
  //   final usersData = await DbUserService.readAllUserData();
  //   final userData = usersData.where((element) => element.uid != uid).toList();
  //   emit(userData);
  // }



 
  void resetFilter() => emit(UserDataBlocState.initial());
}
