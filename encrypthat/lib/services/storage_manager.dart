import 'dart:io';
import 'package:path_provider/path_provider.dart';

class StorageManager {
  StorageManager._privateConstructor();
  static final StorageManager _instance = StorageManager._privateConstructor();
  static StorageManager get instance => _instance;

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();

    return directory.path;
  }

  Future<File> _getLocalFile(String filename) async {
    final path = await _localPath;
    return File('$path/$filename');
  }

  Future<String> readFileContents({required String filename}) async {
    try {
      final file = await _getLocalFile(filename);

      // Read the file
      final contents = await file.readAsString();

      return contents;
    } catch (e) {
      // If encountering an error, return 0
      return 'Error: $e';
    }
  }

  Future<File> writeData({
    required String filename,
    required String data,
  }) async {
    final file = await _getLocalFile(filename);

    return file.writeAsString(data);
  }
}
