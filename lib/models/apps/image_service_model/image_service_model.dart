import 'dart:io';

import 'package:spa_client_app/models/apps/status_code_model/status_code_model.dart';

class ImageServiceModel {
  StatusCodeModel statusCode;
  File? image;

  ImageServiceModel({
    this.statusCode = StatusCodeModel.error,
    this.image,
  });
}
