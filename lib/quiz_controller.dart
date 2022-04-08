import 'dart:async';

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

class QuizController extends GetxController{
  String name = '';
  String status='';
  //question variables
  int get countOfQuestion => _questionsList.length;
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
      answer: 2,
      options: ['Sec it', 'Sec it developer', 'sec it developers', 'mesh sec it '],
    ),
    QuestionModel(
      id: 10,
      question: "Best State Mangment Ststem is ",
      answer: 1,
      options: ['BloC', 'GetX', 'Provider', 'riverPod'],
    ),
  ];

  List<QuestionModel> get questionsList => [..._questionsList];


  bool _isPressed = false;


  bool get isPressed => _isPressed; //To check if the answer is pressed


  double _numberOfQuestion = 1;


  double get numberOfQuestion => _numberOfQuestion;


  int? _selectAnswer;


  int? get selectAnswer => _selectAnswer;


  int? _correctAnswer;


  int _countOfCorrectAnswers = 0;


  int get countOfCorrectAnswers => _countOfCorrectAnswers;
  //map for check if the question has been answered
  final Map<int, bool> _questionIsAnswerd = {};
  //page view controller
  late PageController pageController;

  //timer
  Timer? _timer;
  //min to display quiz to stident
  final maxMin = 15;
  //time in progress time design must equal maxMin variable
  final RxInt _min = 15.obs;
  RxInt get min => _min;
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
  void checkAnswer(QuestionModel questionModel, int selectAnswer) {
    _isPressed = true;

    _selectAnswer = selectAnswer;
    _correctAnswer = questionModel.answer;

    if (_correctAnswer == _selectAnswer) {
      _countOfCorrectAnswers++;
    }
    //stopTimer();
    _questionIsAnswerd.update(questionModel.id, (value) => true);
    Future.delayed(const Duration(milliseconds: 500)).then((value) => nextQuestion());
    update();
  }

  //check if the question has been answered
  bool checkIsQuestionAnswered(int quesId) {
    return _questionIsAnswerd.entries
        .firstWhere((element) => element.key == quesId)
        .value;
  }

  void nextQuestion() {
    if (_timer != null || _timer!.isActive) {
      stopTimer();
    }
    if (pageController.page == _questionsList.length - 1 || _min.value==0) {
      checkStatusOfStudent();
      Get.offAndToNamed(ResultScreen.routeName);
    } else {
      _isPressed = false;
      pageController.nextPage(
          duration: const Duration(milliseconds: 500), curve: Curves.linear);

      //startTimer();
    }
    _numberOfQuestion = pageController.page! + 2;
    update();
  }

  //called when start again quiz
  void resetAnswer() {
    for (var element in _questionsList) {
      _questionIsAnswerd.addAll({element.id: false});
    }
    update();
  }

  //get right and wrong color
  Color getColor(int answerIndex) {
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

  void resetTimer() => _min.value = maxMin;

  void stopTimer() => _timer!.cancel();
//call when start again quiz
/*void startAgain() {
    _correctAnswer = null;
    _countOfCorrectAnswers = 0;
    resetAnswer();
    _selectAnswer = null;
    Get.offAllNamed(WelcomeScreen.routeName);
  }*/
}
