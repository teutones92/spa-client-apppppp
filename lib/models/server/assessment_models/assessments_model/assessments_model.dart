import 'package:flutter/material.dart';

class AssessmentsModel {
  String? id;
  final TextEditingController name;
  final String? userId;
  String userCollection;
  final TextEditingController description;
  DateTime cratedAt;
  final bool requireNotes;
  final bool allowLButton;
  final bool allowRButton;
  final bool isClickable;
  final List<AssessmentToolModel> tools;
  final List<String> rolesId;

  AssessmentsModel({
    this.id,
    required this.name,
    required this.userId,
    required this.userCollection,
    required this.description,
    required this.cratedAt,
    required this.requireNotes,
    required this.allowLButton,
    required this.allowRButton,
    required this.isClickable,
    required this.tools,
    required this.rolesId,
  });

  factory AssessmentsModel.fromJson(Map<String, dynamic> json, String id,
      {required bool isUser}) {
    return AssessmentsModel(
      id: id,
      userId: json['userId'],
      name: TextEditingController(text: json['name']),
      userCollection: json['userCollection'] ?? '',
      description: TextEditingController(text: json['description']),
      cratedAt: DateTime.parse(json['cratedAt']),
      requireNotes: json['requireNotes'],
      allowLButton: json['allowLButton'],
      allowRButton: json['allowRButton'],
      isClickable: json['isClickable'],
      tools: json.cast()['tools'].map<AssessmentToolModel>((tool) {
        return AssessmentToolModel.fromJson(tool, isUser: isUser);
      }).toList(),
      rolesId: json
          .cast()['rolesId']
          .map<String>((role) => role.toString())
          .toList(),
    );
  }

  Map<String, dynamic> toJson({required bool isUser}) {
    return {
      'name': name.text,
      'userId': userId,
      'userCollection': userCollection,
      'description': description.text,
      'cratedAt': cratedAt.toIso8601String(),
      'requireNotes': requireNotes,
      'allowLButton': allowLButton,
      'allowRButton': allowRButton,
      'isClickable': isClickable,
      'tools': tools.map((tool) => tool.toJson(isUser: isUser)).toList(),
      'rolesId': rolesId,
    };
  }

  AssessmentsModel copyWith({
    String? id,
    String? userId,
    TextEditingController? name,
    String? userCollection,
    TextEditingController? description,
    DateTime? cratedAt,
    bool? requireNotes,
    bool? allowLButton,
    bool? allowRButton,
    bool? isClickable,
    String? roleId,
    String? roleName,
    List<AssessmentToolModel>? tools,
    List<String>? rolesId,
  }) {
    return AssessmentsModel(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      name: name ?? this.name,
      userCollection: userCollection ?? this.userCollection,
      description: description ?? this.description,
      cratedAt: cratedAt ?? this.cratedAt,
      requireNotes: requireNotes ?? this.requireNotes,
      allowLButton: allowLButton ?? this.allowLButton,
      allowRButton: allowRButton ?? this.allowRButton,
      isClickable: isClickable ?? this.isClickable,
      tools: tools ?? this.tools,
      rolesId: rolesId ?? this.rolesId,
    );
  }
}

class AssessmentToolModel {
  final String assessmentId;
  final String assessmentName;
  final int order;
  final List<AssessmentToolSubTitleModel> subTitles;
  final TextEditingController title;

  AssessmentToolModel({
    required this.assessmentId,
    required this.assessmentName,
    required this.order,
    required this.subTitles,
    required this.title,
  });

  factory AssessmentToolModel.fromJson(Map<String, dynamic> json,
      {required bool isUser}) {
    return AssessmentToolModel(
      assessmentId: json['assessmentId'],
      assessmentName: json['assessmentName'],
      order: json['order'],
      subTitles:
          json.cast()['subTitles'].map<AssessmentToolSubTitleModel>((subTitle) {
        return AssessmentToolSubTitleModel.fromJson(subTitle, isUser: isUser);
      }).toList(),
      title: TextEditingController(text: json['title']),
    );
  }

  Map<String, dynamic> toJson({required bool isUser}) {
    return {
      'assessmentId': assessmentId,
      'assessmentName': assessmentName,
      'order': order,
      'subTitles':
          subTitles.map((subTitle) => subTitle.toJson(isUser: isUser)).toList(),
      'title': title.text,
    };
  }
}

class AssessmentToolSubTitleModel {
  final TextEditingController controller;
  ValueNotifier<String>? condColor;
  ValueNotifier<String>? condLColor;
  ValueNotifier<String>? condRColor;
  TextEditingController? notes;

  AssessmentToolSubTitleModel({
    required this.controller,
    this.condColor,
    this.condLColor,
    this.condRColor,
    this.notes,
  });

  factory AssessmentToolSubTitleModel.fromJson(json, {required bool isUser}) {
    return AssessmentToolSubTitleModel(
      controller: TextEditingController(text: json['text']),
      condColor: isUser ? ValueNotifier<String>(json['condColor']) : null,
      condLColor: isUser ? ValueNotifier<String>(json['condLColor']) : null,
      condRColor: isUser ? ValueNotifier<String>(json['condRColor']) : null,
      notes: isUser ? TextEditingController(text: json['notes']) : null,
    );
  }

  Map<String, dynamic> toJson({required bool isUser}) {
    return isUser
        ? {
            'text': controller.text,
            'condColor': condColor!.value,
            'condLColor': condLColor!.value,
            'condRColor': condRColor!.value,
            'notes': notes!.text,
          }
        : {'text': controller.text};
  }
}
