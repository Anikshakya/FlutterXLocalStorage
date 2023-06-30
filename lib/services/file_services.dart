import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

class FileUtils {
  static const MethodChannel _channel =
      MethodChannel('delete_image');

  static Future<bool> deleteFile(String filePath) async {
    try {
      final bool deleted = await _channel.invokeMethod('deleteFile', {'filePath': filePath});
      return deleted;
    } on PlatformException catch (e) {
      debugPrint("Failed to delete file: ${e.message}");
      return false;
    }
  }
}
