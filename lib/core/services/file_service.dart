import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';

class FileService {
  Future<PlatformFile?> pickFile() async {
    final result = await FilePicker.pickFiles(withData: true);
    if (result == null) {
      return null;
    }

    return result.files.single;
  }

  Future<PlatformFile?> pickImage() async {
    final result = await FilePicker.pickFiles(
      type: FileType.image,
      withData: true,
    );
    if (result == null) {
      return null;
    }

    return result.files.single;
  }
}
