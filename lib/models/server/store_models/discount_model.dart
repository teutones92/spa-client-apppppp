import 'package:flutter/material.dart';

class DiscountModel {
  String? id;
  final String promoCode;
  final TextEditingController description;
  final TextEditingController discount;
  String bgImageUrl;
  DateTime? startDate;
  DateTime? endDate;
  bool isActive;

  DiscountModel({
    this.id,
    required this.promoCode,
    required this.description,
    required this.discount,
    required this.bgImageUrl,
    required this.startDate,
    required this.endDate,
    required this.isActive,
  });

  factory DiscountModel.fromJson(Map<String, dynamic> json, String id) =>
      DiscountModel(
        id: id,
        promoCode: json['promoCode'],
        description: TextEditingController(text: json['description']),
        discount: TextEditingController(
            text: json['discount'] == 0.0 ? '' : json['discount'].toString()),
        bgImageUrl: json['bgImageUrl'],
        startDate: json['startDate'] != null
            ? DateTime.parse(json['startDate'])
            : null,
        endDate:
            json['endDate'] != null ? DateTime.parse(json['endDate']) : null,
        isActive: json['isActive'],
      );

  Map<String, dynamic> toJson() => {
        'promoCode': promoCode,
        'description': description.text,
        'discount': discount.text.isEmpty ? 0.0 : double.parse(discount.text),
        'bgImageUrl': bgImageUrl,
        'startDate': startDate?.toIso8601String(),
        'endDate': endDate?.toIso8601String(),
        'isActive': isActive,
      };
}
