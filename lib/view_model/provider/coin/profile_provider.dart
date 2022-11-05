import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../../models/user_model.dart';

class ProfileProvider extends ChangeNotifier {



  FirebaseAuth auth = FirebaseAuth.instance;

  FirebaseStorage storage = FirebaseStorage.instance;

  FirebaseFirestore firestore = FirebaseFirestore.instance;






  final ImagePicker _picker = ImagePicker();

  Future<void> pickImage(ImageSource src) async {
    final XFile? pickedImageFile = await _picker.pickImage(
        source: src, imageQuality: 50, maxWidth: 300, maxHeight: 300);

    if (pickedImageFile != null) {
      File _pickedImage = File(pickedImageFile.path);
      await storage.ref().child(auth.currentUser!.uid + '.jpg').putFile(_pickedImage!);

      final url = await storage.ref().child(auth.currentUser!.uid + '.jpg').getDownloadURL();

      firestore.collection("users").doc(auth.currentUser!.uid).update({"image": url});


      notifyListeners();
    } else {
      print("no Image Selected");
    }
  }

  UserModel user = UserModel(
    name: "",
    email: "",
    image: "",
    userId: "",
  );

  getUser() async {
    await firestore
        .collection('users')
        .doc(auth.currentUser!.uid)
        .get()
        .then((value) {
      user = UserModel.fromJson(value.data()!);
      notifyListeners();
    });
  }


}