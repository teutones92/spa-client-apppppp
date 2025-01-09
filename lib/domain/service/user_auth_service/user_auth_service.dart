
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:spa_client_app/models/apps/status_code_model/status_code_model.dart';

/// A service class for handling user authentication with Firebase.
class UserAuthService {
  static late SharedPreferences sharedPref;

  /// Logs in a user with the provided [email] and [pass].
  ///
  /// Returns a [UserCredential] if the login is successful, or `null` if it fails.
  static Future<UserCredential?> userLogin(
      {required String email, required String pass}) async {
    try {
      final resp = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: pass);
      sharedPref.setBool('loggedIn', true);
      if (sharedPref.getString('password') == null) {
        sharedPref.setString('password', pass);
      }
      return resp;
    } catch (e) {
      debugPrint('Error: $e');
      return null;
    }
  }

  /// Sends a verification email to the currently logged-in user.
  ///
  /// Throws a [FirebaseAuthException] if the email could not be sent.
  // static Future<void> userVerifyEmail() async =>
  //     await FirebaseAuth.instance.currentUser!.sendEmailVerification();

  // /// Sends a password reset email to the user with the provided [email].
  // ///
  // /// Throws a [FirebaseAuthException] if the email could not be sent.
  static Future<StatusCodeModel> resetPassword({required String email}) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      return StatusCodeModel.success;
    } catch (e) {
      debugPrint('Error: $e');
      return StatusCodeModel.error;
    }
  }

  /// Logs out the currently logged-in user.
  ///
  /// Throws a [FirebaseAuthException] if the logout fails.
  static Future<void> userLogout() async {
    await FirebaseAuth.instance.signOut();
    await sharedPref.setBool('loggedIn', false);
    await sharedPref.remove('password');
  }
}
