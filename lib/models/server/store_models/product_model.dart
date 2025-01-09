import 'package:flutter/material.dart';

class ProductModel {
  String? id;
  final TextEditingController price;
  final TextEditingController name;
  String discountId;
  final TextEditingController description;
  String imageUrl;
  bool isAvailable;

  ProductModel({
    this.id,
    required this.price,
    required this.name,
    required this.discountId,
    required this.description,
    required this.imageUrl,
    required this.isAvailable,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json, String id) {
    return ProductModel(
      id: id,
      price: TextEditingController(
          text: json['price'] == 0.0 ? '' : json['price'].toString()),
      name: TextEditingController(text: json['name']),
      discountId: json['discountId'],
      description: TextEditingController(text: json['description']),
      imageUrl: json['imageUrl'],
      isAvailable: json['isAvailable'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'price': price.text.isNotEmpty ? double.parse(price.text) : 0.0,
      'name': name.text,
      'discountId': discountId,
      'description': description.text,
      'imageUrl': imageUrl,
      'isAvailable': isAvailable,
    };
  }
}
