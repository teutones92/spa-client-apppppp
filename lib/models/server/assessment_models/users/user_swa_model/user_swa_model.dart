import 'package:spa_client_app/models/server/assessment_models/tools/swa_tool_model/swa_tool_model.dart';

class UserSwaModel {
  String? id;
  String userId;
  String name;
  List<UserSWAssessment> userSWAssessmentList;
  String createdAt;

  UserSwaModel({
    this.id,
    required this.userId,
    required this.name,
    required this.userSWAssessmentList,
    required this.createdAt,
  });

  factory UserSwaModel.fromJson(Map<String, dynamic> json, String id) {
    return UserSwaModel(
      id: id,
      userId: json['userId'],
      name: json['name'],
      userSWAssessmentList: List<UserSWAssessment>.from(
        json['swAssessmentList'].map(
          (x) => UserSWAssessment.fromJson(x),
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
      'swAssessmentList': List.from(
        userSWAssessmentList.map(
          (x) => x.toJson(),
        ),
      ),
    };
  }
}

class UserSWAssessment {
  String assessment;
  List<SwaToolDataModel> swToolDataList;
  int order;

  UserSWAssessment({
    required this.assessment,
    required this.swToolDataList,
    required this.order,
  });

  factory UserSWAssessment.fromJson(Map<String, dynamic> json) {
    return UserSWAssessment(
      assessment: json['assessment'],
      order: json['order'],
      swToolDataList: List.from(
        json['swToolDataList'].map(
          (x) => SwaToolDataModel.fromUserJson(x),
        ),
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'assessment': assessment,
      'order': order,
      'swToolDataList': List.from(
        swToolDataList.map(
          (x) => x.toUserJson(),
        ),
      ),
    };
  }
}
