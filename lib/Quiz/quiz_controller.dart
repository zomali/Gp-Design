import 'dart:async';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'question__model.dart';
import 'package:gp/DatabaseManager.dart';
import 'result_screen.dart';
import "dart:math";
import 'package:gp/classes/student.dart';
import 'package:gp/classes/classes.dart';

class QuizController extends GetxController {
  final int id;
  final student std;
  String stat;
  List<TopicOfWeakness_> weakness_topics;
  List<Question_> questions;
  QuizController(this.id, this.std, this.stat, this.weakness_topics, this.questions);
  //QuizController();
  String name = '';
  String status = '';
  int number_of_correct_answer=0;
  int number_of_wronge_answer=0;
  //list of all questions
  //contain all question of level
  List<Question_> get questionsList => [...questions];
  DatabaseManager db = DatabaseManager();
  //contain all question of level
  //get quiz question for every student
  final List<Question_> quiz_question = [];
  final List<Levels> levels = [
    Levels(level_id: 1, topics_id: [1, 2, 3]),
    Levels(level_id: 2, topics_id: [4, 5, 6]),
    Levels(level_id: 3, topics_id: [7, 8, 9, 10]),
    Levels(level_id: 4, topics_id: [11, 12, 13]),
    Levels(level_id: 5, topics_id: [14, 15, 16, 17]),
  ];
  //stat= quiz on topic or level
  //id = level id or topic id
  //generate quiz on topic
  void generate_random_quiz_for_topic<Question_>(int topic_id) {
    final random = new Random();
    int count = 0;
    int easy_count = 0, meduim_count = 0, hard_count = 0;
    //if stat=topic
    while (quiz_question.length != 10) {
      int index = random.nextInt(questionsList.length - 1);
      if (!quiz_question.contains(questionsList[index])) {
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
  void generate_random_quiz_for_level<Question_>(
      int id, List<TopicOfWeakness_> weakness_topics) {
    final random = new Random();
    bool all_weakness = false;
    int topic_count = 1, i = -1;
    if (weakness_topics.length == levels[id - 1].topics_id.length) {
      all_weakness = true;
    }
    if (all_weakness != true) {
      while (topic_count != levels[id - 1].topics_id.length &&
          i < levels[id - 1].topics_id.length - 1) {
        i++;
        int easy_count = 0, meduim_count = 0, hard_count = 0;
        if (weakness_topics.contains(levels[id - 1].topics_id[i])) {
          while ((easy_count + meduim_count + hard_count) != 4) {
            int index = random.nextInt(questionsList.length - 1);
            if (questionsList[index].topic_id == levels[id - 1].topics_id[i] &&
                !quiz_question.contains(questionsList[index])) {
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
        } else {
          while ((easy_count + meduim_count + hard_count) != 3) {
            int index = random.nextInt(questionsList.length - 1);
            if (questionsList[index].topic_id == levels[id - 1].topics_id[i] &&
                !quiz_question.contains(questionsList[index])) {
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
    } else {
      int weak_topics_count = 0;
      while (weak_topics_count <= levels[id - 1].topics_id.length - 1) {
        int easy_count = 0, meduim_count = 0, hard_count = 0;
        while ((easy_count + meduim_count + hard_count) != 4) {
          int index = random.nextInt(questionsList.length - 1);
          if (!quiz_question.contains(questionsList[index]) &&
              questionsList[index].topic_id ==
                  levels[id - 1].topics_id[weak_topics_count]) {
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
  Map<int, bool> _questionIsAnswerd = {};
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
  late int start_quiz_time;
  //map for check if the question has been answered
  static final Map<int, int?> _questionSelectedAnswerd = {};
  List<Quiz_Analysis> quiz_analysis = [];
  //page view controller
  late PageController pageController;
  //timer
  Timer? _timer;
  //min to display quiz to stident
  final int maxMin = 14;
  final int maxSec=60;
  //time in progress time design must equal maxMin variable
  final RxInt _min = 14.obs;
  final RxInt _sec=60.obs;
  RxInt get min => _min;
  RxInt get sec=> _sec;
  int get correct=>number_of_correct_answer;
  int get wrong=>number_of_wronge_answer;
  int quesId = 0;
  //return quiz questions
  List<Question_> get student_quiz => [...quiz_question];
  @override
  void onInit() {
    pageController = PageController(initialPage: 0);
    DateTime StartTime = DateTime.now();
    int min = StartTime.minute * 60;
    start_quiz_time = min + StartTime.second;
    if (stat == "Topic") {
      generate_random_quiz_for_topic(id);
    }
    if (stat == "Level") {
      generate_random_quiz_for_level(id, weakness_topics);
    }
    _questionSelectedAnswerd.clear();
    resetAnswer();
    resetAnalysis();
    super.onInit();
  }

  @override
  void onClose() {
    pageController.dispose();
    quiz_question.clear();
    super.onClose();
  }

  int get scoreResult {
    return _countOfCorrectAnswers;

  }

  List<TopicOfWeakness_> get_quiz_analysis() {
    List<TopicOfWeakness_> weakness_list = [];
    double sec = (maxMin * 60) / quiz_question.length;
    if (stat == "Topic") {
      int weakness_count = 0;
      TopicOfWeakness_ weakness_ = new TopicOfWeakness_();
      weakness_.number_of_late_questions = 0;
      weakness_.number_of_not_answered_question = 0;
      weakness_.number_of_wrong_questions = 0;
      weakness_.level_id = get_level_id(id);
      weakness_.topic_id = id;
      for (int i = 0; i < quiz_analysis.length; i++) {
        if (quiz_analysis[i].user_answer == "false") {
          weakness_.number_of_wrong_questions += 1;
        } else if (quiz_analysis[i].user_answer == "no answer") {
          weakness_.number_of_not_answered_question += 1;
        } else {
          if (quiz_analysis[i].complexity == "easy") {
            if (quiz_analysis[i].time_spent > sec) {
              weakness_.number_of_late_questions += 1;
            }
          } else if (quiz_analysis[i].complexity == "medium") {
            if (quiz_analysis[i].time_spent > (sec * 2)) {
              weakness_.number_of_late_questions += 1;
            }
          } else if (quiz_analysis[i].complexity == "hard") {
            if (quiz_analysis[i].time_spent > (sec * 3)) {
              weakness_.number_of_late_questions += 1;
            }
          }
        }
      }
      weakness_count = weakness_.number_of_late_questions +
          weakness_.number_of_not_answered_question +
          weakness_.number_of_wrong_questions;
      if (weakness_count > (quiz_question.length / 3)) {
        weakness_list.add(weakness_);
      }
    } else if (stat == "Level") {
      int len = levels[id - 1].topics_id.length;
      for (int i = levels[id - 1].topics_id[0];
          i < (levels[id - 1].topics_id[0] + len);
          i++) {
        TopicOfWeakness_ topicOfWeakness_ = new TopicOfWeakness_();
        topicOfWeakness_.number_of_not_answered_question = 0;
        topicOfWeakness_.number_of_wrong_questions = 0;
        topicOfWeakness_.number_of_late_questions = 0;
        topicOfWeakness_.topic_id = i;
        topicOfWeakness_.level_id = id;
        weakness_list.add(topicOfWeakness_);
      }
      for (int i = 0; i < quiz_question.length; i++) {
        if (quiz_analysis[i].user_answer == "false") {
          for (var item in weakness_list) {
            if (item.topic_id == quiz_analysis[i].topic_id) {
              item.number_of_wrong_questions += 1;
              break;
            }
          }
        } else if (quiz_analysis[i].user_answer == "no answer") {
          for (var item in weakness_list) {
            if (item.topic_id == quiz_analysis[i].topic_id) {
              item.number_of_not_answered_question += 1;
              break;
            }
          }
        } else {
          if (quiz_analysis[i].complexity == "easy") {
            if (quiz_analysis[i].time_spent > sec) {
              for (var item in weakness_list) {
                if (item.topic_id == quiz_analysis[i].topic_id) {
                  item.number_of_late_questions += 1;
                  break;
                }
              }
            }
          } else if (quiz_analysis[i].complexity == "medium") {
            if (quiz_analysis[i].time_spent > (sec * 2)) {
              for (var item in weakness_list) {
                if (item.topic_id == quiz_analysis[i].topic_id) {
                  item.number_of_late_questions += 1;
                  break;
                }
              }
            }
          } else if (quiz_analysis[i].complexity == "hard") {
            if (quiz_analysis[i].time_spent > (sec * 3)) {
              for (var item in weakness_list) {
                if (item.topic_id == quiz_analysis[i].topic_id) {
                  item.number_of_late_questions += 1;
                  break;
                }
              }
            }
          }
        }
      }

      for (int i = 0; i < weakness_list.length; i++) {
        int count = weakness_list[i].number_of_late_questions +
            weakness_list[i].number_of_not_answered_question +
            weakness_list[i].number_of_wrong_questions;
        if (count < 3) {
          weakness_list.removeAt(i);
          i--;
        }
      }
    }
    return weakness_list;
  }

  int calculate_total_quiz_points() {
    int total_score = 0;
    for (int i = 0; i < quiz_question.length; i++) {
      total_score += quiz_question[i].points;
    }
    return total_score;
  }

  void checkStatusOfStudent() {
    int total = calculate_total_quiz_points();
    if (scoreResult > total * .8) {
      status = "Congratulations";
    } else if (scoreResult == 0) {
      status = "Very frustrating. You have to change the way you study";
    } else if (scoreResult < total * .5) {
      status = "You must study well, you will repeat this level";
    } else {
      status = "Not bad, but you should study more";
    }
  }

  void marked_answer(Question_ questionModel, int selectAnswer) {
    _isPressed = true;
    _pressedAnswer = selectAnswer;
    update();
  }

  Map<int, int?> get_answred() {
    return _questionSelectedAnswerd;
  }

  void calculate_score() {
    for (int i = 0; i < quiz_question.length; i++) {
      if (checkIsQuestionAnswered(quiz_question[i].id)) {
        int? selected_answer = get_index_of_selected_answer(quiz_question[i]);
        if (selected_answer == null) {
          continue;
        } else if (quiz_question[i].answer_id == selected_answer) {
          _countOfCorrectAnswers += quiz_question[i].points;
          quiz_analysis[i].user_answer = "true";
          number_of_correct_answer++;
        } else {
          quiz_analysis[i].user_answer = "false";
          number_of_wronge_answer++;
        }
      }
    }
  }

  Question_ get_question_model(int quesID) {
    for (int i = 0; i < quiz_question.length; i++) {
      if (quiz_question[i].id == quesID) {
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

  void resetAnalysis() {
    for (int i = 0; i < quiz_question.length; i++) {
      Quiz_Analysis element = new Quiz_Analysis();
      element.user_answer = "no answer";
      element.id = quiz_question[i].id;
      element.topic_id = quiz_question[i].topic_id;
      element.points = quiz_question[i].points;
      element.complexity = quiz_question[i].complexity;
      element.time_spent = 0;
      quiz_analysis.add(element);
    }
  }

  void resetAnswer() {
    for (var element in questionsList) {
      _questionIsAnswerd.addAll({element.id: false});
    }
    update();
  }

  void get_answer_of_current_question(int quesId) {
    if (checkIsQuestionAnswered(quesId)) {
      Question_ questionModel = get_question_model(quesId);
      int? selected_answer = get_index_of_selected_answer(questionModel);
      marked_answer(questionModel, selected_answer!);
    }
  }

  int? get_index_of_selected_answer(Question_ questionModel) {
    return _questionSelectedAnswerd.entries
        .firstWhere((element) => element.key == questionModel.id)
        .value;
  }

  void nextQuestion() {
    DateTime StartTime = DateTime.now();
    int min = StartTime.minute * 60;
    int SecondTime = min + StartTime.second;
    int timeStayed = SecondTime - start_quiz_time;
    quiz_analysis[quesId].time_spent += timeStayed;
    start_quiz_time = SecondTime;
    if (quesId >= quiz_question.length - 1 || _min.value == 0) {
      if (_isPressed) {
        Question_ current_question =
            get_question_model(quiz_question[quesId].id);
        _questionIsAnswerd.update(current_question.id, (value) => true);
        _questionSelectedAnswerd[current_question.id] = _pressedAnswer;
        update();
      }
      calculate_score();
      checkStatusOfStudent();
      get_quiz_analysis();
      int total_score = calculate_total_quiz_points();
      int student_score = scoreResult;
      List<Q_Question_> list_ques =
          get_quiz_question_for_DB(quiz_analysis, get_answred());
      if (stat == "Topic") {
        int level_id = get_level_id(id);
        db.insertQuiz(std.id.toString(), stat!, level_id, id, list_ques,student_score, total_score);
        List<TopicOfWeakness_> topics = get_quiz_analysis();
        db.insert_weaknessTopic(std.id, 'CSW150', topics);
      } else if (stat == "Level") {
        db.insertQuiz(std.id.toString(), stat!, id, 0, list_ques, student_score, total_score);
      }

      Get.offAndToNamed(ResultScreen.routeName);
    } else {
      if (_isPressed) {
        Question_ current_question =
            get_question_model(quiz_question[quesId].id);
        _questionIsAnswerd.update(current_question.id, (value) => true);
        _questionSelectedAnswerd[current_question.id] = _pressedAnswer;
        update();
      }
      quesId++;
      _isPressed = false;
      if (checkIsQuestionAnswered(quiz_question[quesId].id)) {
        Question_ next_question = get_question_model(quiz_question[quesId].id);
        choiced_answer = get_index_of_selected_answer(next_question);
        if (choiced_answer != null) {
          marked_answer(next_question, choiced_answer!);
          update();
        }
      }
      _numberOfQuestion = quesId + 1;
      update();
      pageController.nextPage(
          duration: const Duration(milliseconds: 300), curve: Curves.linear);
    }
  }

  void previousQuestion() {
    pageController.page?.toInt();
    DateTime StartTime = DateTime.now();
    int min = StartTime.minute * 60;
    int SecondTime = min + StartTime.second;
    int timeStayed = SecondTime - start_quiz_time;
    quiz_analysis[quesId].time_spent += timeStayed;
    start_quiz_time = SecondTime;
    if ((quesId) > 0) {
      if (_min.value == 0) {
        calculate_score();
        checkStatusOfStudent();
        Get.offAndToNamed(ResultScreen.routeName);
      } else {
        Question_ current_question =
            get_question_model(quiz_question[quesId].id);
        if (_isPressed) {
          _questionIsAnswerd.update(current_question.id, (value) => true);
          _questionSelectedAnswerd[current_question.id] = _pressedAnswer;
          update();
        }
        quesId--;
        _isPressed = false;
        update();
        Question_ prev_question = get_question_model(quiz_question[quesId].id);
        if (checkIsQuestionAnswered(prev_question.id)) {
          choiced_answer = get_index_of_selected_answer(prev_question);
          if (choiced_answer != null) {
            marked_answer(prev_question, choiced_answer!);
            update();
          }
        }
        _numberOfQuestion = quesId + 1;
        update();
        pageController.previousPage(
            duration: const Duration(milliseconds: 300), curve: Curves.linear);
      }
    }
  }

  //get right and wrong color
  Color getColor(int answerIndex) {
    if (_isPressed) {
      if (answerIndex == _pressedAnswer) {
        return Colors.orange;
      }
    }
    return Colors.white;
  }

  void startTimer() {
    resetTimer();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_sec.value > 1 && _min.value>-1) {
        _sec.value--;
      }
      else if(_sec.value==1 && _min.value>-1)
        {
          _sec.value=60;
          _min.value--;
        }
      else {
        stopTimer();
        Get.offAndToNamed(ResultScreen.routeName);
      }
    });
  }

  void get_colors_answer(Question_ questionModel, int selectAnswer) {
    _isPressed = true;
    _selectAnswer = selectAnswer;
    _correctAnswer = questionModel.answer_id;
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
  List<Q_Question_> get_quiz_question_for_DB(
      List<Quiz_Analysis> quiz_analysis, Map<int, int?> student_answer) {
    List<Q_Question_> question_For_DB_list = [];
    for (int i = 0; i < quiz_analysis.length; i++) {
      Q_Question_ item = new Q_Question_();
      item.id= quiz_analysis[i].id;
      item.time_to_answer = quiz_analysis[i].time_spent;
      item.student_answer_id = student_answer[quiz_analysis[i].id];
      question_For_DB_list.add(item);
    }
    return question_For_DB_list;
  }

  int get_level_id(int topic_id) {
    for (int l = 0; l < levels.length; l++) {
      for (int j = 0; j < levels[l].topics_id.length; j++) {
        if (levels[l].topics_id[j] == topic_id) {
          return levels[l].level_id;
        }
      }
    }
    return 0;
  }
}
