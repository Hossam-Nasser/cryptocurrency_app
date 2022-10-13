import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:intro_flutter/provider/login_provider.dart';


import 'package:intro_flutter/view/widget/control_view.dart';
import 'package:provider/provider.dart';

import 'provider/chat_provider.dart';




void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();


  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (context) => ChatProvider()),
    ChangeNotifierProvider(create: (context) => LoginProvider()),
  ], child: MyApp()));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      home: ControlView(),
    );
  }
}


