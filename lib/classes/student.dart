import 'dart:io';

import 'package:firebase_core/firebase_core.dart' as firebase_core;
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class student {
  var id;
  var name;
  var level;
  var password;
  var profile_picture;
  var current_topic;
  var email;
  var courses;
  var birthdate;
}

class Storage {
  final firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;
  late String downloadURL;

  Future<void> UpLoadImage(String path, String name) async {
    File file = File(path);
    try {
      await storage.ref('users_profiles/$name').putFile(file);
      downloadURL = await storage.ref('users_profiles/$name').getDownloadURL();
    } on firebase_core.FirebaseException catch (e) {
      print(e);
    }
  }

  Future<String> DownloadURL(String name) async {
    String downloadURL =
        await storage.ref('users_profiles/$name').getDownloadURL();
    return downloadURL;
  }
}
