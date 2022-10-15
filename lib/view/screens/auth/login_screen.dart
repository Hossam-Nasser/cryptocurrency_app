import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intro_flutter/view/screens/auth/register_screen.dart';
import 'package:line_icons/line_icon.dart';
import 'package:provider/provider.dart';

import '../../../provider/auth/auth_provider.dart';


class LoginScreen extends StatelessWidget {


  final _formKey = GlobalKey<FormState>();

  var _email = TextEditingController();
  var _password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Login",style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),textAlign: TextAlign.center,),
              Text("Welcome Back",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),textAlign: TextAlign.center,),
              SizedBox(height: 20,),
              TextFormField(
                controller: _email,
                validator: (value) {
                  if(value!.isEmpty || !value.contains("@")){
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
              SizedBox(height: 20,),
              TextFormField(
                controller: _password,
                validator: (value) {
                  if(value!.isEmpty || value.length < 3){
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
              SizedBox(height: 20,),
              Container(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    if(_formKey.currentState!.validate()) {
                      Provider.of<AuthProvider>(context, listen: false).
                      signInWithEmailAndPassword(_email.text, _password.text);
                    }
                  },
                  child: Text('Login',style: TextStyle(fontSize: 20),),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Don\'t have an account?'),
                  TextButton(
                    onPressed: () {
                      Get.offAll(RegisterScreen());
                    },
                    child: Text('Sign Up'),
                  ),
                ],
              ),
              // Sign in with google logo
              SizedBox(height: 40,),
              GestureDetector(
                onTap: (){
                  Provider.of<AuthProvider>(context,listen: false).googleSignInMethod();
                },
                 child: Container(
                    width: 200,
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey,
                          blurRadius: 5,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset('assets/google.png',height: 20,),
                        SizedBox(width: 10,),
                        Text('Sign in with Google'),
                      ],
                    ),
                  )
              )
            ],
          ),
        ),
      ),
    );
  }
}
