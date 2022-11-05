import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intro_flutter/view_model/provider/auth/auth_provider.dart';
import 'package:provider/provider.dart';

import 'login_screen.dart';

class RegisterScreen extends StatelessWidget {



  var _formKey = GlobalKey<FormState>();
  var _nameController = TextEditingController();
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
                  "Sign Up",
                  style: TextStyle(
                    fontSize: 35,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                textItem("Name", _nameController, false, context),
                const SizedBox(
                  height: 15,
                ),
                textItem("Email", _emailController, false, context),
                const SizedBox(
                  height: 15,
                ),
                textItem("Password", _passwordController, true, context),

                const SizedBox(
                  height: 10,
                ),
                colorButton("Sign Up",context),
                const SizedBox(
                  height: 15,
                ),

                const SizedBox(
                  height: 15,
                ),


                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Already have an account?",
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Get.offAll(() => LoginScreen());
                      },
                      child: const Text(
                        " Sign In",
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
          }else if(name == "Email" && !value.contains("@")){
            return "Please Enter Valid Email";
          }
          else if(name == "Password" && value.length < 6){
            return "Password must be at least 6 characters";
          }
          else if(name == "Name" && value.length < 3){
            return "Name must be at least 3 characters";
          }
          return null;
        },
        style: const TextStyle(
          fontSize: 17,
          color: Colors.white,
        ),
        decoration: InputDecoration(
          labelText: name,
          labelStyle: const TextStyle(
            fontSize: 17,

          ),
          prefixIcon: Icon(
            name == "Name"
                ? Icons.person
                : name == "Email"
                    ? Icons.email
                    : Icons.lock,
          ),
          suffixIcon: name == "Password"
              ? Icon(
                  Icons.remove_red_eye,
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
        if (_formKey.currentState!.validate()) {
          Provider.of<AuthProvider>(context, listen: false).register(
            _emailController.text,
            _passwordController.text,
            _nameController.text,
          );
        }
      },
      child: Container(
        width: MediaQuery.of(context).size.width - 90,
        height: 60,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: const LinearGradient(colors: [

            const Color(0xff1b5e20),

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
