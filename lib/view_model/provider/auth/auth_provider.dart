import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:intro_flutter/main.dart';
import 'package:intro_flutter/view/screens/auth/login_screen.dart';
import 'package:intro_flutter/view/widget/control_view.dart';
import 'package:intro_flutter/view_model/provider/control_provider.dart';
import 'package:provider/provider.dart';

import '../../../models/user_model.dart';
import '../../../view/screens/coin/home_screen.dart';



class AuthProvider extends ChangeNotifier {
  FirebaseAuth _auth = FirebaseAuth.instance;

  FirebaseFirestore firestore = FirebaseFirestore.instance;

  GoogleSignIn _googleSignIn = GoogleSignIn();

  void googleSignInMethod() async {
    final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
    print("//////////////////////////////////////");
    print(googleUser);
    GoogleSignInAuthentication googleSignInAuthentication =
        await googleUser!.authentication;

    final AuthCredential credential = GoogleAuthProvider.credential(
      idToken: googleSignInAuthentication.idToken,
      accessToken: googleSignInAuthentication.accessToken,
    );

    await _auth.signInWithCredential(credential).then((user) {
      saveUser(user, "");

      Get.offAll(ControlView());

    });
  }

  void login(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      Get.offAll(ControlView());
    } catch (e) {
      print(e.toString());
      Get.snackbar(
        "Error Login account",
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
      );
    }
  }

  void register(String email, String password, String name) async {
    try {
      await _auth
          .createUserWithEmailAndPassword(
        email: email,
        password: password,
      )
          .then((user) async {
        saveUser(user, name);
      });

      Get.offAll(ControlView());
    } catch (e) {
      print(e.toString());
      Get.snackbar(
        "Error Create Account",
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
      );
    }
  }

  void saveUser(UserCredential user, String name) async {
    UserModel userModel = UserModel(
      email: user.user!.email!,
      userId: user.user!.uid,
      name: name == "" ? user.user!.displayName! : name,
      image: '',
    );
    await firestore
        .collection('users')
        .doc(user.user!.uid)
        .set(userModel.toJson());
  }

  signOut() async {
    await _auth.signOut();
    await _googleSignIn.signOut();
    Get.offAll(LoginScreen());
  }
}
