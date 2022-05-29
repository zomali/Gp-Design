import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gp/Levels_View.dart';
import 'package:gp/Quiz/quiz_result.dart';
import 'package:gp/classes/student.dart';
import '../classes/classes.dart';
import 'question__model.dart';
import 'custom_button.dart';
import 'quiz_controller.dart';
class ResultScreen extends StatelessWidget {
  static const routeName = '/result_screen';
  final int id;
  final String stat;
  Map<int,int> student_answers={};
  List<Question_>questions;
  ResultScreen(this.id,this.student_answers,this.questions,this.stat);
  late student std;
  late QuizController controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xFF252c4a),
        body: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 48.0,
              horizontal: 12.0,
            ),
            child: Stack(
              children: [
                Center(
                  child: GetBuilder<QuizController>(
                    init: Get.find<QuizController>(),
                    builder: (controller) => Column(
                      mainAxisAlignment: MainAxisAlignment.values[5],
                      children: [
                        Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              CircleAvatar(
                                radius: 40,
                                backgroundColor: Colors.transparent,
                                child: Container(
                                  width: 90,
                                  height: 90,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: AssetImage(
                                          'proj_images/Ain_Shams_logo.png'),
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                ),
                              ), //image
                              Spacer(),
                              CircleAvatar(
                                radius: 40,
                                backgroundColor: Colors.transparent,
                                child: Container(
                                  width: 80,
                                  height: 80,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: AssetImage('proj_images/faculty_logo.png'),
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                ),
                              ), //image
                            ]
                        ),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(5),
                          child: Image.asset('proj_images/quiz.png',
                            width: 150,
                            height: 150,),
                        ),
                        Text(
                          '${controller.status.characters}',
                          style: Theme.of(context).textTheme.headline5!.copyWith(
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          controller.name,
                          style: Theme.of(context).textTheme.headline6!.copyWith(
                            color: KPrimaryColor,
                          ),
                        ),
                        Text(
                          'Your Score is',
                          style: Theme.of(context).textTheme.headline4!.copyWith(
                            color: Colors.blue,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          '${controller.scoreResult.round()} /${controller.calculate_total_quiz_points()}',
                          style: Theme.of(context).textTheme.headline3!.copyWith(
                            color: KPrimaryColor,
                          ),
                        ),
                        SizedBox(height: 20,),
                        viewAnswersButton(
                            onPressed: () =>  Navigator.push(context,
                                MaterialPageRoute(builder: (context) => QuizResults(id,controller.get_answred(),questions,stat)))),
                        const SizedBox(
                          height: 5,
                        ),
                        newLevelButton(
                            onPressed: () =>  Navigator.push(context,
                                MaterialPageRoute(builder: (context) => levels_view(std)))),
                        SizedBox(height: 5,),
                        currentLevelButton(
                            onPressed: () =>  Navigator.push(context,
                                MaterialPageRoute(builder: (context) => levels_view(std)))),
                      ],
                    ),
                  ),
                ),
              ],
            )));
  }
}
