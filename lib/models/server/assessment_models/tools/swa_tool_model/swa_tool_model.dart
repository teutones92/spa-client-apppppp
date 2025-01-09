import 'package:flutter/material.dart';

class SwaToolModel {
  String? id;
  final String title;
  final List<SwaToolDataModel> subTitles;
  final int order;

  SwaToolModel({
    this.id,
    required this.title,
    required this.subTitles,
    required this.order,
  });

  factory SwaToolModel.fromJson(Map<String, dynamic> json, String id) {
    return SwaToolModel(
      id: id,
      title: json['title'],
      order: json['order'],
      subTitles: List<SwaToolDataModel>.from(
        json['subTitles'].map(
          (x) => SwaToolDataModel.fromJson(x),
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
          (x) => x.toJson(),
        ),
      ),
    };
  }
}

class SwaToolDataModel {
  final String text;
  final ValueNotifier<String> condColor;

  SwaToolDataModel({
    required this.text,
    required this.condColor,
  });

  factory SwaToolDataModel.fromUserJson(Map<String, dynamic> json) {
    return SwaToolDataModel(
      text: json['text'],
      condColor: ValueNotifier(json['condColor']),
    );
  }

  Map<String, dynamic> toUserJson() {
    return {
      'text': text,
      'condColor': condColor.value,
    };
  }

  factory SwaToolDataModel.fromJson(String json) {
    return SwaToolDataModel(
      text: json,
      condColor: ValueNotifier<String>(''),
    );
  }

  String toJson() => text;
}
