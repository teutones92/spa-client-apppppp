import 'package:flutter/material.dart';
import 'package:spa_client_app/models/server/videos_folder_model/videos_folder_model.dart';

class UserWopModel {
  String? id;
  final String userId;
  final String wopName;
  final List<WopDayRoutines> dayRoutines;
  final String createdAt;

  UserWopModel({
    this.id,
    required this.userId,
    required this.wopName,
    required this.dayRoutines,
    required this.createdAt,
  });

  UserWopModel copyWith({
    String? id,
    String? userId,
    String? wopName,
    List<WopDayRoutines>? dayRoutines,
    String? createdAt,
  }) {
    return UserWopModel(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      wopName: wopName ?? this.wopName,
      dayRoutines: dayRoutines ?? this.dayRoutines,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  factory UserWopModel.fromJson(Map<String, dynamic> json, String id) {
    return UserWopModel(
      id: id,
      userId: json['userId'] as String,
      wopName: json['wopName'] as String,
      dayRoutines: (json['dayRoutines'] as List)
          .map((e) => WopDayRoutines.fromJson(e as Map<String, dynamic>))
          .toList(),
      createdAt: json['createdAt'] as String,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'wopName': wopName,
      'dayRoutines': dayRoutines.map((e) => e.toMap()).toList(),
      'createdAt': createdAt,
    };
  }
}

class WopDayRoutines {
  final int day;
  final List<WopRoutines> routines;

  WopDayRoutines({
    required this.day,
    required this.routines,
  });

  WopDayRoutines copyWith({
    int? day,
    List<WopRoutines>? routines,
  }) {
    return WopDayRoutines(
      day: day ?? this.day,
      routines: routines ?? this.routines,
    );
  }

  factory WopDayRoutines.fromJson(Map<String, dynamic> json) {
    return WopDayRoutines(
      day: json['day'] as int,
      routines: (json['routines'] as List)
          .map((e) => WopRoutines.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'day': day,
      'routines': routines.map((e) => e.toMap()).toList(),
    };
  }
}

class WopRoutines {
  final List<VideoModel> videos;
  bool canEdit;
  bool canExpand;
  final TextEditingController titleEditingCtrl;
  FocusNode? titleFocusNode;

  WopRoutines({
    required this.videos,
    this.canEdit = false,
    this.canExpand = false,
    required this.titleEditingCtrl,
    this.titleFocusNode,
  });

  factory WopRoutines.fromJson(Map<String, dynamic> json, {String? id}) {
    return WopRoutines(
      titleEditingCtrl: TextEditingController(text: json['title'] as String),
      videos: (json['videos'] as List)
          .map((e) => VideoModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': titleEditingCtrl.text,
      'videos': videos.map((e) => e.toMap()).toList(),
    };
  }

  WopRoutines copyWith({
    List<VideoModel>? videos,
    int? day,
    bool? canEdit,
    bool? canExpand,
    TextEditingController? titleEditingCtrl,
    FocusNode? titleFocusNode,
  }) {
    return WopRoutines(
      videos: videos ?? this.videos,
      canEdit: canEdit ?? this.canEdit,
      canExpand: canExpand ?? this.canExpand,
      titleEditingCtrl: titleEditingCtrl ??
          TextEditingController(text: this.titleEditingCtrl.text),
      titleFocusNode: titleFocusNode ?? this.titleFocusNode,
    );
  }
}
