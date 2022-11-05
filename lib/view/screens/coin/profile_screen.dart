import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intro_flutter/view_model/provider/theme_proider.dart';
import 'package:provider/provider.dart';

import '../../../core/themes.dart';
import '../../../view_model/provider/auth/auth_provider.dart';
import '../../../view_model/provider/coin/profile_provider.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Provider.of<ProfileProvider>(context, listen: false).getUser();
    var provider = Provider.of<ProfileProvider>(context);
    return Scaffold(
      // profile screen for cryptocurrency app ui design
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              SizedBox(
                height: 20,
              ),
            Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 60,
                backgroundImage: NetworkImage(provider.user.image == ''
                    ? "https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png"
                    : provider.user.image),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                provider.user.name,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                provider.user.email,
                style: TextStyle(
                  fontSize: 15,
                ),
              ),
            ],
          ),

              SizedBox(
                height: 40,
              ),
              // tow button add photo button for profile screen gallery and camera

              Row(
                children: [
                  // from gallery and camera

                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        provider.pickImage(ImageSource.gallery);
                      },
                      child: Container(
                        height: 50,
                        decoration: BoxDecoration(
                          color: Themes.isDarkMode(context) ? Color(0xff151f2c) : Colors.blueGrey[600],
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 20),
                              child: Text(
                                "From Gallery",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Icon(
                              Icons.image_outlined,
                              color: Colors.white,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        provider.pickImage(ImageSource.camera);
                      },
                      child: Container(
                        height: 50,
                        decoration: BoxDecoration(
                          color: Themes.isDarkMode(context) ? Color(0xff151f2c) : Colors.blueGrey[600],
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 20),
                              child: Text(
                                "Add Photo",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Icon(
                              Icons.camera_alt,
                              color: Colors.white,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  // icon  for from gallery
                ],
              ),
              SizedBox(
                height: 20,
              ),
              // change theme light and dark mode drop down button
              Row(
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        //show dialog for change theme
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: Text("Change Theme"),
                              content: Container(
                                height: 130,
                                child: Column(
                                  children: [
                                    // theme system
                                    InkWell(
                                      onTap: () {
                                        Provider.of<ThemeProvider>(context,
                                                listen: false)
                                            .saveThemeModeToSharedPref(ThemeMode.system);
                                        Navigator.pop(context);
                                      },
                                      child: Container(
                                        height: 40,
                                        width: double.infinity,
                                        decoration: BoxDecoration(
                                          color: Colors.grey[200],
                                          borderRadius:
                                              BorderRadius.circular(5),
                                        ),
                                        child: Center(
                                          child: Text(
                                            "System",
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 20,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Expanded(
                                      child: InkWell(
                                        onTap: () {
                                          Provider.of<ThemeProvider>(context,
                                                  listen: false)
                                              .saveThemeModeToSharedPref(ThemeMode.light);
                                          Navigator.pop(context);
                                        },
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(5),
                                          ),
                                          child: Center(
                                            child: Text(
                                              "Light",
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 20,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Expanded(
                                      child: InkWell(
                                        onTap: () {
                                          Provider.of<ThemeProvider>(context,
                                                  listen: false)
                                              .saveThemeModeToSharedPref(ThemeMode.dark);
                                          Navigator.pop(context);
                                        },
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: Colors.black,
                                            borderRadius:
                                                BorderRadius.circular(5),
                                          ),
                                          child: Center(
                                            child: Text(
                                              "Dark",
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 20,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        );

                      },
                      child: Container(
                        height: 50,
                        decoration: BoxDecoration(
                          color: Themes.isDarkMode(context) ? Color(0xff151f2c) : Colors.blueGrey[600],
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Text(
                                "Change Theme",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                ),
                              ),
                            ),
                            Icon(
                              Icons.arrow_drop_down,
                              color: Colors.white,
                            ),

                          ],
                        ),
                        // drop down list for change language




                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              // change language drop down button
              Row(
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: Text("Change Language"),
                              content: Container(
                                height: 100,
                                child: Column(
                                  children: [
                                    InkWell(
                                      onTap: () {

                                      },
                                      child: Container(
                                        height: 50,
                                        child: Row(
                                          children: [
                                            Icon(
                                              Icons.language,
                                              color: Colors.blue,
                                            ),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Text(
                                              "English",
                                              style: TextStyle(
                                                fontSize: 20,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    InkWell(
                                      onTap: () {

                                      },
                                      child: Container(
                                        height: 50,
                                        child: Row(
                                          children: [
                                            Icon(
                                              Icons.language,
                                              color: Colors.blue,
                                            ),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Text(
                                              "Arabic",
                                              style: TextStyle(
                                                fontSize: 20,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                      },
                      child: Container(
                        height: 50,
                        decoration: BoxDecoration(
                          color: Themes.isDarkMode(context) ? Color(0xff151f2c) : Colors.blueGrey[600],
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Text(
                                "Change Language",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                ),
                              ),
                            ),
                             Icon(
                                Icons.arrow_drop_down,
                                color: Colors.white,
                              ),

                          ],
                        ),
                        // drop down list for change language




                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              // logout button
              Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        Provider.of<AuthProvider>(context, listen: false)
                            .signOut();
                      },
                      child: Container(
                        height: 50,
                        decoration: BoxDecoration(
                          color: Themes.isDarkMode(context) ? Color(0xff151f2c) : Colors.blueGrey[600],
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Text(
                                "Logout",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                ),
                              ),
                            ),
                               Icon(
                                Icons.logout,
                                color: Colors.white,
                              ),

                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
    // prof
  }
}
