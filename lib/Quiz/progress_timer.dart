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
        height: 70,
        width: 70,
        child: Stack(
          alignment: Alignment.center,
          fit: StackFit.expand,
          children: [
            CircularProgressIndicator(
              value: 1 - (controller.min.value / controller.maxMin),
              color: get_color(controller.min.value),
              backgroundColor: Colors.white,
              strokeWidth: 8,
            ),
            Center(
              child: Text(
                '${controller.min.value}'+':'+'${controller.sec.value}',
                style: Theme.of(context)
                    .textTheme
                    .headline6!
                    .copyWith(color: get_color(controller.min.value)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
Color get_color(int min)
{
  if(min>4)
    return Colors.orange;
  else 
    return Colors.red;
}