class ClientAppSettingsModel {
  final String? id;
  final SettingModel? setting;

  ClientAppSettingsModel({
    this.id,
    this.setting,
  });

  factory ClientAppSettingsModel.fromJson(
      Map<String, dynamic> json, String id) {
    return ClientAppSettingsModel(
      id: id,
      setting: SettingModel.fromJson(json['settings']),
    );
  }

  Map<String, dynamic> toJson() => {'settings': setting?.toJson()};

  ClientAppSettingsModel copyWith({
    String? id,
    SettingModel? setting,
  }) {
    return ClientAppSettingsModel(
      id: id ?? this.id,
      setting: setting ?? this.setting,
    );
  }
}

class SettingModel {
  final String key;
  final dynamic value;

  SettingModel({
    required this.key,
    required this.value,
  });

  factory SettingModel.fromJson(Map<String, dynamic> json) {
    return SettingModel(
      key: json.keys.first,
      value: json.values.first,
    );
  }

  Map<String, dynamic> toJson() => {key: value};
}
