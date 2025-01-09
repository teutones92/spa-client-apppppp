import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:spa_client_app/models/apps/status_code_model/status_code_model.dart';
import 'package:spa_client_app/models/server/publicity_model/publicity_model.dart';

class DbPublicityService {
  /// The name of the collection in the database that stores publicity buttons.
  static const _publicityCollection = 'publicity_buttons';
  // static const _publicityAssets = 'publicity_assets';
  // static const _pubIdPath = '_pubId_';
  static const imageFieldsName = [
    'iconImage',
    'headerImageUrl',
    'bodyImageUrl',
    'footerImageUrl',
    'background',
  ];

  /// Creates a new publicity entry in the Firestore database.
  ///
  /// This method takes a [PublicityModel] object, adds it to the Firestore
  /// collection, and updates the model with the generated ID and a valid URL
  /// for the icon image. If the creation and update are successful, it returns
  /// a [StatusCodeModel.success]. If an error occurs, it catches the exception,
  /// logs the error, and returns a [StatusCodeModel.error].
  ///
  /// Parameters:
  /// - [promo]: The [PublicityModel] object to be added to the Firestore database.
  ///
  /// Returns:
  /// - A [Future] that resolves to a [StatusCodeModel] indicating the success
  ///   or failure of the operation.
  // static Future<StatusCodeModel> create(PublicityModel promo) async {
  //   try {
  //     final ref = FirebaseFirestore.instance.collection(_publicityCollection);
  //     final resp = await ref.add(promo.toJson());
  //     promo.id = resp.id;
  //     promo.iconImage = await UploadFilesService.ensureValidUrlTopUpload(
  //       localPath: promo.iconImage,
  //       serverPath:
  //           '$_publicityAssets/${promo.id}/folder_icon/icon_$_pubIdPath${promo.id}.${_getFileExtension(promo.iconImage)}',
  //       createdAt: promo.createdAt,
  //     );
  //     await update(promo);
  //     return StatusCodeModel.success;
  //   } catch (e) {
  //     debugPrint(
  //         'Error creating publicity folders in db_publicity_service => create method: $e');
  //     return StatusCodeModel.error;
  //   }
  // }

  /// Reads the list of publicity folders from the Firestore database.
  ///
  /// This method retrieves all documents from the `_publicityCollection` collection
  /// in Firestore, converts each document to a `PublicityModel` object, and returns
  /// a list of these objects sorted by their `order` property.
  ///
  /// Returns:
  /// - A `Future` that completes with a list of `PublicityModel` objects if the operation is successful.
  /// - An empty list if a `FirebaseException` occurs.
  static Future<List<PublicityModel>> read() async {
    try {
      final ref = FirebaseFirestore.instance.collection(_publicityCollection);
      final snapshot = await ref.get();
      final promoFolders = snapshot.docs
          .map((doc) => PublicityModel.fromJson(doc.data(), doc.id))
          .toList();
      promoFolders.sort((a, b) => a.order.compareTo(b.order));
      return promoFolders;
    } on FirebaseException catch (e) {
      debugPrint(
          'Error reading publicity folders in db_publicity_service => read method: ${e.message}');
      return [];
    }
  }

  /// Updates a publicity folder in the Firestore database.
  ///
  /// This method processes image and video fields of the given [PublicityModel]
  /// and updates the corresponding Firestore document with the processed data.
  ///
  /// Throws an error if the update operation fails.
  ///
  /// Returns a [StatusCodeModel] indicating the success or failure of the operation.
  ///
  /// Parameters:
  /// - [promoFolder]: The [PublicityModel] instance containing the data to be updated.
  // static Future<StatusCodeModel> update(PublicityModel promoFolder) async {
  //   try {
  //     final ref = FirebaseFirestore.instance.collection(_publicityCollection);
  //     // Process image fields
  //     await _processImageFields(promoFolder);
  //     // Process video fields
  //     await _processVideoFields(promoFolder);
  //     // Update Firestore document
  //     await ref.doc(promoFolder.id).update(promoFolder.toJson());
  //     return StatusCodeModel.success;
  //   } catch (e) {
  //     debugPrint(
  //         'Error updating publicity folders in db_publicity_service => update method: $e');
  //     return StatusCodeModel.error;
  //   }
  // }

  ////** Deletes a publicity entry from Firebase Storage and Firestore.
  ////**
  ////** This method deletes the publicity icon from Firebase Storage and the
  ////** corresponding document from the Firestore collection _publicityCollection.
  ////**
  ////** [model] The [PublicityModel] instance containing the ID of the publicity
  ////** entry to be deleted.
  ////**
  ////** Returns a [StatusCodeModel] indicating the success or failure of the
  ////** operation.
  ////**
  ////** If an error occurs during the deletion process, it catches the exception,
  ////** prints an error message, and returns [StatusCodeModel.error].
  // static Future<StatusCodeModel> delete(PublicityModel model) async {
  //   try {
  //     final storageRef = FirebaseStorage.instance.ref();
  //     final fileRef = storageRef.child('$_publicityAssets/${model.id}');
  //     await fileRef.delete();
  //     final ref = FirebaseFirestore.instance.collection(_publicityCollection);
  //     await ref.doc(model.id).delete();
  //     await Future.delayed(const Duration(seconds: 1));
  //     return StatusCodeModel.success;
  //   } catch (e) {
  //     debugPrint(
  //         'Error deleting publicity folders in db_publicity_service => delete method: $e');
  //     return StatusCodeModel.error;
  //   }
  // }

  ////** Processes the image fields of a given [PublicityModel] instance by uploading
  ////** them to the server and updating the model with the new server paths.
  ////**
  ////** This method iterates over a predefined set of image fields in the [promoFolder]
  ////** and performs the following steps for each field:
  ////** 1. Checks if the local path of the image field is not empty.
  ////** 2. Builds the server path for the image using the folder ID, field name, and local path.
  ////** 3. Uploads the image to the server and retrieves the updated server path.
  ////** 4. Assigns the updated server path back to the corresponding field in the [promoFolder].
  ////**
  ////** The image fields processed include:
  ////** - `iconImage`
  ////** - `headerImageUrl`
  ////** - `bodyImageUrl`
  ////** - `footerImageUrl`
  ////** - `background`
  ////**
  ////** The method is asynchronous and returns a [Future] that completes when all image
  ////** fields have been processed.
  ////**
  ////** [promoFolder] The [PublicityModel] instance containing the image fields to be processed.
  // static Future<void> _processImageFields(PublicityModel promoFolder) async {
  //   final imageFields = {
  //     'iconImage': promoFolder.iconImage,
  //     'headerImageUrl': promoFolder.headerImageUrl,
  //     'bodyImageUrl': promoFolder.bodyImageUrl,
  //     'footerImageUrl': promoFolder.footerImageUrl,
  //     'background': promoFolder.background,
  //   };
  //   for (final entry in imageFields.entries) {
  //     final fieldName = entry.key;
  //     final localPath = entry.value;
  //     if (localPath.isNotEmpty) {
  //       final serverPath = _buildServerPath(
  //         id: promoFolder.id!,
  //         folder: getFolderName(fieldName),
  //         prefix: _getPrefix(fieldName),
  //         fileOrUrl: localPath,
  //       );
  //       final updatedValue = await _processImageField(
  //         promoFolder: promoFolder,
  //         fieldName: fieldName,
  //         serverPath: serverPath,
  //       );
  //       _assignUpdatedValue(
  //           promoFolder: promoFolder,
  //           fieldName: fieldName,
  //           updatedValue: updatedValue);
  //     }
  //   }
  // }

  ////** Processes the video fields in the given [PublicityModel] object.
  ////**
  ////** This method iterates through the list of videos in the `bodyContent` of the
  ////** provided [promoFolder]. For each video, it constructs a server path and ensures
  ////** that the video URL is valid. If the URL is not valid, it updates the video URL
  ////** with a valid one.
  ////**
  ////** The server path is built using the [promoFolder]'s ID, a fixed path segment
  ////** ('body_content_videos'), a type ('video'), and the original video URL.
  ////**
  ////** The updated video URL is obtained by calling the [_ensureValidUrl] method with
  ////** the local path of the video, the constructed server path, and the creation date
  ////** of the [promoFolder].
  ////**
  ////** If the `bodyContent` or its `videos` list is null or empty, this method does nothing.
  ////**
  ////** - Parameter promoFolder: The [PublicityModel] object containing the videos to be processed.
  ////** - Returns: A [Future] that completes when the processing is done.
  // static Future<void> _processVideoFields(PublicityModel promoFolder) async {
  //   if (promoFolder.bodyContent?.videos.isNotEmpty == true) {
  //     for (var video in promoFolder.bodyContent!.videos) {
  //       final serverPath = _buildServerPath(
  //         id: promoFolder.id!,
  //         folder: 'body_content_videos',
  //         prefix: 'video_${video.videoTitle}',
  //         fileOrUrl: video.videoUrl,
  //       );
  //       final updatedVideoUrl =
  //           await UploadFilesService.ensureValidUrlTopUpload(
  //         localPath: video.videoUrl,
  //         serverPath: serverPath,
  //         createdAt: promoFolder.createdAt,
  //       );
  //       video.videoUrl = updatedVideoUrl;
  //     }
  //   }
  // }

  ////** Returns the folder name corresponding to the given field name.
  ////**
  ////** The method maps specific field names to their respective folder names:
  ////** - 'iconImage' -> 'folder_icon'
  ////** - 'headerImageUrl' -> 'header_image'
  ////** - 'bodyImageUrl' -> 'body_image'
  ////** - 'footerImageUrl' -> 'footer_image'
  ////** - 'background' -> 'background'
  ////**
  ////** If the field name does not match any of the predefined cases, it returns 'unknown'.
  ////**
  ////** @param fieldName The name of the field to get the folder name for.
  ////** @return The corresponding folder name as a string.
  // static String getFolderName(String fieldName) {
  //   switch (fieldName) {
  //     case 'iconImage':
  //       return 'folder_icon';
  //     case 'headerImageUrl':
  //       return 'header_image';
  //     case 'bodyImageUrl':
  //       return 'body_image';
  //     case 'footerImageUrl':
  //       return 'footer_image';
  //     case 'background':
  //       return 'background';
  //     default:
  //       return 'unknown';
  //   }
  // }

  ////** Returns a prefix string based on the provided field name.
  ////**
  ////** The function maps specific field names to their corresponding prefixes:
  ////** - 'iconImage' -> 'icon'
  ////** - 'headerImageUrl' -> 'header'
  ////** - 'bodyImageUrl' -> 'body'
  ////** - 'footerImageUrl' -> 'footer'
  ////** - 'background' -> 'background'
  ////**
  ////** If the field name does not match any of the predefined cases, it returns 'unknown'.
  ////**
  ////** @param fieldName The name of the field for which the prefix is required.
  ////** @return A string representing the prefix for the given field name.
  // static String _getPrefix(String fieldName) {
  //   switch (fieldName) {
  //     case 'iconImage':
  //       return 'icon';
  //     case 'headerImageUrl':
  //       return 'header';
  //     case 'bodyImageUrl':
  //       return 'body';
  //     case 'footerImageUrl':
  //       return 'footer';
  //     case 'background':
  //       return 'background';
  //     default:
  //       return 'unknown';
  //   }
  // }

  ////** Builds the server path for a given image URL.
  ////**
  ////** This method constructs a server path string using the provided parameters:
  ////** [id], [folder], [prefix], and [imageUrl]. The resulting path will be in the
  ////** format: `$_publicityAssets/$id/$folder/${prefix}_$id.<file_extension>`.
  ////**
  ////** - Parameters:
  ////**   - id: The unique identifier for the resource.
  ////**   - folder: The folder name where the resource is stored.
  ////**   - prefix: The prefix to be added to the file name.
  ////**   - imageUrl: The URL of the image to extract the file extension from.
  ////**
  ////** - Returns: A string representing the constructed server path.
  // static String _buildServerPath({
  //   required String id,
  //   required String folder,
  //   required String prefix,
  //   required String fileOrUrl,
  // }) {
  //   return '$_publicityAssets/$id/$folder/$prefix$_pubIdPath${id}_.${_getFileExtension(fileOrUrl)}';
  // }

  ////** Processes an image field for a given publicity model.
  ////**
  ////** This method takes a [PublicityModel] object, a field name, and a server path,
  ////** and ensures that the URL for the image field is valid.
  ////**
  ////** - Parameters:
  ////**   - promoFolder: The [PublicityModel] object containing the image field.
  ////**   - fieldName: The name of the field in the [PublicityModel] that contains the local path to the image.
  ////**   - serverPath: The server path where the image should be stored.
  ////**
  ////** - Returns: A [Future] that resolves to a [String] containing the valid URL for the image field.
  // static Future<String> _processImageField({
  //   required PublicityModel promoFolder,
  //   required String fieldName,
  //   required String serverPath,
  // }) async {
  //   final localPath = promoFolder.toJson()[fieldName];
  //   return await UploadFilesService.ensureValidUrlTopUpload(
  //     localPath: localPath!,
  //     serverPath: serverPath,
  //     createdAt: promoFolder.createdAt,
  //   );
  // }

  ////** Assigns an updated value to a specified field in the `PublicityModel` object.
  ////**
  ////** This method updates the value of a specified field in the given `PublicityModel`
  ////** instance based on the provided field name and updated value.
  ////**
  ////** The following fields can be updated:
  ////** - `iconImage`
  ////** - `headerImageUrl`
  ////** - `bodyImageUrl`
  ////** - `footerImageUrl`
  ////** - `background`
  ////**
  ////** If an unknown field name is provided, a debug message will be printed.
  ////**
  ////** Parameters:
  ////** - `promoFolder`: The `PublicityModel` instance to be updated.
  ////** - `fieldName`: The name of the field to be updated.
  ////** - `updatedValue`: The new value to be assigned to the specified field.
  // static void _assignUpdatedValue(
  //     {required PublicityModel promoFolder,
  //     required String fieldName,
  //     required String updatedValue}) {
  //   switch (fieldName) {
  //     case 'iconImage':
  //       promoFolder.iconImage = updatedValue;
  //       break;
  //     case 'headerImageUrl':
  //       promoFolder.headerImageUrl = updatedValue;
  //       break;
  //     case 'bodyImageUrl':
  //       promoFolder.bodyImageUrl = updatedValue;
  //       break;
  //     case 'footerImageUrl':
  //       promoFolder.footerImageUrl = updatedValue;
  //       break;
  //     case 'background':
  //       promoFolder.background = updatedValue;
  //       break;
  //     default:
  //       debugPrint('Unknown field: $fieldName');
  //   }
  // }

  ////** Returns the file extension from the given file path.
  ////**
  ////** This method splits the file path by the '.' character and returns the last
  ////** segment, which is the file extension.
  ////**
  ////** Example:
  ////** ```dart
  ////** String extension = _getFileExtension('/path/to/file.txt'); // returns 'txt'
  ////** ```
  ////**
  ////** - Parameter filePath: The path of the file.
  ////** - Returns: The file extension as a string.
  // static String _getFileExtension(String filePath) => filePath.split('.').last;

  ////** Removes a file from Firebase Storage.
  ////**
  ////** This method constructs the real path of the file using the provided
  ////** parameters and deletes the file from Firebase Storage.
  ////**
  ////** Parameters:
  ////** - `id`: The unique identifier for the file.
  ////** - `folder`: The folder where the file is stored.
  ////** - `prefix`: The prefix to be added to the file path.
  ////** - `fileOrUrl`: The file name or URL of the file to be deleted.
  ////**
  ////** Returns:
  ////** A `Future` that completes when the file is successfully deleted.
  // static Future<void> removeFile({
  //   required String id,
  //   required String folder,
  //   required String prefix,
  //   required String fileOrUrl,
  // }) async {
  //   final newFile =
  //       fileOrUrl.contains('?') ? fileOrUrl.split('?').first : fileOrUrl;
  //   final realPath = _buildServerPath(
  //       id: id, folder: folder, prefix: prefix, fileOrUrl: newFile);
  //   try {
  //     final storageRef = FirebaseStorage.instance.ref();
  //     final fileRef = storageRef.child(realPath);
  //     await fileRef.delete();
  //   } on FirebaseException catch (e) {
  //     debugPrint(
  //         'Error removing file in db_publicity_service => removeFile method: ${e.message}');
  //   }
  // }
}
