import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gp/Levels.dart';
import 'question__model.dart';
import 'bindings_app.dart';
import 'custom_button.dart';
import 'answer_option.dart';
import 'progress_timer.dart';
import 'question_card.dart';
import 'quiz__screen.dart';
import 'quiz_controller.dart';
import 'result_screen.dart';
import 'package:gp/Levels.dart';
import 'main.dart';
class ResultScreen extends StatelessWidget {
  const ResultScreen({Key? key}) : super(key: key);
  static const routeName = '/result_screen';

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
                        width: 800,
                        height: 200,),
                    ),
                    Text(
                      'Congratulation',
                      style: Theme.of(context).textTheme.headline3!.copyWith(
                        color: Colors.blue,
                      ),
                    ),
                    Text(
                      controller.name,
                      style: Theme.of(context).textTheme.headline3!.copyWith(
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
                      '${controller.scoreResult.round()} /100',
                      style: Theme.of(context).textTheme.headline3!.copyWith(
                        color: KPrimaryColor,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    CustomButton(

                        onPressed: () => MyApp(),
                        text: 'Next Level'),
                  ],
                ),
              ),
            ),
          ],
        )));
  }
}
