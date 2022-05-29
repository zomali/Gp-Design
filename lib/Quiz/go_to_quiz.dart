import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gp/Quiz/Start_Quiz.dart';
import 'package:gp/classes/classes.dart';
import 'package:gp/shared/cubits/cubit/question_cubit.dart';

import '../classes/student.dart';

class go_to_quiz extends StatefulWidget {
  final int ID;
  final String Q_type;//level or topic
  final List<int> weakness_topics;
  go_to_quiz(this.ID, this.Q_type, this.weakness_topics);
  @override
  State<StatefulWidget> createState() => _go_to_quiz(ID, Q_type, weakness_topics);
}

class _go_to_quiz extends State<go_to_quiz> {
  int ID;
  String Q_type;
  List<int> weakness_topics;
  _go_to_quiz(this.ID, this.Q_type, this.weakness_topics );
  
  
  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        QuestionCubit.get(context).getQuestions(Q_type, ID);
        return BlocBuilder<QuestionCubit, QuestionState>(
          builder: (context, state) {
            if(state is QuestionLoading)
            {
              return Center(child: CircularProgressIndicator());
            }
            else {
              var questionCubit = QuestionCubit.get(context);
              List<Question_> questions = questionCubit.allQuestions;
              return Start_Quiz(ID,Q_type,weakness_topics, questions);
            }
          }
        );
      }
    );
    
  }
}