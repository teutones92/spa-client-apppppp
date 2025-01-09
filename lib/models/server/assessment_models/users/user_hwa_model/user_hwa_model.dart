import 'package:spa_client_app/models/server/assessment_models/tools/hwa_tool_model/hwa_tool_model.dart';

class UserHwaModel {
  String? id;
  String userId;
  String name;
  List<UserHWAssessment> userHwAssessmentList;
  String createdAt;
  bool canDelete;

  UserHwaModel({
    this.id,
    required this.userId,
    required this.name,
    required this.userHwAssessmentList,
    required this.createdAt,
    this.canDelete = false,
  });

  factory UserHwaModel.fromJson(Map<String, dynamic> json, String id) {
    return UserHwaModel(
      id: id,
      userId: json['userId'],
      name: json['name'],
      userHwAssessmentList: List<UserHWAssessment>.from(
        json['hwAssessmentList'].map(
          (x) => UserHWAssessment.fromJson(x),
        ),
      ),
      createdAt: json['createdAt'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'name': name,
      'createdAt': createdAt,
      'hwAssessmentList': List.from(
        userHwAssessmentList.map(
          (x) => x.toJson(),
        ),
      ),
    };
  }
}

class UserHWAssessment {
  String assessment;
  List<HwaToolDataModel> hwaToolDataList;
  int order;

  UserHWAssessment({
    required this.assessment,
    required this.hwaToolDataList,
    required this.order,
  });

  factory UserHWAssessment.fromJson(Map<String, dynamic> json) {
    return UserHWAssessment(
      assessment: json['assessment'],
      order: json['order'],
      hwaToolDataList: List.from(
        json['hwaToolDataList'].map(
          (x) => HwaToolDataModel.fromUserJson(x),
        ),
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'assessment': assessment,
      'order': order,
      'hwaToolDataList': List.from(
        hwaToolDataList.map(
          (x) => x.toUserJson(),
        ),
      ),
    };
  }
}
