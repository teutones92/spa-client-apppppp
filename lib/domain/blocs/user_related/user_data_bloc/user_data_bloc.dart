import 'package:flutter/material.dart';
import 'package:spa_client_app/config/bloc_config.dart';
import 'package:spa_client_app/domain/blocs/profile_bloc/profile_bloc.dart';
import 'package:spa_client_app/domain/service/db_services/user_related_services/db_user_service/db_user_service.dart';
import 'package:spa_client_app/domain/service/user_auth_service/user_auth_service.dart';

import '../../../../models/server/user_models/user_data_model/user_data.dart';

class UserDataBlocState {
  final bool isLoading;
  final ServerUserData? userData;


  UserDataBlocState({
    this.isLoading = false,
    this.userData,
  });

  factory UserDataBlocState.initial() => UserDataBlocState();

  UserDataBlocState copyWith({
    bool? isLoading,
    ServerUserData? userData,
  }) {
    return UserDataBlocState(
      isLoading: isLoading ?? this.isLoading,
      userData: userData ?? this.userData,
    );
  }

  
}


class UserDataBloc extends Cubit<UserDataBlocState> {
  UserDataBloc() : super(UserDataBlocState.initial());

  void emitState(ServerUserData? newState) => emit(state.copyWith(userData: newState));




  // This method is used to check if the email already exist in the database
  Future<bool> checkUserEmailExist(String email) async {
    final user = await DbUserService.readAllUserData();
    return user.any((element) => element.email == email);
  }

  void getUserRole(BuildContext context) async {
    // final userRoles = context.read<UsersRolesBloc>().state.userRoles;
    if (context.mounted) {
      // showModalBottomSheet(
      //   context: context,
      //   builder: (context) {
      //     return SelectRoleWidget(userRoles: userRoles);
      //   },
      // );
    }
  }

  bool checkIfUserIsManager(BuildContext context) {
    final user = context.read<ProfileBloc>().state;
    final managerId = UserAuthService.sharedPref.get('managerId');
    return managerId == user.userData!.roleId;
  }
}
