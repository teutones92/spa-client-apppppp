import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:spa_client_app/models/server/user_models/user_role_model/user_role.dart';

class DbUserRolesService {
  static const String _collectionName = 'roles';
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  static Future<List<UserRole>> getUserRoles() async {
    List<UserRole> roles = [];
    try {
      QuerySnapshot querySnapshot =
          await _firestore.collection(_collectionName).get();
      for (var doc in querySnapshot.docs) {
        roles.add(
            UserRole.fromJson(doc.data() as Map<String, dynamic>, id: doc.id));
      }
    } catch (e) {
      debugPrint('Error: $e');
    }
    return roles;
  }

  static Future<UserRole?> getUserRoleById(String id) async {
    UserRole? role;
    try {
      DocumentSnapshot documentSnapshot =
          await _firestore.collection(_collectionName).doc(id).get();
      role = UserRole.fromJson(documentSnapshot.data() as Map<String, dynamic>);
    } catch (_) {}
    return role;
  }

  // static Future<void> addUserRole(UserRole role) async {
  //   try {
  //     await _firestore.collection(_collectionName).add(role.toMap());
  //   } catch (_) {}
  // }

  // static Future<bool> updateUserRole(UserRole role) async {
  //   try {
  //     await _firestore
  //         .collection(_collectionName)
  //         .doc(role.id)
  //         .update(role.toMap());
  //     return true;
  //   } catch (e) {
  //     debugPrint('Error: $e');
  //     return false;
  //   }
  // }

  // static Future<bool> deleteUserRole(String id) async {
  //   try {
  //     await _firestore.collection(_collectionName).doc(id).delete();
  //     return true;
  //   } catch (e) {
  //     debugPrint('Error: $e');
  //     return false;
  //   }
  // }
}
