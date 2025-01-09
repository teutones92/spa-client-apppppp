import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:spa_client_app/models/server/store_models/product_model.dart';

class DbProductService {
  /// The initial error message used when there is an error creating a product.
  static const _initialErrorName = 'Error creating product on';

  /// The server path where product images are stored.
  // static const _productServerPath = 'product_images/';

  /// Creates a new product in the Firestore database.
  ///
  /// This method attempts to create a new product document in the 'products' collection
  /// in Firestore. If the product has a non-empty `imageUrl`, it also calls the `update`
  /// method to update the product with the image URL.
  ///
  /// Parameters:
  /// - [product]: The `ProductModel` object representing the product to be created.
  ///
  /// Returns:
  /// - A `Future<StatusCodeModel>` that completes with `StatusCodeModel.success` if the
  ///   operation is successful, or `StatusCodeModel.error` if a `FirebaseException` occurs.
  ///
  /// Example usage:
  /// ```dart
  /// StatusCodeModel status = await DbProductService.create(product);
  /// if (status == StatusCodeModel.success) {
  ///   print('Product created successfully');
  /// } else {
  ///   print('Failed to create product');
  /// }
  /// ```
  // static Future<StatusCodeModel> create(ProductModel product) async {
  //   try {
  //     // Create product in database
  //     final ref = FirebaseFirestore.instance.collection('products').doc();
  //     await ref.set(product.toJson());
  //     if (product.imageUrl.isNotEmpty) await update(product);
  //     return StatusCodeModel.success;
  //   } on FirebaseException catch (e) {
  //     debugPrint(
  //         '$_initialErrorName db_product_service => create: ${e.message}');
  //     return StatusCodeModel.error;
  //   }
  // }

  /// Reads the list of products from the Firestore database.
  ///
  /// This method fetches the documents from the 'products' collection in
  /// Firestore and converts them into a list of `ProductModel` instances.
  ///
  /// Returns a `Future` that resolves to a list of `ProductModel` objects.
  /// If an error occurs during the fetch operation, an empty list is returned
  /// and the error is logged.
  ///
  /// Throws:
  /// - `FirebaseException` if there is an issue with the Firestore operation.
  static Future<List<ProductModel>> read() async {
    try {
      final snapshot =
          await FirebaseFirestore.instance.collection('products').get();
      return snapshot.docs
          .map((doc) => ProductModel.fromJson(doc.data(), doc.id))
          .toList();
    } on FirebaseException catch (e) {
      debugPrint('$_initialErrorName db_product_service => read: $e');
      return [];
    }
  }

  /// Updates the given [ProductModel] in the database.
  ///
  /// This method attempts to update the product information in the Firestore
  /// database. If the product has a non-empty [imageUrl], it ensures the URL
  /// is valid by uploading the file to the server and updating the [imageUrl]
  /// accordingly.
  ///
  /// If a [FirebaseException] occurs during the update process, it catches the
  /// exception and prints an error message.
  ///
  /// [product] - The [ProductModel] instance containing the updated product
  /// information.
  ///
  /// Throws a [FirebaseException] if there is an error during the update.
  // static Future<void> update(ProductModel product) async {
  //   try {
  //     // Update product in database
  //     final resp =
  //         FirebaseFirestore.instance.collection('products').doc(product.id);
  //     if (product.imageUrl.isNotEmpty) {
  //       product.imageUrl = await UploadFilesService.ensureValidUrlTopUpload(
  //         localPath: product.imageUrl,
  //         serverPath: '$_productServerPath${product.id!}',
  //         createdAt: DateTime.now().toIso8601String(),
  //       );
  //     }
  //     await resp.update(product.toJson());
  //   } on FirebaseException catch (e) {
  //     debugPrint('$_initialErrorName db_product_service => update: $e');
  //   }
  // }

  ////** Deletes a product from Firebase Storage and Firestore.
  ////**
  ////** This method deletes the product image from Firebase Storage using the
  ////** product's ID to construct the storage path. It then deletes the product
  ////** document from the Firestore collection 'products'.
  ////**
  ////** Returns a [StatusCodeModel] indicating the success or failure of the operation.
  ////**
  ////** If a [FirebaseException] occurs during the deletion process, it catches
  ////** the exception, logs an error message, and returns [StatusCodeModel.error].
  ////**
  ////** - Parameter [product]: The [ProductModel] instance representing the product to be deleted.
  ////** - Returns: A [Future] that completes with a [StatusCodeModel] indicating the result of the operation.
  // static Future<StatusCodeModel> delete(ProductModel product) async {
  //   try {
  //     if (product.imageUrl.isNotEmpty) {
  //       final path = '$_productServerPath${product.id}';
  //       final ref = FirebaseStorage.instance.ref(path);
  //       await ref.delete();
  //     }
  //     final col = FirebaseFirestore.instance.collection('products');
  //     await col.doc(product.id).delete();
  //     return StatusCodeModel.success;
  //   } on FirebaseException catch (e) {
  //     debugPrint('$_initialErrorName db_product_service => delete: $e');
  //     return StatusCodeModel.error;
  //   }
  // }
}
