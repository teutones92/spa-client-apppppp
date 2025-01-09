import 'package:flutter/material.dart';

class PublicityModel {
  String? id;
  late TextEditingController title;
  // Must be PNG or SVG background transparent 256x256
  late String iconImage;
  late TextEditingController description;
  late bool isStore;
  final int order;
  late String background;
  late TextEditingController? headerTitle;
  late PublicityContent? headerContent;
  late String headerImageUrl;
  late TextEditingController? bodyTitle;
  late PublicityContent? bodyContent;
  late String bodyImageUrl;
  late TextEditingController? footerTitle;
  late PublicityContent? footerContent;
  late String footerImageUrl;
  late String createdAt;

  PublicityModel({
    this.id,
    required this.title,
    required this.iconImage,
    required this.description,
    required this.isStore,
    required this.order,
    this.background = '',
    this.headerTitle,
    this.headerContent,
    this.headerImageUrl = '',
    this.bodyTitle,
    this.bodyContent,
    this.bodyImageUrl = '',
    this.footerTitle,
    this.footerContent,
    this.footerImageUrl = '',
    this.createdAt = '',
  });

  factory PublicityModel.fromJson(Map<String, dynamic> json, String id) {
    return PublicityModel(
      id: id,
      title: TextEditingController(text: json['title']),
      iconImage: json['iconImage'] ?? '',
      description: TextEditingController(text: json['description']),
      isStore: json['isStore'],
      order: json.cast()['order'],
      background: json['background'] ?? '',
      headerTitle: TextEditingController(text: json['headerTitle']),
      headerContent: PublicityContent.fromJson(json.cast()['headerContent']),
      headerImageUrl: json['headerImageUrl'] ?? '',
      bodyTitle: TextEditingController(text: json['bodyTitle']),
      bodyContent: PublicityContent.fromJson(json.cast()['bodyContent']),
      bodyImageUrl: json['bodyImageUrl'] ?? '',
      footerTitle: TextEditingController(text: json['footerTitle']),
      footerContent: PublicityContent.fromJson(json.cast()['footerContent']),
      footerImageUrl: json['footerImageUrl'] ?? '',
      createdAt: json['createdAt'],
    );
  }

  Map<String, dynamic> toJson() => {
        'title': title.text,
        'iconImage': iconImage,
        'description': description.text,
        'isStore': isStore,
        'order': order,
        'background': background,
        'headerTitle': headerTitle?.text ?? '',
        'headerContent': headerContent?.toJson() ?? PublicityContent().toJson(),
        'headerImageUrl': headerImageUrl,
        'bodyTitle': bodyTitle?.text ?? '',
        'bodyContent': bodyContent?.toJson() ?? PublicityContent().toJson(),
        'bodyImageUrl': bodyImageUrl,
        'footerTitle': footerTitle?.text ?? '',
        'footerContent': footerContent?.toJson() ?? PublicityContent().toJson(),
        'footerImageUrl': footerImageUrl,
        'createdAt': createdAt,
      };
}

class PublicityContent {
  final TextEditingController? text;
  final String imageUrl;
  final String videoUrl;
  final List<PublicityVideo> videos;

  PublicityContent({
    this.text,
    this.imageUrl = '',
    this.videoUrl = '',
    this.videos = const [],
  });

  factory PublicityContent.fromJson(Map<String, dynamic> json) {
    return PublicityContent(
      text: TextEditingController(text: json['text']),
      imageUrl: json['imageUrl'],
      videoUrl: json['videoUrl'],
      videos: (json['videos'] as List)
          .map((e) => PublicityVideo.fromJson(e))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() => {
        'text': text?.text ?? '',
        'imageUrl': imageUrl,
        'videoUrl': videoUrl,
        'videos': videos.map((e) => e.toJson()).toList(),
      };
}

class PublicityVideo {
  String videoUrl;
  String videoTitle;

  PublicityVideo({
    required this.videoUrl,
    required this.videoTitle,
  });

  factory PublicityVideo.fromJson(Map<String, dynamic> json) {
    return PublicityVideo(
      videoUrl: json['videoUrl'],
      videoTitle: json['videoTitle'],
    );
  }

  Map<String, dynamic> toJson() => {
        'videoUrl': videoUrl,
        'videoTitle': videoTitle,
      };
}
