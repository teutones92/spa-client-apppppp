import 'package:flutter/material.dart';

class VideosFolderModel {
  final String? id;
  String folderName;
  final List<VideoModel> videos;

  VideosFolderModel({
    this.id,
    required this.folderName,
    required this.videos,
  });

  factory VideosFolderModel.fromJson(Map<String, dynamic> json, {String? id}) {
    return VideosFolderModel(
      id: id,
      folderName: json['folderName'],
      videos: (json['videos'] as List)
          .map((e) => VideoModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'folderName': folderName,
      'videos': videos.map((e) => e.toMap()).toList(),
    };
  }
}

class VideoModel {
  String? id;
  final String title;
  final String folderId;
  final String folderName;
  final String description;
  String videoUrl;
  final int size;
  ValueNotifier<double> uploadingProgress;
  ValueNotifier<bool>? isSelected;

  VideoModel({
    this.id,
    required this.title,
    required this.folderId,
    required this.folderName,
    required this.description,
    required this.videoUrl,
    required this.size,
    required this.uploadingProgress,
    this.isSelected,
  });

  factory VideoModel.fromJson(Map<String, dynamic> json) {
    return VideoModel(
      title: json['title'],
      folderId: json['folderId'],
      folderName: json['folderName'],
      description: json['description'],
      videoUrl: json['videoUrl'],
      size: json['size'],
      uploadingProgress: ValueNotifier(0.0),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'folderId': folderId,
      'folderName': folderName,
      'description': description,
      'videoUrl': videoUrl,
      'size': size,
    };
  }
}
