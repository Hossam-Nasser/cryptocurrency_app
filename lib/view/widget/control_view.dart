import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intro_flutter/core/themes.dart';
import 'package:provider/provider.dart';
import 'package:sliding_clipped_nav_bar/sliding_clipped_nav_bar.dart';

import '../../view_model/provider/control_provider.dart';
import '../../view_model/provider/theme_proider.dart';
import '../screens/auth/login_screen.dart';

class ControlView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return Consumer<ControlProvider>(builder: (context, provider, child) {
      return provider.uid == null ? LoginScreen() : Scaffold(
        body: provider.currentScreen,
        // nav bar theme
        bottomNavigationBar: SlidingClippedNavBar(
        // check if system mode and dark mode is on
        backgroundColor: Themes.isDarkMode(context) ? Colors.black : Colors.blueGrey[50]!,
        //backgroundColor: themeProvider.themeMode == ThemeMode.dark ? Colors.black : Colors.white,

        onButtonPressed: (index) {
          provider.changeSelectedValue(index);
        },
        iconSize: 30,
        activeColor: Colors.green,
        inactiveColor: Themes.isDarkMode(context) ?  Colors.white : Colors.black,

        selectedIndex: provider.currentIndex,
        barItems: <BarItem>[
          BarItem(
            icon: Icons.home,
            title: 'Home',
          ),
          BarItem(
            icon: Icons.search_rounded,
            title: 'Search',

          ),
          BarItem(
            icon: Icons.person,
            title: 'Profile',
          ),
        ],
      ),
      );
    });
  }
}
