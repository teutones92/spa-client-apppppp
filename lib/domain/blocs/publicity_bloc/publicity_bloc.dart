import 'package:flutter/material.dart';
import 'package:spa_client_app/config/bloc_config.dart';
import 'package:spa_client_app/domain/service/db_services/db_publicity_service/db_publicity_service.dart';
import 'package:spa_client_app/models/server/publicity_model/publicity_model.dart';
import 'package:spa_client_app/screens/logins/view/online_user_login/online_user_login.dart';
import 'package:spa_client_app/screens/logins/view/temp_user_access/temp_user_access.dart';

class PublicityBlocState {
  final bool isLoading;
  PublicityModel? publicityModel;
  final List<PublicityModel> promoModelsList;
  final bool swapButtons;

  PublicityBlocState({
    this.isLoading = false,
    this.publicityModel,
    this.promoModelsList = const [],
    this.swapButtons = false,
  });

  factory PublicityBlocState.initial() => PublicityBlocState();

  PublicityBlocState copyWith({
    bool? isLoading,
    PublicityModel? publicityModel,
    List<PublicityModel>? promoModelsList,
    bool? swapButtons,
  }) {
    return PublicityBlocState(
      isLoading: isLoading ?? this.isLoading,
      publicityModel: publicityModel ?? this.publicityModel,
      promoModelsList: promoModelsList ?? this.promoModelsList,
      swapButtons: swapButtons ?? this.swapButtons,
    );
  }
}

class PublicityBloc extends Cubit<PublicityBlocState> {
  PublicityBloc() : super(PublicityBlocState());

  /// Fetches the list of publicity models from the Firestore database and updates the state.
  ///
  /// This method sets the `isLoading` state to `true` while the data is being fetched from the database.
  /// It retrieves the list of publicity models using `DbPublicityService.read`, and then updates the state
  /// with the fetched data and sets `isLoading` to `false`.
  ///
  /// Example usage:
  /// ```dart
  /// await getPublicity();
  /// ```
  Future<void> getPublicity() async {
    emit(state.copyWith(isLoading: true));
    final promoModels = await DbPublicityService.read();
    emit(state.copyWith(isLoading: false, promoModelsList: promoModels));
  }

  void swapButtons(bool buttonIndex) async =>
      emit(state.copyWith(swapButtons: buttonIndex));

  void actions(String item, BuildContext context) {
    switch (item) {
      case "Temp User":
        _goToTempUser(context);
        break;
      case "Online User":
        _goToOnlineUser(context);
        break;
      case "Join now":
        _joinNow(context);
        break;
      default:
        emit(state.copyWith(swapButtons: true));
    }
  }

  void _goToTempUser(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const TempUserAccess(),
      ),
    );
  }

  void _goToOnlineUser(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const OnlineUserLogin(),
      ),
    );
  }

  void _joinNow(BuildContext context) {}

  /// Opens the publicity or store management page based on the provided `PublicityModel` item.
  ///
  /// This method updates the state with the provided `PublicityModel` item and navigates to the
  /// appropriate page based on the `isStore` property of the item. If `isStore` is true, it navigates
  /// to the `StoreManagement` page; otherwise, it navigates to the `PublicityPageView` page.
  ///
  /// Parameters:
  /// - [context]: The build context used for navigation.
  /// - [item]: The `PublicityModel` item that determines which page to navigate to.
  ///
  /// Example usage:
  /// ```dart
  /// openPublicity(context, publicityItem);
  /// ```
  void openPublicity(BuildContext context, PublicityModel item) {
    emit(state.copyWith(publicityModel: item));
    // Navigator.push(
    //   context,
    //   MaterialPageRoute(
    //     builder: (context) =>
    //         item.isStore ? const StoreManagement() : const PublicityPageView(),
    //   ),
    // );
  }
}
