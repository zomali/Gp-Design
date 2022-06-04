import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../classes/classes.dart';
import '../classes/student.dart';
import '../signup screen.dart';
import 'question__model.dart';
import 'quiz__screen.dart';
import 'result_screen.dart';
import 'welcome_screen.dart';
import 'bindings_app.dart';
/*
void main() {
  List<int> weakness_topics=[];
  runApp(Start_Quiz(100," ",weakness_topics));
}*/
class Start_Quiz extends StatelessWidget {
  final int id;
  final student std;
   String stat;
   List<TopicOfWeakness_> weakness_topics;
   List<Question_> questions;
  Start_Quiz(this.std, this.id,this.stat,this.weakness_topics, this.questions);
  Map<int,int> student_answered={};
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialBinding: BilndingsApp(std,id,stat,weakness_topics,questions),
      home:  WelcomeScreen(id,std,stat,weakness_topics,questions),
      getPages: [
        GetPage(name: WelcomeScreen.routeName, page: () => WelcomeScreen(id,std,stat,weakness_topics,questions)),
        GetPage(name: QuizScreen.routeName, page: () =>  QuizScreen(std,id,stat,weakness_topics,questions)),
        GetPage(name: ResultScreen.routeName, page: () =>  ResultScreen(std, id,student_answered,questions,stat)),
      ],
    );
  }
}
class AppColor {
  static final pripmaryColor = Color(0xFF252c4a);
  static final secondaryColor = Colors.blue;
}