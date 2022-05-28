import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'backButton.dart';
import 'quiz_controller.dart';


class AnswerOption extends StatelessWidget {
  const AnswerOption({
    Key? key,
    required this.text,
    required this.index,
    required this.questionId,
    required this.onPressed,
  }) : super(key: key);

  final String text;
  final int index;
  final int questionId;
  final Function() onPressed;
  @override
  Widget build(BuildContext context) {
    List<String>chars=['A','B','C','D'];
    return GetBuilder<QuizController>(
      init: Get.find<QuizController>(),
      builder: (controller) => InkWell(
          onTap: controller.checkIsQuestionAnswered(questionId) ? null : onPressed,
          child: Container(
            width: double.infinity,

            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                border:
                Border.all(width: 3, color: controller.getColor(index))),
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Wrap(
                //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  RichText(
                    text: TextSpan(
                        text: '${chars[index]}. ',
                        style: Theme.of(context).textTheme.headline6?.copyWith(color: Colors.white),
                        children: [
                          TextSpan(
                            text: text,
                            style: Theme.of(context).textTheme.headline6?.copyWith(color: Colors.white),
                          ),
                        ]),
                  ),
                  if (controller.checkIsQuestionAnswered(questionId) &&
                      controller.selectAnswer == index)
                    Container(
                        width: 30,
                        height: 60,
                        padding: EdgeInsets.only(left: 10,right: 10),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            color: controller.getColor(index),
                            border: Border.all(
                              color: Colors.white,
                              width: 3,
                            ),
                            shape: BoxShape.circle),
                        )
                ],
              ),
            ),
          ),
      ),
    );
  }
}
