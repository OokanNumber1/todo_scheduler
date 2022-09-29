import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:image_picker/image_picker.dart';

class BackgroundService {
  File? pickedFile;

  String boxId = 'background';

  Future<bool> pickFile() async {
    final pickedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    var box = await Hive.openBox(boxId);
    await box.put(0, pickedImage?.path);
    pickedFile = File(pickedImage?.path ?? '');
    return true;
  }

  Future<void> clear() async {
    var box = await Hive.openBox(boxId);
    await box.clear();
    Hive.close();
  }

  Future<String?> readFile() async {
    var box = await Hive.openBox(boxId);
    final path = box.isNotEmpty ? box.getAt(0).toString() : '';
    pickedFile = File(path);
    return path;
  }
}

final backgroundProvider =
    Provider<BackgroundService>((ref) => BackgroundService());

final backgroundImageProvider = StateProvider<File?>((ref) {
  return ref.watch(backgroundProvider).pickedFile;
});
