import 'package:spa_client_app/config/bloc_config.dart';
import 'package:spa_client_app/models/server/user_models/user_data_model/user_data.dart';

class TempUsersBlocState {
  final List<ServerUserData> users;
  final ServerUserData? user;
  final String password;
  final String qrCode;
  final bool loading;

  TempUsersBlocState({
    required this.users,
    required this.user,
    this.password = '',
    this.qrCode = '',
    this.loading = false,
  });

  factory TempUsersBlocState.initial() =>
    TempUsersBlocState(users: [], user: null);
  

  TempUsersBlocState copyWith({
    List<ServerUserData>? users,
    ServerUserData? user,
    String? password,
    String? qrCode,
    bool? loading,
  }) {
    return TempUsersBlocState(
      users: users ?? this.users,
      user: user ?? this.user,
      password: password ?? this.password,
      qrCode: qrCode ?? this.qrCode,
      loading: loading ?? this.loading,
    );
  }
}

class TempUsersBloc extends Cubit<TempUsersBlocState> {
  TempUsersBloc() : super(TempUsersBlocState.initial());

  // void emitState(BuildContext context) {
  //   final tempUsers = context
  //       .read<UsersDataBloc>()
  //       .state
  //       .where((element) =>
  //           context.read<UsersRolesBloc>().sayRole(element.roleId) ==
  //           'Temp User')
  //       .toList();
  //   emit(state.copyWith(users: tempUsers));
  // }

  // void setUser(ServerUserData user) async {
  //   emit(state.copyWith(loading: true, user: user));
  //   final resp = await UserAuthService.changePasswordForTempUser(user.email);
  //   if (resp.code != StatusCodeModel.success.code) {
  //     emit(state.copyWith(loading: false, qrCode: ''));
  //     return;
  //   }
  //   final qr = _qrdCodeGenerator();
  //   emit(
  //     state.copyWith(
  //       user: user,
  //       password: resp.message.split(':').last.trim(),
  //       qrCode: qr,
  //       loading: false,
  //     ),
  //   );
  // }

  // String _qrdCodeGenerator() {
  //   final email = state.user!.email;
  //   final pass = state.password;
  //   final qrCode = 'email: $email\npassword: $pass';
  //   return qrCode;
  // }
}
