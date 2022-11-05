import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intro_flutter/view/screens/coin/home_screen.dart';

import '../../view/screens/coin/profile_screen.dart';
import '../../view/screens/coin/search_screen.dart';

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


  int currentIndex = 0;

  Widget currentScreen = HomeScreen();

  void changeSelectedValue(int selectedValue) {
    currentIndex = selectedValue;
    switch (selectedValue) {
      case 0:
        {
          currentScreen = HomeScreen();
          break;
        }
      case 1:
        {
          currentScreen = SearchScreen();
          break;
        }
      case 2:
        {
          currentScreen = ProfileScreen();
          break;
        }
    }
    notifyListeners();
  }


}