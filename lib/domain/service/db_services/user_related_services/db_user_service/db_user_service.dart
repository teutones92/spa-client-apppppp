import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:spa_client_app/models/apps/status_code_model/status_code_model.dart';
import 'package:spa_client_app/models/server/user_models/user_data_model/user_data.dart';

class DbUserService {
  /// Creates user data in the Firestore database.
  ///
  /// This method takes a [ServerUserData] object and saves it to the Firestore
  /// database. If the `uid` field of the [ServerUserData] object is `null`, it
  /// uses the current user's UID from Firebase Authentication. Otherwise, it
  /// uses the provided `uid`.
  ///
  /// The method checks if a document with the user's UID already exists in the
  /// 'users' collection. If it does not exist, it creates a new document with
  /// the data from the [ServerUserData] object.
  ///
  /// If an error occurs during the process, it catches the exception and prints
  /// an error message.
  ///
  /// [serverUserData] - The user data to be saved to the Firestore database.
  ///
  /// Throws an exception if there is an error during the Firestore operation.
  // static Future<void> createUserData(ServerUserData serverUserData) async {
  //   String uid;
  //   if (serverUserData.uid == null) {
  //     uid = FirebaseAuth.instance.currentUser!.uid;
  //   } else {
  //     uid = serverUserData.uid!;
  //   }
  //   final ref = FirebaseFirestore.instance.collection('users').doc(uid);
  //   try {
  //     final user = await ref.collection('users').doc(uid).get();
  //     if (!user.exists) {
  //       await ref.set(serverUserData.toJson());
  //     }
  //   } catch (e) {
  //     debugPrint('Error: $e');
  //   }
  //   // Save data to database
  // }

  // Get data from database
  /// Reads all user data from the Firestore 'users' collection.
  ///
  /// This method fetches all documents from the 'users' collection in
  /// Firestore, converts each document to a `ServerUserData` object, and
  /// returns a list of these objects.
  ///
  /// Returns a [Future] that resolves to a [List] of [ServerUserData] objects.
  ///
  /// If an error occurs during the fetch operation, it catches the exception
  /// and prints an error message.
  static Future<List<ServerUserData>> readAllUserData() async {
    final List<ServerUserData> list = [];
    try {
      final dbRef = FirebaseFirestore.instance.collection('users');
      final resp = await dbRef.get();
      if (resp.docs.isNotEmpty) {
        for (var doc in resp.docs) {
          final data = doc.data();
          final userData = ServerUserData.fromJson(data);
          list.add(userData);
        }
      }
    } catch (e) {
      debugPrint('Error: $e');
    }
    return list;
  }

  /// Fetches the user data from Firestore based on the current authenticated user's UID.
  ///
  /// This method retrieves the UID of the currently authenticated user from FirebaseAuth,
  /// then queries the Firestore collection 'users' for a document with that UID.
  /// If the document exists, it converts the document data to a `ServerUserData` object
  /// and returns it.
  ///
  /// Returns:
  /// - A `Future` that resolves to a `ServerUserData` object if the user data is found.
  /// - `null` if the user data is not found or an error occurs.
  ///
  /// Catches:
  /// - Any exceptions that occur during the process and prints an error message.
  static Future<ServerUserData?> read() async {
    try {
      final uid = FirebaseAuth.instance.currentUser!.uid;
      final ref = FirebaseFirestore.instance.collection('users').doc(uid);
      final resp = await ref.get();
      if (resp.exists) {
        final data = resp.data();
        final userData = ServerUserData.fromJson(data!);
        return userData;
      }
    } catch (e) {
      debugPrint('Error: $e');
      return null;
    }
    return null;
  }

  /// Updates the user data in the Firestore database.
  ///
  /// This method takes a [ServerUserData] object and updates the corresponding
  /// document in the 'users' collection with the data from the object.
  ///
  /// If an error occurs during the update, it catches the exception and prints
  /// an error message.
  ///
  /// [userData] - The user data to be updated in the Firestore database.
  ///
  /// Example usage:
  /// ```dart
  /// ServerUserData userData = ServerUserData(uid: 'user123', name: 'John Doe');
  /// await updateUserData(userData);
  /// ```
  static Future<StatusCodeModel> update(ServerUserData userData) async {
    final ref =
        FirebaseFirestore.instance.collection('users').doc(userData.uid);
    try {
      await ref.update(userData.toJson());
      // await _updateUserAvatar(file, user);
      return  StatusCodeModel.success;
    } catch (e) {
      debugPrint('Error: $e');
      return StatusCodeModel(code: 500, message: 'Error: $e');
    }
  }

  /// Updates the avatar URL of the current user.
  ///
  /// This method takes a [photo] URL as a parameter and updates the current
  /// user's avatar URL in Firebase Authentication.
  ///
  /// If an error occurs during the update, it catches the exception and prints
  /// an error message to the debug console.
  ///
  /// [photo]: The URL of the new avatar photo.
  static Future<void> updateUserAvatar(File file, ServerUserData user) async {
    try {
      await FirebaseStorage.instance.ref('avatars').child(user.uid!).putFile(
            file,
            SettableMetadata(
              customMetadata: {
                'uid': user.uid!,
                'name': user.name,
              },
            ),
          );
      final photo = await FirebaseStorage.instance
          .ref('avatars')
          .child(user.uid!)
          .getDownloadURL();
      await FirebaseAuth.instance.currentUser?.updatePhotoURL(photo);
      await update(user.copyWith(photo: photo));
    } on FirebaseException catch (e) {
      debugPrint('Error: ${e.message}');
    }
  }

  /// Deletes user data from the server.
  ///
  /// This function calls a Firebase Cloud Function named 'deleteUser' to delete
  /// the user data associated with the provided [userData]. It sends the user's
  /// UID to the Cloud Function and handles the response.
  ///
  /// If the Cloud Function returns an error, it logs the error and returns a
  /// [StatusCodeModel] with a code of 500 and the error message.
  ///
  /// If the Cloud Function is successful, it logs the success message and
  /// returns a [StatusCodeModel] with the code and message from the response.
  ///
  /// In case of any exceptions during the process, it catches the exception,
  /// logs the error, and returns a [StatusCodeModel] with a code of 500 and the
  /// exception message.
  ///
  /// [userData] - The user data to be deleted, which includes the user's UID.
  ///
  /// Returns a [Future] that resolves to a [StatusCodeModel] indicating the
  /// result of the operation.
  // static Future<StatusCodeModel> deleteUserData(ServerUserData userData) async {
  //   try {
  //     final HttpsCallable callable =
  //         FirebaseFunctions.instance.httpsCallable('deleteUser');
  //     final response =
  //         await callable.call(<String, dynamic>{'uid': userData.uid});
  //     if (response.data['error'] != null) {
  //       debugPrint('Error: ${response.data['error']}');
  //       return StatusCodeModel(
  //           code: 500, message: 'Error: ${response.data['error']}');
  //     } else {
  //       debugPrint(response.data['message']);
  //       return StatusCodeModel(code: 200, message: response.data['message']);
  //     }
  //   } catch (e) {
  //     debugPrint('Error: $e');
  //     return StatusCodeModel(code: 500, message: 'Error: $e');
  //   }
  // }
}
