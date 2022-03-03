import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:gp/Levels.dart';
import 'package:gp/edit_profile%20screen.dart';
import 'package:gp/login_screen.dart';
import 'package:gp/myprofile_screen.dart';
import 'package:gp/signup%20screen.dart';

import 'Home.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
 await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
     debugShowCheckedModeBanner: false,
      //home: Edit_Proile_Screen(),
     // home: MyProfileScreen(),
      home: Login_screen(),
      //home: Login_screen(),
      //home: signup_screen(),
    );
  }
}
