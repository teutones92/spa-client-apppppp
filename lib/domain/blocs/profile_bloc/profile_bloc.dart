import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:spa_client_app/config/bloc_config.dart';
import 'package:spa_client_app/domain/service/db_services/user_related_services/db_user_service/db_user_service.dart';
import 'package:spa_client_app/domain/service/user_auth_service/user_auth_service.dart';
import 'package:spa_client_app/global/global_snack.dart';
import 'package:spa_client_app/global/global_warning_dialog.dart';
import 'package:spa_client_app/models/server/user_models/user_data_model/user_data.dart';
import 'package:url_launcher/url_launcher.dart';


class ProfileState {
  final ServerUserData? userData;
  final bool canEdit;
  final bool loading;
  final bool loadingImage;

  ProfileState(
      {this.userData,
      this.canEdit = false,
      this.loading = false,
      this.loadingImage = false});

  
    factory ProfileState.initial()=>ProfileState(userData: null, canEdit: false, loading: false, loadingImage: false);
  

  ProfileState copyWith(
      {ServerUserData? userData,
      bool? canEdit,
      bool? loading,
      bool? loadingImage}) {
    return ProfileState(
      userData: userData ?? this.userData,
      canEdit: canEdit ?? this.canEdit,
      loading: loading ?? this.loading,
      loadingImage: loadingImage ?? this.loadingImage,
    );
  }
}

class ProfileBloc extends Cubit<ProfileState> {
  ProfileBloc() : super(ProfileState());

  Future<void> readUserDataById(BuildContext context) async {
    emit(state.copyWith(loading: true));
    final userData = await DbUserService.read();
    if (userData == null) {
      if (context.mounted) _exit(context);
      return;
    }
    emit(state.copyWith(
        userData: userData, loading: false, loadingImage: false));
    final newUpdate = userData.copyWith(isOnline: true);
    await updateUser(newUpdate);
  }

  void emitUser(ServerUserData userData) =>
      emit(state.copyWith(userData: userData));

  void clearUser() => emit(ProfileState(userData: null, canEdit: false));

  Future<void> updateUser(ServerUserData userData) async {
    await DbUserService.update(userData);
    emit(state.copyWith(userData: userData, loading: false));
  }

  bool isUserManager() {
    final roleId = UserAuthService.sharedPref.getString('managerId');
    return state.userData!.roleId == roleId;
  }

  void logout(BuildContext context) async {
    showDialog(
      context: context,
      builder: (context) => GlobalWarningDialog(
        title: 'Logout',
        content: 'Are you sure you want to logout?',
        callback: () => _exit(context),
      ),
    );
  }

  void _exit(BuildContext context) async {
    await UserAuthService.userLogout();
    if (context.mounted) {
      // Navigator.pushAndRemoveUntil(
      //   context,
      //   MaterialPageRoute(builder: (context) => const Login()),
      //   (route) => false,
      // );
      emit(ProfileState(userData: null, canEdit: false));
    }
  }

  void toggleNotifications(BuildContext context) async {
    emit(state.copyWith(loading: true));
    final userData = state.userData!.copyWith(
      notifications: !state.userData!.notifications,
    );
    await Future.delayed(const Duration(seconds: 1));
    await updateUser(userData);
    if (context.mounted) {
      GlobalSnack.show(
        context: context,
        message: userData.notifications
            ? 'Notifications enabled'
            : 'Notifications disabled',
      );
    }
  }

  void toggleCanEdit() => emit(state.copyWith(canEdit: !state.canEdit));

  void updateProfileImage(BuildContext context) async {
    emit(state.copyWith(loadingImage: true));
    ImagePicker imagePicker = ImagePicker();
    final image = await imagePicker.pickImage(
        source: ImageSource.gallery, imageQuality: 50);
    final croppedImage = await _cropImage(image);
    if (croppedImage == null) {
      emit(state.copyWith(loadingImage: false));
      return;
    }
    await DbUserService.updateUserAvatar(
        File(croppedImage.path), state.userData!);
    if (context.mounted) await readUserDataById(context);
    emit(state.copyWith(loadingImage: false));
  }

  Future<CroppedFile?> _cropImage(XFile? image) async {
    if (image == null) return null;
    final imageCropper = ImageCropper();
    final croppedImage = await imageCropper.cropImage(
        sourcePath: image.path, compressQuality: 50);
    return croppedImage;
  }

  void helpAndSupp(BuildContext context) async {
    if (await launchUrl(Uri.parse("mailto:teutones92@gmail.com"))) return;
    if (context.mounted) {
      GlobalSnack.show(
        context: context,
        message: 'Email app not found',
      );
    }
  }
}
