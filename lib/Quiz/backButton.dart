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
class backButton extends StatelessWidget {
  const backButton({
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
        backgroundColor: Colors.orange,
        icon: Icon(Icons.arrow_back_ios),
        onPressed: onPressed,
        label: Text(
          "Back",
          style: Theme.of(context)
              .textTheme
              .headline6!
              .copyWith(color: Colors.white),
        ),
      ),
    );
  }
}
