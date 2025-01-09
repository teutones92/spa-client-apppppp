import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:spa_client_app/models/server/user_models/user_wop_model/user_wop_model.dart';

class DbWopService {
  /// Reads the UserWopModel from Firestore for the current authenticated user.
  ///
  /// This method retrieves the user ID of the currently authenticated user
  /// from FirebaseAuth and queries the 'user_wop' collection in Firestore
  /// for documents where the 'userId' field matches the user's ID.
  ///
  /// If a matching document is found, it is converted to a UserWopModel
  /// and returned. If no matching document is found or an error occurs,
  /// the method returns null.
  ///
  /// Returns:
  ///   A Future that resolves to a UserWopModel if a matching document is found,
  ///   or null if no matching document is found or an error occurs.
  ///
  /// Throws:
  ///   FirebaseException: If an error occurs while querying Firestore.
  static Future<List<UserWopModel>> read() async {
    try {
      final uid = FirebaseAuth.instance.currentUser!.uid;
      final ref = FirebaseFirestore.instance.collection('user_wop');
      // Rad all the user_wop documents by user id or uid.
      final snapshot = await ref.where('userId', isEqualTo: uid).get();
      return snapshot.docs.map((e) => UserWopModel.fromJson(e.data(), e.id)).toList();
    } on FirebaseException catch (e) {
      debugPrint(e.toString());
      return [];
    }
  }
}
