import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ControlProvider with ChangeNotifier {

  FirebaseAuth _auth = FirebaseAuth.instance;

  String? uid;

  ControlProvider() {
    getAuth();
  }

  void getAuth() async {

    uid = await _auth.currentUser?.uid ?? null;
    notifyListeners();
  }
}