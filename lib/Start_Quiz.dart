import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'quiz__screen.dart';
import 'result_screen.dart';
import 'welcome_screen.dart';
import 'bindings_app.dart';

void main() {
  runApp(Start_Quiz());
}

class Start_Quiz extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialBinding: BilndingsApp(),
      home:  WelcomeScreen(),
      getPages: [
        GetPage(name: WelcomeScreen.routeName, page: () => WelcomeScreen()),
        GetPage(name: QuizScreen.routeName, page: () =>  QuizScreen()),
        GetPage(name: ResultScreen.routeName, page: () =>  ResultScreen()),
      ],
    );
  }
}
class AppColor {
  static final pripmaryColor = Color(0xFF252c4a);
  static final secondaryColor = Colors.blue;
}