import 'dart:async';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'question__model.dart';
import 'result_screen.dart';
import "dart:math";
import 'package:gp/classes/student.dart';
import 'package:gp/classes/classes.dart';
class QuizController extends GetxController{
  final int id;
  String? stat;
   List<int> weakness_topics;
  QuizController(this.id,this.stat,this.weakness_topics);
  //QuizController();
  String name = '';
  String status = '';
  //list of all questions
  final List<QuestionModel> _questionList = [
    //topic 1 questions
    QuestionModel(
      id: 1,
      question: "1-A ",
      answer: 2,
      options: ['Sec it', 'Sec it developer', 'sec it developers', 'mesh sec it '],
      complexity: "easy",
      topic_id: 1,
      points: 2,
      level_id: 1,
    ),
    QuestionModel(
      id: 2,
      question: "1-B ",
      answer: 1,
      options: ['BloC', 'GetX', 'Provider', 'riverPod'],
      complexity: "easy",
      topic_id: 1,
      points: 2,
      level_id: 1,
    ),

    QuestionModel(
      id: 5,
      question: "1-E",
      answer: 3,
      options: ['Eljoker', 'Abyu', 'R3', 'All of the above'],
      complexity: "medium",
      topic_id: 1,
      points: 2,
      level_id: 1,
    ),
    QuestionModel(
      id: 3,
      question: "1-C",
      answer: 2,
      options: ['sherif', 'sherif ahmed', 'ahmed sherif', 'doc sherif'],
      complexity: "medium",
      topic_id: 1,
      points: 2,
      level_id: 1,
    ),
    QuestionModel(
      id: 4,
      question: "1-D",
      answer: 1,
      options: ['eng', 'Doc', 'eng/Doc', 'Doc/Eng'],
      complexity: "hard",
      topic_id: 1,
      points: 2,
      level_id: 1,
    ),
    QuestionModel(
      id: 6,
      question: "1-F",
      answer: 2,
      options: ['ahmed sherif', 'sherif', 'Haytham', 'NONE OF ABOVE'],
      complexity: "hard",
      topic_id: 1,
      points: 2,
      level_id: 1,
    ),
    //questions on topic 2
    QuestionModel(
      id: 8,
      question: "2-H",
      answer: 3,
      options: ['hello', 'hi', 'hola', 'Suiiiiiiiiiiii'],
      complexity: "easy",
      topic_id: 2,
      points: 2,
      level_id: 1,
    ),
    QuestionModel(
      id: 7,
      question: "2-G",
      answer: 3,
      options: ['Pharma', 'Micro', 'Medicnal', 'NONE OF ABOVE'],
      complexity: "easy",
      topic_id: 2,
      points: 2,
      level_id: 1,
    ),
    QuestionModel(
      id: 9,
      question:
      "2-I ",
      answer: 0,
      options: ['true', 'false'],
      complexity: "hard",
      topic_id: 2,
      points: 2,
      level_id: 1,
    ),
    QuestionModel(
      id: 10,
      question: "2-K ",
      answer: 1,
      options: ['true', 'false'],
      complexity: "hard",
      topic_id: 2,
      points: 2,
      level_id: 1,
    ),
    QuestionModel(
      id: 11,
      question:
      "2-K",
      answer: 3,
      options: ['Eljoker', 'Abyu', 'R3', 'All of the above'],
      complexity: "medium",
      topic_id: 2,
      points: 2,
      level_id: 1,
    ),
    QuestionModel(
      id: 12,
      question: "2-M",
      answer: 2,
      options: ['ahmed sherif', 'sherif', 'Haytham', 'NONE OF ABOVE'],
      complexity: "medium",
      topic_id: 2,
      points: 2,
      level_id: 1,
    ),
    //questions on topic 3
    QuestionModel(
      id: 13,
      question: "3-N",
      answer: 3,
      options: ['Pharma', 'Micro', 'Medicnal', 'NONE OF ABOVE'],
      complexity: "hard",
      topic_id: 3,
      points: 2,
      level_id: 1,
    ),
    QuestionModel(
      id: 14,
      question: "3-V",
      answer: 3,
      options: ['hello', 'hi', 'hola', 'Suiiiiiiiiiiii'],
      complexity: "easy",
      topic_id: 3,
      points: 2,
      level_id: 1,
    ),
    QuestionModel(
      id: 15,
      question:
      "3-Y",
      answer: 0,
      options: ['true', 'false'],
      complexity: "hard",
      topic_id: 3,
      points: 2,
      level_id: 1,
    ),
    QuestionModel(
      id: 16,
      question: "3-U ",
      answer: 1,
      options: ['true', 'false'],
      complexity: "easy",
      topic_id: 3,
      points: 2,
      level_id: 1,
    ),
    QuestionModel(
      id: 17,
      question:
      "3-z",
      answer: 0,
      options: ['true', 'false'],
      complexity: "medium",
      topic_id: 3,
      points: 2,
      level_id: 1,
    ),
    QuestionModel(
      id: 18,
      question: "3-w ",
      answer: 1,
      options: ['true', 'false'],
      complexity: "medium",
      topic_id: 3,
      points: 2,
      level_id: 1,
    ),
    QuestionModel(
      id: 19,
      question: "1-A ",
      answer: 2,
      options: ['Sec it', 'Sec it developer', 'sec it developers', 'mesh sec it '],
      complexity: "easy",
      topic_id: 1,
      points: 2,
      level_id: 1,
    ),
    QuestionModel(
      id: 20,
      question: "1-B ",
      answer: 1,
      options: ['BloC', 'GetX', 'Provider', 'riverPod'],
      complexity: "easy",
      topic_id: 1,
      points: 2,
      level_id: 1,
    ),

    QuestionModel(
      id: 21,
      question: "1-E",
      answer: 3,
      options: ['Eljoker', 'Abyu', 'R3', 'All of the above'],
      complexity: "medium",
      topic_id: 1,
      points: 2,
      level_id: 1,
    ),
    QuestionModel(
      id: 22,
      question: "1-C",
      answer: 2,
      options: ['sherif', 'sherif ahmed', 'ahmed sherif', 'doc sherif'],
      complexity: "medium",
      topic_id: 1,
      points: 2,
      level_id: 1,
    ),
    QuestionModel(
      id: 23,
      question: "1-D",
      answer: 1,
      options: ['eng', 'Doc', 'eng/Doc', 'Doc/Eng'],
      complexity: "hard",
      topic_id: 1,
      points: 2,
      level_id: 1,
    ),
    QuestionModel(
      id: 24,
      question: "1-F",
      answer: 2,
      options: ['ahmed sherif', 'sherif', 'Haytham', 'NONE OF ABOVE'],
      complexity: "hard",
      topic_id: 1,
      points: 2,
      level_id: 1,
    ),
    //questions on topic 2
    QuestionModel(
      id: 25,
      question: "2-H",
      answer: 3,
      options: ['hello', 'hi', 'hola', 'Suiiiiiiiiiiii'],
      complexity: "easy",
      topic_id: 2,
      points: 2,
      level_id: 1,
    ),
    QuestionModel(
      id: 26,
      question: "2-G",
      answer: 3,
      options: ['Pharma', 'Micro', 'Medicnal', 'NONE OF ABOVE'],
      complexity: "easy",
      topic_id: 2,
      points: 2,
      level_id: 1,
    ),
    QuestionModel(
      id: 27,
      question:
      "2-I ",
      answer: 0,
      options: ['true', 'false'],
      complexity: "hard",
      topic_id: 2,
      points: 2,
      level_id: 1,
    ),
    QuestionModel(
      id: 28,
      question: "2-K ",
      answer: 1,
      options: ['true', 'false'],
      complexity: "hard",
      topic_id: 2,
      points: 2,
      level_id: 1,
    ),
    QuestionModel(
      id: 29,
      question:
      "2-K",
      answer: 3,
      options: ['Eljoker', 'Abyu', 'R3', 'All of the above'],
      complexity: "medium",
      topic_id: 2,
      points: 2,
      level_id: 1,
    ),
    QuestionModel(
      id: 30,
      question: "2-M",
      answer: 2,
      options: ['ahmed sherif', 'sherif', 'Haytham', 'NONE OF ABOVE'],
      complexity: "medium",
      topic_id: 2,
      points: 2,
      level_id: 1,
    ),
    //questions on topic 3
    QuestionModel(
      id: 31,
      question: "3-N",
      answer: 3,
      options: ['Pharma', 'Micro', 'Medicnal', 'NONE OF ABOVE'],
      complexity: "hard",
      topic_id: 3,
      points: 2,
      level_id: 1,
    ),
    QuestionModel(
      id: 32,
      question: "3-V",
      answer: 3,
      options: ['hello', 'hi', 'hola', 'Suiiiiiiiiiiii'],
      complexity: "easy",
      topic_id: 3,
      points: 2,
      level_id: 1,
    ),
    QuestionModel(
      id: 33,
      question:
      "3-Y",
      answer: 0,
      options: ['true', 'false'],
      complexity: "hard",
      topic_id: 3,
      points: 2,
      level_id: 1,
    ),
    QuestionModel(
      id: 34,
      question: "3-U ",
      answer: 1,
      options: ['true', 'false'],
      complexity: "easy",
      topic_id: 3,
      points: 2,
      level_id: 1,
    ),
    QuestionModel(
      id: 35,
      question:
      "3-z",
      answer: 0,
      options: ['true', 'false'],
      complexity: "medium",
      topic_id: 3,
      points: 2,
      level_id: 1,
    ),
    QuestionModel(
      id: 36,
      question: "3-w ",
      answer: 1,
      options: ['true', 'false'],
      complexity: "medium",
      topic_id: 3,
      points: 2,
      level_id: 1,
    ),
  ];
  //contain all question of level
  List<QuestionModel> get questionsList => [..._questionList];
  //get quiz question for every student
  final List<QuestionModel> quiz_question=[];
  final List<Levels> levels=[
    Levels(level_id: 1, topics_id: [1,2,3]),
    Levels(level_id: 2, topics_id: [4,5,6]),
    Levels(level_id: 3, topics_id: [7,8,9,10]),
    Levels(level_id: 4, topics_id: [11,12,13]),
    Levels(level_id: 5, topics_id: [14,15,16,17]),
  ];
  //stat= quiz on topic or level
  //id = level id or topic id
  //generate quiz on topic
  void generate_random_quiz_for_topic<QuestionModel>(int topic_id) {
    final random = new Random();
    int count =0;
    //if stat=topic
    while(quiz_question.length!=10) {
      int easy_count = 0,
          meduim_count = 0,
          hard_count = 0;
      int index = random.nextInt(questionsList.length-1);
      if (questionsList[index].topic_id == topic_id && !quiz_question.contains(questionsList[index])) {
        if (questionsList[index].complexity == "easy") {
          if (easy_count < 4) {
            quiz_question.add(questionsList[index]);
            easy_count++;
          }
        }
        if (questionsList[index].complexity == "medium") {
          if (meduim_count < 3) {
            quiz_question.add(questionsList[index]);
            meduim_count++;
          }
        }
        if (questionsList[index].complexity == "hard") {
          if (hard_count < 3) {
            quiz_question.add(questionsList[index]);
            hard_count++;
          }
        }
      }
    }
  }
  //generate quiz on level
  void generate_random_quiz_for_level<QuestionModel>(int id,List<int> weakness_topics) {
    final random = new Random();
    bool all_weakness=false;
    int topic_count=1,i=-1;
    if(weakness_topics.length==levels[id-1].topics_id.length) {
      all_weakness = true;
    }
    if(all_weakness!=true)
    {
      while(topic_count!=levels[id-1].topics_id.length &&i<levels[id-1].topics_id.length-1)
        {
          int easy_count = 0, meduim_count = 0, hard_count = 0;
          i++;
          if(weakness_topics.contains(levels[id-1].topics_id[i]))
            {
              while ((easy_count + meduim_count + hard_count) != 4) {
                int index = random.nextInt(questionsList.length-1);
                if (questionsList[index].topic_id ==levels[id-1].topics_id[i] && !quiz_question.contains(questionsList[index])) {
                  if (questionsList[index].complexity == "easy") {
                    if (easy_count < 1) {
                      quiz_question.add(questionsList[index]);
                      easy_count++;
                      topic_count++;
                    }
                  }
                  if (questionsList[index].complexity == "medium") {
                    if (meduim_count < 2) {
                      quiz_question.add(questionsList[index]);
                      meduim_count++;
                      topic_count++;
                    }
                  }
                  if (questionsList[index].complexity == "hard") {
                    if (hard_count < 1) {
                      quiz_question.add(questionsList[index]);
                      hard_count++;
                      topic_count++;
                    }
                  }
                }
              }
            }
          else
            {
              int easy_count = 0, meduim_count = 0, hard_count = 0;
              while ((easy_count + meduim_count + hard_count) != 3) {
                int index = random.nextInt(questionsList.length-1);
                if (questionsList[index].topic_id == levels[id-1].topics_id[i] && !quiz_question.contains(questionsList[index])) {
                  if (questionsList[index].complexity == "easy") {
                    if (easy_count < 1) {
                      quiz_question.add(questionsList[index]);
                      easy_count++;
                      topic_count++;
                      continue;
                    }
                  }
                  if (questionsList[index].complexity == "medium") {
                    if (meduim_count < 1) {
                      quiz_question.add(questionsList[index]);
                      meduim_count++;
                      topic_count++;
                      continue;
                    }
                  }
                  if (questionsList[index].complexity == "hard") {
                    if (hard_count < 1) {
                      quiz_question.add(questionsList[index]);
                      hard_count++;
                      topic_count++;
                      continue;
                    }
                  }
                }
              }
            }
        }
    }
    else {
      int weak_topics_count=0;
      while (weak_topics_count<=levels[id-1].topics_id.length-1) {
        int easy_count = 0, meduim_count = 0, hard_count = 0;
        while ((easy_count + meduim_count + hard_count) != 4) {
          int index = random.nextInt(questionsList.length-1);
          if (!quiz_question.contains(questionsList[index]) && questionsList[index].topic_id==levels[id-1].topics_id[weak_topics_count]) {
            if (questionsList[index].complexity == "easy") {
              if (easy_count < 1) {
                quiz_question.add(questionsList[index]);
                easy_count++;
              }
            }
            if (questionsList[index].complexity == "medium") {
              if (meduim_count < 2) {
                quiz_question.add(questionsList[index]);
                meduim_count++;
              }
            }
            if (questionsList[index].complexity == "hard") {
              if (hard_count < 1) {
                quiz_question.add(questionsList[index]);
                hard_count++;
              }
            }
          }
        }
        weak_topics_count++;
      }
    }
  }
  //question variables
  int get countOfQuestion => quiz_question.length;
  Map<int,bool> _questionIsAnswerd={};
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
  int quesId=0;
  @override
  void onInit() {
    pageController = PageController(initialPage: 0);
    Fluttertoast.showToast(msg: id.toString());
    if(stat=="topic")
      {
        generate_random_quiz_for_topic(id);
      }
    if(stat=="level")
      {
        generate_random_quiz_for_level(id,weakness_topics);
      }
    resetAnswer();
    super.onInit();
  }
  @override
  void onClose() {
    pageController.dispose();
    quiz_question.clear();
    super.onClose();
  }
  double get scoreResult {
    return _countOfCorrectAnswers * 100 / quiz_question.length;
  }
  int calculate_total_quiz_points()
  {
    int total_score=0;
    for(int i=0;i<quiz_question.length;i++)
      {
        total_score+=quiz_question[i].points;
      }
    return total_score;
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
  void marked_answer(QuestionModel questionModel,int selectAnswer) {
    _isPressed=true;
    _pressedAnswer=selectAnswer;
    update();
  }
  Map<int,int?> get_answred() {
    return _questionSelectedAnswerd;
  }
  void calculate_score() {
    for(int i=0;i<quiz_question.length;i++) {
      if(checkIsQuestionAnswered(quiz_question[i].id))
      {
        int? selected_answer=get_index_of_selected_answer(quiz_question[i]);
        if(selected_answer==null)
        {
          continue;
        }
        if (quiz_question[i].answer==selected_answer) {
          _countOfCorrectAnswers++;
        }
      }
    }
  }
  QuestionModel get_question_model(int quesID){
    for(int i=0;i<quiz_question.length;i++)
    {
      if(quiz_question[i].id==quesID)
      {
        return quiz_question[i];
      }
    }
    return quiz_question[0];
  }
  //check if the question has been answered
  bool checkIsQuestionAnswered(int quesId) {
    return _questionIsAnswerd.entries
        .firstWhere((element) => element.key == quesId)
        .value;
  }
  void resetAnswer() {
    for (var element in questionsList) {
      _questionIsAnswerd.addAll({element.id: false});
    }
    update();
  }
  void get_answer_of_current_question(int quesId) {
    if(checkIsQuestionAnswered(quesId))
    {
      QuestionModel questionModel=get_question_model(quesId);
      int? selected_answer=get_index_of_selected_answer(questionModel);
      marked_answer(questionModel, selected_answer!);
    }
  }
  int? get_index_of_selected_answer(QuestionModel questionModel) {
    return _questionSelectedAnswerd.entries
        .firstWhere((element) => element.key == questionModel.id)
        .value;
  }
  void nextQuestion() {
    if(quesId >= quiz_question.length-1 || _min.value==0) {
      calculate_score();
      checkStatusOfStudent();
      Get.offAndToNamed(ResultScreen.routeName);
    }
    else
    {
      if(_isPressed)
      {
        QuestionModel current_question =get_question_model(quiz_question[quesId].id);
        _questionIsAnswerd.update(current_question.id, (value) => true);
        _questionSelectedAnswerd[current_question.id]=_pressedAnswer;
        update();
      }
      quesId++;
      _isPressed=false;
      if(checkIsQuestionAnswered(quiz_question[quesId].id) )
      {
        QuestionModel next_question =get_question_model(quiz_question[quesId].id);
        choiced_answer=get_index_of_selected_answer(next_question);
        if(choiced_answer!=null) {
          marked_answer(next_question, choiced_answer!);
          update();
        }
      }
      _numberOfQuestion =  quesId+1;
      update();
      pageController.nextPage(
          duration: const Duration(milliseconds: 300), curve: Curves.linear);
    }
  }
  void previousQuestion() {
    pageController.page?.toInt();
    if ((quesId) > 0)
    {
      if (_min.value == 0) {
        calculate_score();
        checkStatusOfStudent();
        Get.offAndToNamed(ResultScreen.routeName);
      }
      else
      {
        QuestionModel current_question =get_question_model(quiz_question[quesId].id);
        if(_isPressed)
        {
          _questionIsAnswerd.update(current_question.id, (value) => true);
          _questionSelectedAnswerd[current_question.id]=_pressedAnswer;
          update();
        }
        quesId--;
        _isPressed=false;
        update();
        QuestionModel prev_question =get_question_model(quiz_question[quesId].id);
        if (checkIsQuestionAnswered(prev_question.id ))
        {
          choiced_answer = get_index_of_selected_answer(prev_question);
          if (choiced_answer != null) {
            marked_answer(prev_question, choiced_answer!);
            update();
          }
        }
        _numberOfQuestion =  quesId+1;
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