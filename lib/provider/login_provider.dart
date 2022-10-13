import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../models/user_model.dart';
import '../view/screens/home_screen.dart';

class LoginProvider extends ChangeNotifier {
  FirebaseAuth _auth = FirebaseAuth.instance;

  GoogleSignIn _googleSignIn =GoogleSignIn();

  void googleSignInMethod(context) async {
    final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
    print("//////////////////////////////////////");
    print(googleUser);

  }


  void signInWithEmailAndPassword(String email, String password, context) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => HomeScreen(),
        ),
      );
    } catch (e) {
      print(e.toString());
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.toString()),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  void createAccountWithEmailAndPassword(
      String email, String password,String name, context) async {
    try {
      await _auth
          .createUserWithEmailAndPassword(email: email, password: password,)
          .then((user) async {
        saveUser(user,name);
      });

      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => HomeScreen()),
          (route) => false);

    } catch (e) {
      print(e.toString());
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.toString()),
          backgroundColor: Colors.red,
        ),
      );
    }
  }


  void saveUser(UserCredential user,String name) async {
    UserModel userModel = UserModel(
      email: user.user!.email!,
      userId: user.user!.uid,
      name: name == "" ? user.user!.displayName! : name,
      image: '',
    );
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    await firestore
        .collection('users')
        .doc(user.user!.uid)
        .set(userModel.toJson());
  }



}
