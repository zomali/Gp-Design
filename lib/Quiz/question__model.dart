import 'package:flutter/material.dart';
const KPrimaryColor = Colors.blue;

class QuestionModel {
  final int id;
  final int answer;
  final String question;
  final List<String> options;
  final String complexity;
  final int topic_id;
  final int points;
  final int level_id;

  QuestionModel({required this.id,
    required this.question,
    required this.answer,
    required this.options,
    required this.complexity,
    required this.points,
    required this.topic_id,
    required this.level_id,
  });
}
class AnsweredQuestion {
  final int questionid;
  final int answer_index;
  AnsweredQuestion({
  required this.questionid,
  required this.answer_index,});
}

class Levels
{
  final int level_id;
  final List<int> topics_id;
  Levels({
    required this.level_id,
    required this.topics_id});
}

