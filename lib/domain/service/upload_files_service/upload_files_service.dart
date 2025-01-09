import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

class UploadFilesService {
  /// Ensures that the provided URL is valid. If the `localPath` does not contain 'https',
  /// it uploads the file to Firebase Storage and returns the download URL.
  ///
  /// The file is uploaded to the specified `serverPath` in Firebase Storage with custom metadata
  /// including the email of the user who uploaded the file and the creation date.
  ///
  /// If the `localPath` already contains 'https', it is assumed to be a valid URL and is returned as is.
  ///
  /// - Parameters:
  ///   - localPath: The local file path to be checked and potentially uploaded.
  ///   - serverPath: The path in Firebase Storage where the file should be uploaded.
  ///   - createdAt: The creation date of the file to be included in the metadata.
  ///
  /// - Returns: A [Future] that resolves to a [String] containing the valid URL.
  static Future<String> ensureValidUrlTopUpload({
    required String localPath,
    required String serverPath,
    required String createdAt,
  }) async {
    late String path = localPath;
    if (!localPath.contains('https')) {
      final storageRef = FirebaseStorage.instance.ref();
      final file = File(path);
      final fileRef = storageRef.child(serverPath);
      await fileRef.putFile(
        file,
        SettableMetadata(
          customMetadata: {
            'uploaded_by': FirebaseAuth.instance.currentUser!.email!,
            'created_at': createdAt,
          },
        ),
      );
      path = await fileRef.getDownloadURL();
    }
    return path;
  }
}
