import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../screens/home_screen.dart';
import '../screens/login_screen.dart';

class ControlView extends StatefulWidget {

  @override
  State<ControlView> createState() => _ControlViewState();
}

class _ControlViewState extends State<ControlView> {
  FirebaseAuth _auth = FirebaseAuth.instance;
  String? uid;
  void getAuth() async {

    uid = await _auth.currentUser!.uid;
  setState(() {

  });

  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getAuth();
  }

  @override
  Widget build(BuildContext context) {
    return uid == null ? LoginScreen() : HomeScreen();
  }
}
