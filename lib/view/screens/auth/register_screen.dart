import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../../../provider/auth/auth_provider.dart';
import 'login_screen.dart';

class RegisterScreen extends StatelessWidget {

  final _formKey = GlobalKey<FormState>();

  var _email = TextEditingController();
  var _password = TextEditingController();
  var _name = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Sign Up",
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: _name,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Please enter your name";
                  }
                  return null;
                },
                decoration: InputDecoration(
                  label: Text('Name'),
                  prefixIcon: Icon(Icons.person),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: _email,
                validator: (value) {
                  if (value!.isEmpty || !value.contains("@")) {
                    return "Please enter your email";
                  }
                  return null;
                },
                decoration: InputDecoration(
                  label: Text('Email'),
                  prefixIcon: Icon(Icons.email),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: _password,
                validator: (value) {
                  if (value!.isEmpty || value.length < 3) {
                    return "Please enter your password";
                  }
                  return null;
                },
                decoration: InputDecoration(
                  hintText: 'Enter Password',
                  label: Text('Password'),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  prefixIcon: Icon(Icons.lock),
                  suffixIcon: Icon(Icons.remove_red_eye),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                child: ElevatedButton(
                  onPressed: () {
                    if(_formKey.currentState!.validate()) {
                      Provider.of<AuthProvider>(context, listen: false)
                          .createAccountWithEmailAndPassword(
                          _email.text, _password.text, _name.text);
                    }
                  },
                  child: Text('Sign Up', style: TextStyle(fontSize: 20)),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Already have an account?'),
                  TextButton(
                    onPressed: () {
                      Get.offAll(LoginScreen());
                    },
                    child: Text('Login'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
