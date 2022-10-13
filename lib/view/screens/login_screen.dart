import 'package:flutter/material.dart';
import 'package:intro_flutter/view/screens/register_screen.dart';
import 'package:provider/provider.dart';

import '../../provider/login_provider.dart';
import 'home_screen.dart';

class LoginScreen extends StatelessWidget {



  var _email = TextEditingController();
  var _password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Login",style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),textAlign: TextAlign.center,),
            SizedBox(height: 20,),
            TextFormField(
              controller: _email,
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
              child: ElevatedButton(
                onPressed: () {

                  Provider.of<LoginProvider>(context,listen: false).
                  signInWithEmailAndPassword(_email.text, _password.text,context);

                },
                child: Text('Login'),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Don\'t have an account?'),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => RegisterScreen(),
                      ),
                    );
                  },
                  child: Text('Sign Up'),
                ),
              ],
            ),
            // Sign in with google
            Container(
              child: ElevatedButton(
                onPressed: () {
                  Provider.of<LoginProvider>(context,listen: false).googleSignInMethod(context);
                },
                child: Text('Sign in with Google'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
