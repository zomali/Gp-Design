import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../classes/classes.dart';
import 'question__model.dart';
import 'answer_option.dart';
import 'quiz_controller.dart';
class QuestionCard extends StatelessWidget {
  final Question_ questionModel;
  const QuestionCard({
    Key? key,
    required this.questionModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height=50;
     height = MediaQuery.of(context).size.height/3*2;
    return SingleChildScrollView(
      child: Container(
          height: height,
          margin: const EdgeInsets.symmetric(horizontal: 20.0),
          decoration: BoxDecoration(
            color: Colors.blue,
            borderRadius: BorderRadius.circular(25.0),
          ),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                   SingleChildScrollView(
                    //for horizontal scrolling
                    scrollDirection: Axis.vertical,
                    child: Text(
                      questionModel.question,
                      style: Theme.of(context).textTheme.headline5?.copyWith(color: Colors.white),
                    ),
                  ),
                SizedBox(height: 70,),
                ...List.generate(
                    questionModel.choices.length,
                        (index) =>
                        Column(
                          children: [
                            AnswerOption(
                              questionId: questionModel.id,
                              text: questionModel.choices[index],
                              index: index,
                              onPressed: () =>
                                  Get.find<QuizController>()
                                      .marked_answer(questionModel,index),
                            ),
                            const SizedBox(
                              height: 5,
                            )
                          ],
                        )),
              ],
            ),
          )),
    );
  }
}
