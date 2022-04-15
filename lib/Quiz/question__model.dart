import 'package:flutter/material.dart';
const KPrimaryColor = Colors.blue;

class QuestionModel {
  final int id;
  final int answer;
  final String question;
  final List<String> options;

  QuestionModel(
      {required this.id,
        required this.question,
        required this.answer,
        required this.options});
}
class AnsweredQuestion {
  final int questionid;
  final int answer_index;
  AnsweredQuestion({
  required this.questionid,
  required this.answer_index,});
}



