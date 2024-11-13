import 'dart:io';

import 'package:image_picker/image_picker.dart';

Future<File?> pickImageFileFromGallery() async {
  try {
    final pickedImage = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      return File(pickedImage.path);
    }
    return null;
  } catch (e) {
    return null;
  }
}