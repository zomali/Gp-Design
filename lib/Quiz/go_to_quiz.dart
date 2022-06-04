import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gp/Quiz/Start_Quiz.dart';
import 'package:gp/classes/classes.dart';
import 'package:gp/classes/student.dart';
import 'package:gp/shared/cubits/cubit/question_cubit.dart';

class go_to_quiz extends StatefulWidget {
  final student std;
  final int ID;
  final String Q_type;//level or topic
  go_to_quiz(this.std, this.ID, this.Q_type);
  @override
  State<StatefulWidget> createState() => _go_to_quiz(std, ID, Q_type);
}

class _go_to_quiz extends State<go_to_quiz> {
  student std;
  int ID;
  String Q_type;
  _go_to_quiz(this.std, this.ID, this.Q_type);
  
  
  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        QuestionCubit.get(context).getQuestions(Q_type, ID, std);
        return BlocBuilder<QuestionCubit, QuestionState>(
          builder: (context, state) {
            if(state is QuestionLoading)
            {
              return Center(child: CircularProgressIndicator());
            }
            else {
              var questionCubit = QuestionCubit.get(context);
              List<Question_> questions = questionCubit.allQuestions;
              List<TopicOfWeakness_> topicsOfWeakness = [];
              if(Q_type == "Level")
              List<TopicOfWeakness_> topicsOfWeakness = questionCubit.topicsList;
              return Start_Quiz(std, ID,Q_type,topicsOfWeakness, questions);
            }
          }
        );
      }
    );
    
  }
}