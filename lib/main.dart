import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:gp/L_types.dart';
import 'package:gp/Levels.dart';
import 'package:gp/URL_view.dart';
import 'package:gp/edit_profile%20screen.dart';
import 'package:gp/login_screen.dart';
import 'package:gp/myprofile_screen.dart';
import 'package:gp/pdf_view.dart';
import 'package:gp/signup%20screen.dart';
import 'package:gp/audio_player.dart';
import 'Home.dart';
import 'topic_images.dart';

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
     // home: pdf_view(),
      home: Login_screen(),
     // home: Home(0),
     // home: types(),
      //home: signup_screen(),
     // home: audio_player(),
    );
  }
}
