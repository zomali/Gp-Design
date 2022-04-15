import 'package:get/get.dart';
import 'question__model.dart';
import 'bindings_app.dart';
import 'custom_button.dart';
import 'answer_option.dart';
import 'progress_timer.dart';
import 'question_card.dart';
import 'quiz__screen.dart';
import 'quiz_controller.dart';
import 'result_screen.dart';

class BilndingsApp implements Bindings {
  Map<QuestionModel,int> stuednt_asnwered={};
  @override
  void dependencies() {
    Get.lazyPut(() => QuizController());
  }
}
