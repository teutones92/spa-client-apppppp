import 'package:flutter/material.dart';

class HwaToolModel {
  String? id;
  final String title;
  final List<HwaToolDataModel> subTitles;
  final int order;

  HwaToolModel({
    this.id,
    required this.title,
    required this.subTitles,
    required this.order,
  });

  factory HwaToolModel.fromJson(Map<String, dynamic> json, String id) {
    return HwaToolModel(
      id: id,
      title: json['title'],
      order: json['order'],
      subTitles: List<HwaToolDataModel>.from(
        json['subTitles'].map(
          (x) => HwaToolDataModel.fromJson(x),
        ),
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'order': order,
      'subTitles': List<String>.from(
        subTitles.map(
          (x) => x,
        ),
      ),
    };
  }
}

class HwaToolDataModel {
  final String assessmentSubTitle;
  final ValueNotifier<String>? condLColor;
  final ValueNotifier<String>? condRColor;
  final TextEditingController? notes;

  HwaToolDataModel({
    required this.assessmentSubTitle,
    required this.condLColor,
    required this.condRColor,
    required this.notes,
  });

  factory HwaToolDataModel.fromUserJson(Map<String, dynamic> json) {
    return HwaToolDataModel(
      assessmentSubTitle: json['assessmentSubTitle'],
      condLColor: ValueNotifier(json['condLColor']),
      condRColor: ValueNotifier(json['condRColor']),
      notes: TextEditingController(text: json['notes']),
    );
  }

  Map<String, dynamic> toUserJson() {
    return {
      'assessmentSubTitle': assessmentSubTitle,
      'condLColor': condLColor!.value,
      'condRColor': condRColor!.value,
      'notes': notes!.text,
    };
  }

  factory HwaToolDataModel.fromJson(String json) {
    return HwaToolDataModel(
      assessmentSubTitle: json,
      condLColor: ValueNotifier(''),
      condRColor: ValueNotifier(''),
      notes: TextEditingController(),
    );
  }

  String toJson() => assessmentSubTitle;
}
