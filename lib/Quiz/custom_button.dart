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
  const nextButton({
    Key? key,
    required this.onPressed,
    this.width=140,
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
        backgroundColor: KPrimaryColor,
        icon: Icon(Icons.arrow_forward_ios),
        onPressed: onPressed,
        label: Text(
          "Next",
          style: Theme.of(context)
              .textTheme
              .headline6!
              .copyWith(color: Colors.white),
        ),
      ),
    );
  }
}
class newLevelButton extends StatelessWidget {
  const newLevelButton({
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
        backgroundColor: KPrimaryColor,
        icon: Icon(Icons.lock_rounded),
        onPressed: onPressed,
        label: Text(
          "Open Next Level",
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
  const currentLevelButton({
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
        backgroundColor: KPrimaryColor,
        icon: Icon(Icons.lock_open),
        onPressed: onPressed,
        label: Text(
          "Return to Current Level",
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
        backgroundColor: KPrimaryColor,
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