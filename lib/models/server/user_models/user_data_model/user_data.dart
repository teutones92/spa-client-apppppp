import 'package:flutter/material.dart';

class ServerUserData {
  String? uid;
  String name;
  String email;
  String phone;
  String dateOfBirth;
  double height;
  double weight;
  String levelOfPlay;
  double mph;
  String photo;
  String roleId;
  bool disable;
  bool notifications;
  bool isOnline;
  String createdAt;
  bool isExpanded;
  ExpansionTileController? expansionTileController;

  ServerUserData({
    this.uid,
    required this.name,
    required this.email,
    required this.phone,
    required this.dateOfBirth,
    required this.height,
    required this.weight,
    required this.levelOfPlay,
    required this.mph,
    required this.photo,
    required this.roleId,
    required this.disable,
    required this.notifications,
    required this.isOnline,
    required this.createdAt,
    this.isExpanded = false,
    this.expansionTileController,
  });

  ServerUserData copyWith({
    String? uid,
    String? name,
    String? email,
    String? phone,
    String? dateOfBirth,
    double? height,
    double? weight,
    String? levelOfPlay,
    double? mph,
    String? photo,
    String? roleId,
    bool? disable,
    bool? notifications,
    bool? isOnline,
    String? createdAt,
    bool? isExpanded,
    ExpansionTileController? expansionTileController,
  }) {
    return ServerUserData(
      uid: uid ?? this.uid,
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      height: height ?? this.height,
      weight: weight ?? this.weight,
      levelOfPlay: levelOfPlay ?? this.levelOfPlay,
      mph: mph ?? this.mph,
      photo: photo ?? this.photo,
      roleId: roleId ?? this.roleId,
      disable: disable ?? this.disable,
      notifications: notifications ?? this.notifications,
      isOnline: isOnline ?? this.isOnline,
      createdAt: createdAt ?? this.createdAt,
      isExpanded: isExpanded ?? this.isExpanded,
      expansionTileController:
          expansionTileController ?? this.expansionTileController,
    );
  }

  factory ServerUserData.fromJson(Map<String, dynamic> json) {
    return ServerUserData(
      uid: json['uid'] as String,
      name: json['name'] as String,
      email: json['email'] as String,
      phone: json['phone'] as String,
      dateOfBirth: json['dateOfBirth'] as String,
      height: json.cast()['height'] as double,
      weight: json.cast()['height'] as double,
      levelOfPlay: json['levelOfPlay'] as String,
      mph: double.parse(json.cast()['mph'].toString()),
      photo: json['photo'] as String,
      roleId: json['roleId'] as String,
      disable: json['disable'] as bool,
      isOnline: json['isOnline'] as bool,
      notifications: json['notifications'] as bool,
      createdAt: json['createdAt'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'name': name,
      'email': email,
      'phone': phone,
      'dateOfBirth': dateOfBirth,
      'height': height,
      'weight': weight,
      'levelOfPlay': levelOfPlay,
      'mph': mph,
      'photo': photo,
      'roleId': roleId,
      'disable': disable,
      'isOnline': isOnline,
      'notifications': notifications,
      'createdAt': createdAt,
    };
  }

  // clear variables
  void clear() {
    uid = null;
    name = '';
    email = '';
    phone = '';
    dateOfBirth = '';
    height = 0.0;
    weight = 0.0;
    levelOfPlay = '';
    mph = 0.0;
    photo = '';
    roleId = '';
    disable = false;
    notifications = false;
    isOnline = false;
    createdAt = '';
  }
}
