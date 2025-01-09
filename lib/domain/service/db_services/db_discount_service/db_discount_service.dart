import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../../../models/server/store_models/discount_model.dart';

class DbDiscountService {
  static const _initialErrorText = 'Error creating discount on';
  // static const _discountServerPath = 'discount_images/';
  static const _discountCollectionPath = 'discounts';

  // static Future<StatusCodeModel> create(DiscountModel discount) async {
  //   try {
  //     // Create discount in database
  //     final ref =
  //         FirebaseFirestore.instance.collection(_discountCollectionPath).doc();
  //     await ref.set(discount.toJson());
  //     discount.id = ref.id;
  //     if (discount.bgImageUrl.isNotEmpty) await update(discount);
  //     return StatusCodeModel.success;
  //   } on FirebaseException catch (e) {
  //     debugPrint(
  //         '$_initialErrorText db_product_service => create: ${e.message}');
  //     return StatusCodeModel.error;
  //   }
  // }

  static Future<List<DiscountModel>> read() async {
    try {
      final snapshot = await FirebaseFirestore.instance
          .collection(_discountCollectionPath)
          .get();
      return snapshot.docs
          .map((doc) => DiscountModel.fromJson(doc.data(), doc.id))
          .toList();
    } on FirebaseException catch (e) {
      debugPrint('$_initialErrorText db_product_service => read: $e');
      return [];
    }
  }

  // static Future<void> update(DiscountModel discount) async {
  //   try {
  //     // Update discount in database
  //     final resp = FirebaseFirestore.instance
  //         .collection(_discountCollectionPath)
  //         .doc(discount.id);
  //     if (discount.bgImageUrl.isNotEmpty) {
  //       discount.bgImageUrl = await UploadFilesService.ensureValidUrlTopUpload(
  //         localPath: discount.bgImageUrl,
  //         serverPath: '$_discountServerPath${discount.id!}',
  //         createdAt: DateTime.now().toIso8601String(),
  //       );
  //     }
  //     await resp.update(discount.toJson());
  //   } on FirebaseException catch (e) {
  //     debugPrint('$_initialErrorText db_product_service => update: $e');
  //   }
  // }

  // static Future<StatusCodeModel> delete(DiscountModel discount) async {
  //   try {
  //     if (discount.bgImageUrl.isNotEmpty) {
  //       final path = '$_discountServerPath${discount.id}';
  //       final ref = FirebaseStorage.instance.ref(path);
  //       await ref.delete();
  //     }
  //     final col =
  //         FirebaseFirestore.instance.collection(_discountCollectionPath);
  //     await col.doc(discount.id).delete();
  //     return StatusCodeModel.success;
  //   } on FirebaseException catch (e) {
  //     debugPrint('$_initialErrorText db_product_service => delete: $e');
  //     return StatusCodeModel.error;
  //   }
  // }
}
