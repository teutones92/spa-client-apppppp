import 'package:flutter/material.dart';

class TwelveUModel {
  String? id;
  final String? userId;
  final TextEditingController assessmentName;
  final String assessmentId;
  final String title;
  final List<SubAssessment12UList> subTitles;
  final int order;

  TwelveUModel({
    this.id,
    required this.userId,
    required this.assessmentName,
    required this.assessmentId,
    required this.title,
    required this.subTitles,
    required this.order,
  });

  factory TwelveUModel.fromJson(Map<String, dynamic> json, String id) {
    return TwelveUModel(
      id: id,
      userId: json.cast()['userId'],
      assessmentName: TextEditingController(text: json['assessmentName']),
      assessmentId: json['assessmentId'],
      title: json['title'],
      subTitles: json.cast()['subTitles'],
      order: json['order'],
    );
  }

  factory TwelveUModel.fromUserJson(Map<String, dynamic> json, String id) {
    return TwelveUModel(
      id: id,
      title: json['title'],
      userId: json['userId'],
      assessmentId: json['assessmentId'],
      assessmentName: json['assessmentName'],
      subTitles: json
          .cast()['subTitles']
          .map((e) => SubAssessment12UList.fromJson(e))
          .toList(),
      order: json['order'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'assessmentName': assessmentName,
      'assessmentId': assessmentId,
      'subTitles': subTitles.map((e) => e.assessmentSubTitle).toList(),
      'order': order,
    };
  }

  Map<String, dynamic> toUserJson() {
    return {
      'id': id,
      'userId': userId,
      'title': title,
      'subTitles': subTitles.map((e) => e.toJson()).toList(),
      'order': order,
    };
  }
}

class SubAssessment12UList {
  final String assessmentSubTitle;
  final ValueNotifier<String> lColor;
  final ValueNotifier<String> rColor;
  final TextEditingController notes;

  SubAssessment12UList({
    required this.assessmentSubTitle,
    required this.lColor,
    required this.rColor,
    required this.notes,
  });

  SubAssessment12UList copyWith({
    String? assessmentSubTitle,
    ValueNotifier<String>? lColor,
    ValueNotifier<String>? rColor,
    TextEditingController? notes,
  }) {
    return SubAssessment12UList(
      assessmentSubTitle: assessmentSubTitle ?? this.assessmentSubTitle,
      lColor: lColor ?? this.lColor,
      rColor: rColor ?? this.rColor,
      notes: notes ?? this.notes,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'assessmentSubTitle': assessmentSubTitle,
      'lColor': lColor.value,
      'rColor': rColor.value,
      'notes': notes.text,
    };
  }

  factory SubAssessment12UList.fromJson(Map<String, dynamic> json) {
    return SubAssessment12UList(
      assessmentSubTitle: json['assessmentSubTitle'],
      lColor: ValueNotifier(json['lColor']),
      rColor: ValueNotifier(json['rColor']),
      notes: TextEditingController(text: json['notes']),
    );
  }
}
