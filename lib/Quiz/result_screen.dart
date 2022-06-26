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
  final student std;
  final int id;
  final String stat;
  Map<int, int> student_answers = {};
  List<Question_> questions;
  ResultScreen(
      this.std, this.id, this.student_answers, this.questions, this.stat);
  late QuizController controller;
  bool isVisible = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xFF252c4a),
        body: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 20.0,
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
                                  width: 60,
                                  height: 60,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: AssetImage(
                                          'proj_images/Ain_Shams_logo.png'),
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                ),
                              ),
                              Spacer(), //image
                              CircleAvatar(
                                radius: 40,
                                backgroundColor: Colors.transparent,
                                child: Container(
                                  width: 60,
                                  height: 60,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: AssetImage(
                                          'proj_images/faculty_logo.png'),
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                ),
                              ), //image
                            ]),
                        Column(children: [
                          Text(
                            'Structured Programming',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 35,
                                color: Colors.blue,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            '${controller.stat}' + ' : ' + '${controller.id}',
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 25, color: Colors.white),
                          ),
                        ]),
                        /*ClipRRect(

                          borderRadius: BorderRadius.circular(5),
                          child: Image.asset('proj_images/quiz.png',
                            width: 110,
                            height:110,),
                        ),*/

                        Text(
                          'Your Score is : ' +
                              '${controller.scoreResult.round()} /${controller.calculate_total_quiz_points()}',
                          style:
                              Theme.of(context).textTheme.headline4!.copyWith(
                                    color: Stat_Color(),
                                  ),
                        ),
                        Text(
                          '${controller.status.characters}',
                          textAlign: TextAlign.center,
                          style:
                              Theme.of(context).textTheme.headline5!.copyWith(
                                    color: Colors.blue,
                                  ),
                        ),
                        /*Container(
                          width: 320,
                          decoration: BoxDecoration(
                            color: Colors.green,
                            borderRadius: BorderRadius.circular(25.0),
                          ),
                          child: Row(
                            children: [
                              Icon(Icons.done,color: Colors.white,size: 40,),
                            Text(
                            'Number of right answers :  '+'${controller.number_of_correct_answer}',
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 20,color: Colors.white),
                        ),
                            ],
                          ),
                        ),
                        Container(
                          width: 320,
                          decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(25.0),
                          ),
                          child: Row(
                            children: [
                              Icon(Icons.close,color: Colors.white,size: 40,),
                              Text(
                                  'Number of wrong answers :  '+'${controller.number_of_wronge_answer}',
                                  textAlign: TextAlign.center,
                                  style:TextStyle(fontSize: 20,color: Colors.white),
                        ),
                            ],
                          ),
                        ),*/
                        viewAnswersButton(
                            onPressed: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => QuizResults(
                                        id,
                                        std,
                                        controller.get_answred(),
                                        questions,
                                        stat)))),
                        currentLevelButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => levels_view(std)));
                          },
                          text: controller.stat,
                        ),
                        Visibility(
                          visible: get_stat(controller),
                          child: newLevelButton(
                            onPressed: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => levels_view(std))),
                            text: controller.stat,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            )));
  }

  bool get_stat(QuizController controller) {
    if (controller.scoreResult.round() >
        controller.calculate_total_quiz_points() / 2) {
      return true;
    } else
      return false;
  }

  Color Stat_Color() {
    if (controller.scoreResult.round() >
        controller.calculate_total_quiz_points() / 2) {
      return Colors.green;
    } else
      return Colors.red;
  }
}
