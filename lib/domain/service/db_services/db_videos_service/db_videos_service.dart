import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:spa_client_app/models/server/videos_folder_model/videos_folder_model.dart';

class DbVideosService {
  // static Future<UploadTask?> uploadVideo({
  //   required String folderName,
  //   required File video,
  //   required String name,
  // }) async {
  //   try {
  //     // Upload the video to the database
  //     final ref = FirebaseStorage.instance.ref().child(
  //           'videos/$folderName/$name',
  //         );
  //     final uploadTask = ref.putFile(video);
  //     return uploadTask;
  //   } catch (e) {
  //     debugPrint('Error uploading video: $e');
  //     return null;
  //   }
  // }

  // static Future<bool> deleteVideo(VideoModel video) async {
  //   try {
  //     final ref = FirebaseStorage.instance
  //         .ref()
  //         .child('videos/${video.folderName}/${video.title}');
  //     await ref.delete();
  //     return true;
  //   } catch (e) {
  //     debugPrint('Error deleting video: $e');
  //     return false;
  //   }
  // }

  // static Future<void> createFolder(VideosFolderModel folderName) async {
  //   try {
  //     // Create a folder in the database
  //     await FirebaseFirestore.instance
  //         .collection('videos_folder')
  //         .add(folderName.toMap());
  //   } catch (e) {
  //     debugPrint('Error creating folder: $e');
  //   }
  // }

  static Future<List<VideosFolderModel>> readFolders() async {
    try {
      // Get all folders from the database
      final folders = await FirebaseFirestore.instance
          .collection('videos_folder')
          .get()
          .then(
            (snapshot) => snapshot.docs
                .map(
                    (doc) => VideosFolderModel.fromJson(doc.data(), id: doc.id))
                .toList(),
          );
      return folders;
    } catch (e) {
      debugPrint('Error getting folders: $e');
      return [];
    }
  }

  // static Future<void> updateFolder(VideosFolderModel folder) async {
  //   try {
  //     // Update the folder in the database
  //     await FirebaseFirestore.instance
  //         .collection('videos_folder')
  //         .doc(folder.id)
  //         .update(folder.toMap());
  //   } catch (e) {
  //     debugPrint('Error updating folder: $e');
  //   }
  // }

  // static Future<void> deleteFolder(String folderId) async {
  //   try {
  //     // Delete the folder from the database
  //     await FirebaseFirestore.instance
  //         .collection('videos_folder')
  //         .doc(folderId)
  //         .delete();
  //   } catch (e) {
  //     debugPrint('Error deleting folder: $e');
  //   }
  // }
}
