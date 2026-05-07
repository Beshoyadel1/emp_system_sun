import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image/image.dart' as img;

class ImageCompressor {
  static Future<Uint8List?> compressImage(
    Uint8List imageBytes, {
    int minWidth = 400,
    int minHeight = 400,
    int quality = 60,
  }) async {
    try {
      print(
        "Size before compression: ${(imageBytes.lengthInBytes / 1024).toStringAsFixed(2)} KB",
      );

      Uint8List? result;

      try {
        if (!kIsWeb && Platform.isWindows) {
          throw UnimplementedError("Native compress not supported on Windows");
        }

        result = await FlutterImageCompress.compressWithList(
          imageBytes,
          minWidth: minWidth,
          minHeight: minHeight,
          quality: quality,
          format: CompressFormat.webp,
        );
      } catch (e) {
        print(
          "Native compression skipped/failed ($e). Using pure-Dart fallback.",
        );
      }

      // 2. Fallback to pure-Dart 'image' package (Works on all platforms)
      result ??= await compute(_compressWithDartImage, {
          'bytes': imageBytes,
          'width': minWidth,
          'height': minHeight,
          'quality': quality,
        });

      if (result != null) {
        print(
          "Size after compression: ${(result.lengthInBytes / 1024).toStringAsFixed(2)} KB",
        );
      }
      return result ?? imageBytes;
    } catch (e) {
      print("Error in ImageCompressor: $e");
      return imageBytes;
    }
  }

  static Uint8List? _compressWithDartImage(Map<String, dynamic> params) {
    try {
      final Uint8List bytes = params['bytes'];
      final int width = params['width'];
      final int height = params['height'];
      final int quality = params['quality'];

      // Decode the image
      img.Image? image = img.decodeImage(bytes);
      if (image == null) return null;

      // Resize if necessary (maintaining aspect ratio)
      if (image.width > width || image.height > height) {
        image = img.copyResize(
          image,
          width: image.width > image.height ? width : null,
          height: image.height >= image.width ? height : null,
          interpolation: img.Interpolation.linear,
        );
      }

      // Encode to JPEG
      return Uint8List.fromList(img.encodeJpg(image, quality: quality));
    } catch (e) {
      print("Dart Image compression error: $e");
      return null;
    }
  }
}
