import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';
import 'dart:ui' as ui;

import 'package:file_picker/file_picker.dart';
import 'package:spa_client_app/models/apps/image_service_model/image_service_model.dart';
import 'package:spa_client_app/models/apps/status_code_model/status_code_model.dart';

class ImageService {
  static final _imagePicker = FilePicker.platform;

  /// Picks an image from the gallery and performs validation checks.
  ///
  /// This function uses the `ImagePicker` to allow the user to select an image
  /// from their device's gallery. It then performs the following checks:
  ///
  /// 1. Ensures the selected file is a PNG image.
  /// 2. Reads the image bytes and decodes the image.
  /// 3. Checks if the image dimensions are 256x256 pixels.
  /// 4. Verifies that the alpha channel of the first pixel is 0 (fully transparent).
  ///
  /// If all checks pass, the function returns the selected image file. Otherwise,
  /// it returns `null`.
  ///
  /// Returns:
  /// - A `File` object representing the selected image if all checks pass.
  /// - `null` if any of the checks fail or if no image is selected.
  static Future<File?> pickPNGImage() async {
    // final imagePicker = ImagePicker();
    // final pickedFile = await imagePicker.pickMedia(imageQuality: 100);
    final pickedFile = await _imagePicker.pickFiles(
        type: FileType.image, allowMultiple: false);
    if (pickedFile == null) return null;
    final file = File(pickedFile.files.single.path!);
    // final file = File(pickedFile.path);
    if (file.path.endsWith('.png')) {
      final imageBytes = await file.readAsBytes();
      final codec = await instantiateImageCodec(imageBytes);
      final frame = await codec.getNextFrame();
      final image = frame.image;
      // if (image.width == 256 && image.height == 256) {
      final byteData = await image.toByteData();
      if (byteData != null) {
        // The 4th byte is the alpha channel
        final firstPixelAlpha = byteData.getUint8(3);
        if (firstPixelAlpha == 0) {
          return file;
        }
      }
      // }
    }
    return null;
  }

  static Future<File?> pickImage() async {
    final pickedFile = await _imagePicker.pickFiles(
        type: FileType.image, allowMultiple: false);
    if (pickedFile == null) return null;
    final file = File(pickedFile.files.single.path!);
    return file;
  }

  static Future<ImageServiceModel> pickDarkImage() async {
    final pickedFile = await _imagePicker.pickFiles(
        type: FileType.image, allowMultiple: false);
    if (pickedFile == null) return ImageServiceModel();
    final file = File(pickedFile.files.single.path!);
    // Decode the image
    final imageBytes = await file.readAsBytes();
    final codec = await ui.instantiateImageCodec(imageBytes);
    final frame = await codec.getNextFrame();
    final ui.Image image = frame.image;
    // Get the first pixel (top-left corner)
    final ByteData? byteData =
        await image.toByteData(format: ui.ImageByteFormat.rawRgba);
    if (byteData == null) {
      return ImageServiceModel(statusCode: StatusCodeModel.error, image: file);
    }
    // Extract RGBA values
    final int r = byteData.getUint8(0); // Red channel
    final int g = byteData.getUint8(1); // Green channel
    final int b = byteData.getUint8(2); // Blue channel
    final int a = byteData.getUint8(3); // Alpha channel (transparency)
    // Ignore completely transparent pixels
    if (a == 0) {
      return ImageServiceModel(statusCode: StatusCodeModel.error, image: file);
    }
    // Calculate brightness using the weighted formula
    final double brightness = 0.299 * r + 0.587 * g + 0.114 * b;
    // Define a threshold for "darkness"
    const brightnessThreshold = 128;
    if (brightness < brightnessThreshold) {
      return ImageServiceModel(
          image: file, statusCode: StatusCodeModel.success);
    } else {
      return ImageServiceModel(statusCode: StatusCodeModel.error, image: file);
    }
  }

  static Future<File?> pickSVGImage() async {
    final pickedFile = await _imagePicker.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['svg'],
        allowMultiple: false);
    if (pickedFile == null) return null;
    final file = File(pickedFile.files.single.path!);
    return file;
  }

  static Future<List<PlatformFile>> pickMultipleVideos() async {
    final pickedFile =
        await _imagePicker.pickFiles(type: FileType.video, allowMultiple: true);
    if (pickedFile == null) return [];
    return pickedFile.files;
  }
}
