import 'package:flutter/material.dart';
const KPrimaryColor = Colors.blue;
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
class Quiz_Analysis
{
  late int id;
  late String user_answer;
  late int topic_id;
  late int points;
  late String complexity;
  late int time_spent;
}
