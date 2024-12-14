import 'package:flutter/services.dart';

class FileRecoveryService {
  static const platform = MethodChannel('com.ticno.datarecovery/files');

  Future<List<Map<String, dynamic>>> getDeletedFiles(String type) async {
    try {
      final List files = await platform.invokeMethod('getDeletedFiles', {"type": type});
      return List<Map<String, dynamic>>.from(files);
    } catch (e) {
      throw 'Error retrieving files: $e';
    }
  }
}
