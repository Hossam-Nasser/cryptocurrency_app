import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../provider/login_provider.dart';
import 'login_screen.dart';

class RegisterScreen extends StatelessWidget {


  var _email = TextEditingController();
  var _password = TextEditingController();
  var _name = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Sign Up",style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),textAlign: TextAlign.center,),
            SizedBox(height: 20,),
            TextFormField(
              controller: _name,
              decoration: InputDecoration(
                label: Text('Name'),
                prefixIcon: Icon(Icons.person),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),

                ),

              ),
            ),
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
                  createAccountWithEmailAndPassword(_email.text, _password.text,_name.text, context);

                },
                child: Text('Login'),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Already have an account?'),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => LoginScreen(),
                      ),
                    );
                  },
                  child: Text('Login'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
