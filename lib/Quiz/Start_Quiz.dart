import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'question__model.dart';
import 'quiz__screen.dart';
import 'result_screen.dart';
import 'welcome_screen.dart';
import 'bindings_app.dart';

void main() {
  runApp(Start_Quiz("0"));
}
class Start_Quiz extends StatelessWidget {
  late String level;
  Start_Quiz(this.level);
  Map<int,int> student_answered={};
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialBinding: BilndingsApp(),
      home:  WelcomeScreen(level),
      getPages: [
        GetPage(name: WelcomeScreen.routeName, page: () => WelcomeScreen(level)),
        GetPage(name: QuizScreen.routeName, page: () =>  QuizScreen(level)),
        GetPage(name: ResultScreen.routeName, page: () =>  ResultScreen(1,student_answered)),
      ],
    );
  }
}
class AppColor {
  static final pripmaryColor = Color(0xFF252c4a);
  static final secondaryColor = Colors.blue;
}