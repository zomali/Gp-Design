import 'package:flutter/material.dart';

import 'question__model.dart';
import 'bindings_app.dart';
import 'custom_button.dart';
import 'answer_option.dart';
import 'progress_timer.dart';
import 'question_card.dart';
import 'quiz__screen.dart';
import 'quiz_controller.dart';
import 'result_screen.dart';
class nextButton extends StatelessWidget {
   nextButton({
    Key? key,
    required this.onPressed,
    required this.id,
     required this.total,
     this.width=140,
  }) : super(key: key);
  final Function() onPressed;
  final double width;
int id,total;
@override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: FloatingActionButton.extended(
        backgroundColor: Colors.orange,
        label: Text(
          get_text(id, total),
          style: Theme.of(context)
              .textTheme
              .headline6!
              .copyWith(color: Colors.white),
        ),
        icon: Icon(Icons.arrow_forward_ios),
        onPressed: onPressed,

      ),
    );
  }
  String get_text(int id,int total)
  {
    if(id==total)
      return "Submit";
    else
      return "Next";
  }
}
class newLevelButton extends StatelessWidget {
   newLevelButton({
    Key? key,
    required this.onPressed,
     required this.text,
    this.width=280,
  }) : super(key: key);
  final Function() onPressed;
  final double width;
  String text="";
  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: FloatingActionButton.extended(
        backgroundColor: Colors.orange,
        icon: Icon(Icons.lock_open),
        onPressed: onPressed,
        label: Text(
          "Open Next "+ text,
          style: Theme.of(context)
              .textTheme
              .headline6!
              .copyWith(color: Colors.white),
        ),
      ),
    );
  }
}
class currentLevelButton extends StatelessWidget {
  String text;
   currentLevelButton({
    Key? key,
    required this.onPressed,
    required this.text,
    this.width=280,
  }) : super(key: key);
  final Function() onPressed;
  final double width;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: FloatingActionButton.extended(
        backgroundColor: Colors.orange,
        icon: Icon(Icons.lock_open),
        onPressed: onPressed,
        label: Text(
          "Return to Current "+text,
          style: Theme.of(context)
              .textTheme
              .headline6!
              .copyWith(color: Colors.white),
        ),
      ),
    );
  }
}
class viewAnswersButton extends StatelessWidget {
  const viewAnswersButton({
    Key? key,
    required this.onPressed,
    this.width=280,
  }) : super(key: key);
  final Function() onPressed;
  final double width;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: FloatingActionButton.extended(
        backgroundColor: Colors.orange,
        icon: Icon(Icons.android),
        onPressed: onPressed,
        label: Text(
          "View Answers",
          style: Theme.of(context)
              .textTheme
              .headline6!
              .copyWith(color: Colors.white),
        ),
      ),
    );
  }
}
