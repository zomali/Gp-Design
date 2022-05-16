import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'question__model.dart';
import 'quiz_controller.dart';
import 'result_screen.dart';

class ProgressTimer extends StatelessWidget {
  ProgressTimer({Key? key}) : super(key: key);
  final controller = Get.find<QuizController>();
  @override
  Widget build(BuildContext context) {
    return Obx(
          () => SizedBox(
        height: 50,
        width: 50,
        child: Stack(
          alignment: Alignment.center,
          fit: StackFit.expand,
          children: [
            CircularProgressIndicator(
              value: 1 - (controller.min.value / 15),
              color: KPrimaryColor,
              backgroundColor: Colors.white,
              strokeWidth: 8,
            ),
            Center(
              child: Text(
                '${controller.min.value}',
                style: Theme.of(context)
                    .textTheme
                    .headline6!
                    .copyWith(color: Colors.blue),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
