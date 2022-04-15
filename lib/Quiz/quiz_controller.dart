import 'dart:async';
import 'dart:ffi';
import 'package:flutter/animation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
import 'welcome_screen.dart';
import 'package:fluttertoast/fluttertoast.dart';
class QuizController extends GetxController{
  String name = '';
  String status='';
  //question variables
  int get countOfQuestion => _questionsList.length;
  Map<int,bool> _questionIsAnswerd={};
  final List<QuestionModel> _questionsList = [
    QuestionModel(
      id: 1,
      question:
      "Best Channel for Flutter ",
      answer: 2,
      options: ['Sec it', 'Sec it developer', 'sec it developers', 'mesh sec it '],
    ),
    QuestionModel(
      id: 2,
      question: "Best State Mangment Ststem is ",
      answer: 1,
      options: ['BloC', 'GetX', 'Provider', 'riverPod'],
    ),
    QuestionModel(
      id: 3,
      question: "Best Flutter dev",
      answer: 2,
      options: ['sherif', 'sherif ahmed', 'ahmed sherif', 'doc sherif'],
    ),
    QuestionModel(
      id: 4,
      question: "Sherif is",
      answer: 1,
      options: ['eng', 'Doc', 'eng/Doc', 'Doc/Eng'],
    ),
    QuestionModel(
      id: 5,
      question:
      "Best Rapper in Egypt",
      answer: 3,
      options: ['Eljoker', 'Abyu', 'R3', 'All of the above'],
    ),
    QuestionModel(
      id: 6,
      question: "Real Name of ahmed sherif",
      answer: 2,
      options: ['ahmed sherif', 'sherif', 'Haytham', 'NONE OF ABOVE'],
    ),
    QuestionModel(
      id: 7,
      question: "Sherif love",
      answer: 3,
      options: ['Pharma', 'Micro', 'Medicnal', 'NONE OF ABOVE'],
    ),
    QuestionModel(
      id: 8,
      question: "hello",
      answer: 3,
      options: ['hello', 'hi', 'hola', 'Suiiiiiiiiiiii'],
    ),
    QuestionModel(
      id: 9,
      question:
      "Best Channel for Flutter ",
      answer: 0,
      options: ['true', 'false'],
    ),
    QuestionModel(
      id: 10,
      question: "Best State Mangment Ststem is ",
      answer: 1,
      options: ['true', 'false'],
    ),
  ];
  List<QuestionModel> get questionsList => [..._questionsList];
  bool _isPressed = false;
  bool get isPressed => _isPressed; //To check if the answer is pressed
  int _numberOfQuestion = 1;
  int get numberOfQuestion => _numberOfQuestion;
  int? _selectAnswer;
  int? _pressedAnswer;
  int? choiced_answer;
  int? get selectAnswer => _selectAnswer;
  int? _correctAnswer;
  int _countOfCorrectAnswers = 0;
  int get countOfCorrectAnswers => _countOfCorrectAnswers;
  //map for check if the question has been answered
  static final Map<int, int?> _questionSelectedAnswerd = {};
  //page view controller
  late PageController pageController;
  //timer
  Timer? _timer;
  //min to display quiz to stident
  final maxMin = 15;
  //time in progress time design must equal maxMin variable
  final RxInt _min = 15.obs;
  RxInt get min => _min;
  int quesId=1;
  @override
  void onInit() {
    pageController = PageController(initialPage: 0);
    resetAnswer();
    super.onInit();
  }
  @override
  void onClose() {
    pageController.dispose();
    super.onClose();
  }

  //get final score
  double get scoreResult {
    return _countOfCorrectAnswers * 100 / _questionsList.length;
  }
  void checkStatusOfStudent(){
    if(scoreResult>80)
    {
      status="Congratulations";
    }
    else if(scoreResult==0)
    {
      status="Very frustrating. You have to change the way you study";
    }
    else if(scoreResult<50)
    {
      status="You Must Study Well, You Will Repeat This Level";
    }
    else{
      status="Not bad, but you should study more";
    }
  }
  void marked_answer(QuestionModel questionModel,int selectAnswer)
  {
    _isPressed=true;
    _pressedAnswer=selectAnswer;
    _questionIsAnswerd.update(questionModel.id, (value) => true);
    _questionSelectedAnswerd[questionModel.id]=_pressedAnswer;
    update();
  }
  Map<int,int?> get_answred()
  {
    return _questionSelectedAnswerd;
  }
  void calculate_score()
  {
    for(int i=0;i<questionsList.length;i++) {
      if(checkIsQuestionAnswered(questionsList[i].id))
      {
        int? selected_answer=get_index_of_selected_answer(questionsList[i]);
        if(selected_answer==null)
        {
          selected_answer=9;
        }
        if (questionsList[i].answer==selected_answer) {
          _countOfCorrectAnswers++;
        }
      }
    }
  }
  // ignore: non_constant_identifier_names
  QuestionModel get_question_model(int quesID)
  {
    for(int i=0;i<questionsList.length;i++)
    {
      if(questionsList[i].id==quesID)
      {
        return questionsList[i];
      }
    }
    return questionsList[0];
  }
  //check if the question has been answered
  bool checkIsQuestionAnswered(int quesId) {
    return _questionIsAnswerd.entries
        .firstWhere((element) => element.key == quesId)
        .value;
  }
  void resetAnswer() {
    for (var element in _questionsList) {
      _questionIsAnswerd.addAll({element.id: false});
    }
    update();
  }
  // ignore: non_constant_identifier_names
  int? get_index_of_selected_answer(QuestionModel questionModel)
  {
    return _questionSelectedAnswerd.entries
        .firstWhere((element) => element.key == questionModel.id)
        .value;
  }
  void nextQuestion() {
    _isPressed=false;

    if(quesId >= _questionsList.length || _min.value==0) {
      calculate_score();
      checkStatusOfStudent();
      Get.offAndToNamed(ResultScreen.routeName);
    }
    else
    {
      quesId++;
      // ignore: unnecessary_statements
      QuestionModel current_question =get_question_model(quesId);
      if(checkIsQuestionAnswered(current_question.id))
      {
        choiced_answer=get_index_of_selected_answer(current_question);
        if(choiced_answer!=null) {
          marked_answer(current_question, choiced_answer!);
          update();
        }
      }
      _numberOfQuestion =current_question.id;
      update();
      pageController.nextPage(
          duration: const Duration(milliseconds: 300), curve: Curves.linear);
    }
  }
  void previousQuestion() {
    _isPressed=false;
    if ((quesId) > 1)
    {
      quesId--;
      if (_min.value == 0) {
        calculate_score();
        checkStatusOfStudent();
        Get.offAndToNamed(ResultScreen.routeName);
      } else {
        QuestionModel current_question =get_question_model(quesId);
        if (checkIsQuestionAnswered(current_question.id )) {
          choiced_answer = get_index_of_selected_answer(current_question);
          if (choiced_answer != null) {
            marked_answer(current_question, choiced_answer!);
            update();
          }
        }
        _numberOfQuestion =  quesId;
        update();
        pageController.previousPage(
            duration: const Duration(milliseconds: 300),
            curve: Curves.linear);
      }
    }
  }
  //get right and wrong color
  Color getColor(int answerIndex) {
    if(_isPressed) {
      if (answerIndex == _pressedAnswer) {
        return Color(0xFF252c4a);
      }
    }
    return Colors.white;
  }
  void startTimer() {
    resetTimer();
    _timer = Timer.periodic(const Duration(minutes: 1), (timer) {
      if (_min.value > 1) {
        _min.value--;
      } else {
        stopTimer();
        Get.offAndToNamed(ResultScreen.routeName);
        //nextQuestion();
      }
    });
  }
  void get_colors_answer(QuestionModel questionModel, int selectAnswer) {
    _isPressed = true;
    _selectAnswer = selectAnswer;
    _correctAnswer = questionModel.answer;
  }

  //get right and wrong color
  Color getColors_of_answeres(int answerIndex) {
    if (_isPressed) {
      if (answerIndex == _correctAnswer) {
        return Colors.green.shade700;
      } else if (answerIndex == _selectAnswer &&
          _correctAnswer != _selectAnswer) {
        return Colors.red.shade700;
      }
    }
    return Colors.white;
  }

  //het right and wrong icon
  IconData getIcon(int answerIndex) {
    if (_isPressed) {
      if (answerIndex == _correctAnswer) {
        return Icons.done;
      } else if (answerIndex == _selectAnswer &&
          _correctAnswer != _selectAnswer) {
        return Icons.close;
      }
    }
    return Icons.close;
  }
  void resetTimer() => _min.value = maxMin;
  void stopTimer() => _timer!.cancel();
}
