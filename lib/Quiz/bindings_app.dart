import 'package:get/get.dart';
import '../classes/classes.dart';
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
  final int id;
  String stat;
  List<int>weakness_topics=[];
  BilndingsApp(this.id,this.stat,this.weakness_topics);
  @override
  void dependencies() {
    Get.lazyPut(() => QuizController(id,stat,weakness_topics));
  }
}
