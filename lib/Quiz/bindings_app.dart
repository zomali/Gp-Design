import 'package:get/get.dart';
import 'package:gp/classes/student.dart';
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
  Map<Question_,int> stuednt_asnwered={};
  final int id;
  final student std;
  String stat;
  List<int>weakness_topics=[];
  List<Question_> questions;
  BilndingsApp(this.std, this.id,this.stat,this.weakness_topics, this.questions);
  @override
  void dependencies() {
    Get.lazyPut(() => QuizController(id, std,stat,weakness_topics, questions));
  }
}
