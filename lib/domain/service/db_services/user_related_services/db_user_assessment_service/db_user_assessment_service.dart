import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:spa_client_app/models/server/assessment_models/assessments_model/assessments_model.dart';

class DbUserAssessment {
  /// Reads the assessments from the specified Firestore collection for the current user.
  ///
  /// This method retrieves the assessments from the Firestore collection where the
  /// 'userId' field matches the current user's ID. It returns a list of `AssessmentsModel`
  /// objects created from the retrieved documents.
  ///
  /// If an error occurs during the Firestore operation, it catches the `FirebaseException`
  /// and returns an empty list.
  ///
  /// - Parameter collection: The name of the Firestore collection to read from.
  /// - Returns: A `Future` that resolves to a list of `AssessmentsModel` objects.
  static Future<List<AssessmentsModel>> read(String collection) async {
    try {
      final userId = FirebaseAuth.instance.currentUser!.uid;
      final ref = FirebaseFirestore.instance.collection(collection);
      final snapshot = await ref.where('userId', isEqualTo: userId).get();
      if (snapshot.docs.isNotEmpty) {
        return snapshot.docs
            .map((e) => AssessmentsModel.fromJson(e.data(), e.id, isUser: true))
            .toList();
      }
    } on FirebaseException catch (e) {
      debugPrint('FirebaseException: $e');
      return [];
    }
    return [];
  }
}
