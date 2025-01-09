import 'package:flutter/material.dart';
import 'package:spa_client_app/config/bloc_config.dart';
import 'package:spa_client_app/domain/service/db_services/user_related_services/db_wop_service/db_wop_service.dart';
import 'package:spa_client_app/models/server/user_models/user_wop_model/user_wop_model.dart';

class UserWopBlocState {
  final UserWopModel? wop;
  final List<UserWopModel> wopList;
  final List<UserWopModel> wopListbyDay;
  final bool loading;

  factory UserWopBlocState.initial() => UserWopBlocState(
        wop: null,
        wopList: [],
        loading: false,
        wopListbyDay: [],
      );

  UserWopBlocState(
      {required this.wop,
      required this.wopList,
      required this.loading,
      required this.wopListbyDay});

  UserWopBlocState copyWith(
          {UserWopModel? wop,
          List<UserWopModel>? wopList,
          bool? loading,
          List<UserWopModel>? wopListbyDay}) =>
      UserWopBlocState(
          wop: wop ?? this.wop,
          wopList: wopList ?? this.wopList,
          loading: loading ?? this.loading,
          wopListbyDay: wopListbyDay ?? this.wopListbyDay);
}

class UserWopBloc extends Cubit<UserWopBlocState> {
  UserWopBloc() : super(UserWopBlocState.initial());
  late TabController dayTabController;

  /// Reads the WOP (Workout Plan) for a user by their UID and emits the result.
  ///
  /// This method fetches the user's workout plan from the database using the provided
  /// user ID (UID) and then emits the retrieved workout plan.
  ///
  /// [uid] The unique identifier of the user whose workout plan is to be read.
  ///
  /// Returns a [Future] that completes when the workout plan has been read and emitted.

  Future<void> readWop() async {
    emit(state.copyWith(loading: true));
    final list = await DbWopService.read();
    emit(state.copyWith(loading: false, wopList: list));
  }

  emitWop(UserWopModel wop) => emit(state.copyWith(wop: wop));

  Future<void> readWopByDay() async {
    final List<WopDayRoutines>? newlist = state.wop?.dayRoutines
        .where((e) => e.day == dayTabController.index + 1)
        .toList();
    emit(state.copyWith(wop: state.wop!.copyWith(dayRoutines: newlist ?? [])));
  }
}
