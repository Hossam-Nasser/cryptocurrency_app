import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../models/user_model.dart';

class PhotoProvider extends ChangeNotifier {

  File? _pickedImage;

  FirebaseAuth _auth = FirebaseAuth.instance;
  final ref = FirebaseStorage.instance
      .ref();

  final service = FirebaseFirestore.instance;






  final ImagePicker _picker = ImagePicker();

  Future<void> pickImage(ImageSource src) async {
    final XFile? pickedImageFile = await _picker.pickImage(
        source: src, imageQuality: 50, maxWidth: 300, maxHeight: 300);

    if (pickedImageFile != null) {
      _pickedImage = File(pickedImageFile.path);
      await ref.child(_auth.currentUser!.uid + '.jpg').putFile(_pickedImage!);

      final url = await ref.child(_auth.currentUser!.uid + '.jpg').getDownloadURL();

      service.collection("users").doc(_auth.currentUser!.uid).update({"image": url});

      service.collection("chat").where("uId", isEqualTo: _auth.currentUser!.uid).get().then((value) {
        value.docs.forEach((element) {
          service.collection("chat").doc(element.id).update({"avatarUrl": url});
        });
      });

      notifyListeners();
    } else {
      print("no Image Selected");
    }
  }
}