import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:spa_client_app/models/server/client_app_settings_model/client_app_settings_model.dart';

class ClientAppSettingsService {
  /// Creates a new document in the 'client_app_settings' collection in Firestore.
  ///
  /// This method attempts to add an empty document to the 'client_app_settings' collection
  /// and returns a [ClientAppSettingsModel] with the generated document ID.
  ///
  /// If a [FirebaseException] occurs during the operation, an error message is printed
  /// and the method returns null.
  ///
  /// Returns:
  /// - A [Future] that resolves to a [ClientAppSettingsModel] with the document ID if the
  ///   operation is successful.
  /// - `null` if an error occurs.
  static Future<ClientAppSettingsModel?> _create(
      ClientAppSettingsModel model) async {
    try {
      final ref = FirebaseFirestore.instance.collection('client_app_settings');
      final resp = await ref.add(model.toJson());
      return ClientAppSettingsModel(id: resp.id);
    } on FirebaseException catch (e) {
      debugPrint('Error creating client app setting: ${e.message}');
      return null;
    }
  }

  /// Fetches the client application settings from Firestore.
  ///
  /// This method retrieves the client application settings from the
  /// 'client_app_settings' collection in Firestore. If the collection
  /// contains documents, it converts the first document's data into
  /// a [ClientAppSettingsModel] and returns it. If the collection is
  /// empty or an error occurs during the fetch, it returns null.
  ///
  /// Returns a [Future] that completes with a [ClientAppSettingsModel]
  /// if the settings are successfully retrieved, or null if the
  /// collection is empty or an error occurs.
  ///
  /// Throws a [FirebaseException] if there is an error during the fetch.
  static Future<ClientAppSettingsModel?> read() async {
    try {
      final ref = FirebaseFirestore.instance.collection('client_app_settings');
      final resp = await ref.get();
      if (resp.docs.isNotEmpty) {
        final data = resp.docs.first.data();
        return ClientAppSettingsModel.fromJson(data, resp.docs.first.id);
      } else {
        final model = ClientAppSettingsModel();
        final newSetting = await _create(model);
        if (newSetting != null) {
          return newSetting;
        }
      }
      return null;
    } on FirebaseException catch (e) {
      debugPrint('Error getting client app setting: ${e.message}');
      return null;
    }
  }

  /// Updates the client application settings in the Firestore database.
  ///
  /// This method takes a [ClientAppSettingsModel] object and updates the
  /// corresponding document in the 'client_app_settings' collection in Firestore.
  ///
  /// If an error occurs during the update, it catches the [FirebaseException]
  /// and prints an error message.
  ///
  /// [clentAppSettingModel] - The model containing the client app settings to be updated.
  ///
  /// Throws a [FirebaseException] if the update fails.
  static Future<void> update(
      ClientAppSettingsModel clentAppSettingModel) async {
    try {
      final ref = FirebaseFirestore.instance
          .collection('client_app_settings')
          .doc(clentAppSettingModel.id);
      await ref.update(clentAppSettingModel.toJson());
    } on FirebaseException catch (e) {
      debugPrint('Error updating client app setting: ${e.message}');
    }
  }
}
