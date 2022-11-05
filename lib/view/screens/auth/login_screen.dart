import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intro_flutter/view/screens/auth/register_screen.dart';
import 'package:line_icons/line_icon.dart';
import 'package:provider/provider.dart';

import '../../../view_model/provider/auth/auth_provider.dart';

class LoginScreen extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  var _emailController = TextEditingController();
  var _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Sign In",
                  style: TextStyle(
                    fontSize: 35,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                textItem("Email", _emailController, false, context),
                const SizedBox(
                  height: 15,
                ),
                textItem("Password", _passwordController, true, context),

                const SizedBox(
                  height: 10,
                ),
                colorButton("Sign In",context),
                const SizedBox(
                  height: 15,
                ),
                const Text(
                  "Or",
                  style: TextStyle( fontSize: 18),
                ),
                const SizedBox(
                  height: 15,
                ),
                buttonItem(
                    "assets/google.png", "Continue with Google", 25, () {
                  Provider.of<AuthProvider>(context, listen: false)
                      .googleSignInMethod();
                }, context),
                const SizedBox(
                  height: 15,
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "If you don't have an Account ?",
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Get.offAll(() => RegisterScreen());
                      },
                      child: const Text(
                        " Sign Up",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.green,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buttonItem(
      String imagePath, String buttonName, double size, Function() onTap ,
      BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: MediaQuery.of(context).size.width - 60,
        height: 60,
        child: Card(
          elevation: 8,
          color: Colors.black,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
              side: const BorderSide(
                width: 1,
                color: Colors.grey,
              )),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                "assets/google.png",
                height: size,
                width: size,
              ),
              const SizedBox(
                width: 15,
              ),
              Text(
                buttonName,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 17,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget textItem(
      String name, TextEditingController controller, bool obsecureText,
      BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width - 70,
      height: 55,
      child: TextFormField(
        controller: controller,
        obscureText: obsecureText,
        validator: (value) {
          if (value!.isEmpty) {
            return "Please Enter $name";
          }
          else if (name == "Email" && !value.contains("@")) {
            return "Please Enter Valid Email";
          }
          else if (name == "Password" && value.length < 6) {
            return "Password must be at least 6 characters";
          }
          return null;
        },

        style: const TextStyle(
          fontSize: 17,

        ),
        decoration: InputDecoration(
          labelText: name,
          labelStyle: const TextStyle(
            fontSize: 17,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          prefixIcon: name == "Email"
              ? const Icon(
                  Icons.email,
                )
              : const Icon(
                  Icons.lock,
                ),
          suffixIcon: name == "Password"
              ? IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.remove_red_eye,
                  ),
                )
              : null,
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: const BorderSide(
              width: 1.5,
              color: Colors.amber,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: const BorderSide(
              width: 1,
              color: Colors.grey,
            ),
          ),
        ),
      ),
    );
  }

  Widget colorButton(String name,BuildContext context) {
    return InkWell(
      onTap: () async {
        if (_formKey.currentState!.validate())  {
          Provider.of<AuthProvider>(context, listen: false)
              .login(_emailController.text, _passwordController.text);
        }
      },
      child: Container(
        width: MediaQuery.of(context).size.width - 90,
        height: 60,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: const LinearGradient(colors: [
            //dark green
            const Color(0xff1b5e20),
            //light green
            const Color(0xff1b5e20),
          ]),
        ),
        child: Center(
          child: Text(name,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  )),
        ),
      ),
    );
  }
}
