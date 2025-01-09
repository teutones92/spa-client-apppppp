import 'package:flutter/material.dart';
import 'package:spa_client_app/config/bloc_config.dart';
import 'package:spa_client_app/domain/blocs/profile_bloc/profile_bloc.dart';
import 'package:spa_client_app/domain/service/db_services/user_related_services/db_roles_service/db_roles_service.dart';
import 'package:spa_client_app/domain/service/user_auth_service/user_auth_service.dart';

import '../../../../models/server/user_models/user_role_model/user_role.dart';

class UserRoleBlocState {
  final List<UserRole> userRoles;
  final bool isLoading;
  final UserRole? userRole;

  UserRoleBlocState({
    this.userRoles = const [],
    this.isLoading = false,
    this.userRole,
  });

  UserRoleBlocState copyWith({
    List<UserRole>? userRoles,
    bool? isLoading,
    UserRole? userRole,
  }) {
    return UserRoleBlocState(
      userRoles: userRoles ?? this.userRoles,
      isLoading: isLoading ?? this.isLoading,
      userRole: userRole ?? this.userRole,
    );
  }
}

class UsersRolesBloc extends Cubit<UserRoleBlocState> {
  UsersRolesBloc() : super(UserRoleBlocState());
  List<UserRole> tabs = [];

  Future<void> readUserRoles(BuildContext context) async {
    final sharedPref = UserAuthService.sharedPref;
    final List<UserRole> userRoles = await DbUserRolesService.getUserRoles();
    userRoles.sort((a, b) => a.role.compareTo(b.role));
    if (!context.mounted) return;
    final profileBlocState = context.read<ProfileBloc>().state;
    if (profileBlocState.userData != null &&
        profileBlocState.userData!.roleId ==
            userRoles.firstWhere((element) => element.role == 'Manager').id) {
      final managerRole =
          userRoles.firstWhere((element) => element.role == 'Manager');
      await sharedPref.setString('managerId', managerRole.id!);
      userRoles.contains(managerRole) ? userRoles.remove(managerRole) : null;
    } else {
      final managerRole =
          userRoles.firstWhere((element) => element.role == 'Manager');
      userRoles.contains(managerRole) ? userRoles.remove(managerRole) : null;
      final coachRole =
          userRoles.firstWhere((element) => element.role == 'Coach');
      userRoles.contains(coachRole) ? userRoles.remove(coachRole) : null;
    }
    emit(state.copyWith(userRoles: userRoles));
    addNewItemToUserRoll(userRoles);
  }

  void addNewItemToUserRoll(List<UserRole> userRoles) {
    final List<UserRole> newList = List.from(userRoles);
    newList.insert(0, UserRole(id: null, role: 'All', description: 'All'));
    tabs = newList;
  }

  String sayRole(String roleId) {
    final role = state.userRoles.firstWhere(
      (element) => element.id == roleId,
      orElse: () => UserRole(
        role: 'Manager',
        description: 'Manager',
        id: UserAuthService.sharedPref.getString('managerId'),
      ),
    );
    return role.role;
  }

  /// Checks if the user role associated with the given `roleId` is '12U users'.
  ///
  /// This method searches through the current state to find a user role that matches
  /// the provided `roleId`. If a matching role is found, it checks if the role is '12U users'.
  /// If no matching role is found, it returns `false`.
  ///
  /// - Parameter roleId: The ID of the user role to check.
  /// - Returns: `true` if the role is '12U users', otherwise `false`.
  bool is12uUser(String roleId) {
    final role = state.userRoles.firstWhere((element) => element.id == roleId,
        orElse: () => UserRole(role: 'Unknown', description: 'Unknown'));
    return role.role == '12U users';
  }

  // Future<void> updateUserRole(UserRole userRole) async {
  //   await DbUserRolesService.updateUserRole(userRole);
  //   await readUserRoles();
  // }

  // Future<void> deleteUserRole(UserRole userRole) async {
  //   await DbUserRolesService.deleteUserRole(userRole.id!);
  //   await readUserRoles();
  // }
}
