import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gp/classes/student.dart';
import 'package:meta/meta.dart';
import 'package:gp/DatabaseManager.dart';
import 'package:gp/classes/classes.dart';
part 'question_state.dart';

class QuestionCubit extends Cubit<QuestionState> {
  QuestionCubit() : super(QuestionInitial());
  static QuestionCubit get(context){
    return BlocProvider.of(context);
}
  late List<Question_> allQuestions;
   late List<TopicOfWeakness_> topicsList;

  final DatabaseManager db = DatabaseManager();
  Future<void> getTopicQuestions(int topicID) async{
    emit(QuestionLoading());
    
    List<Question_> easyQuestions = [];
    List<Question_> mediumQuestions = [];
    List<Question_> hardQuestions = [];
    allQuestions = [];
    easyQuestions = await db.getTopicQuestions(topicID, "easy");
    mediumQuestions = await db.getTopicQuestions(topicID, "medium");
    hardQuestions = await db .getTopicQuestions(topicID, "hard");
    
    allQuestions = easyQuestions + mediumQuestions + hardQuestions;

    emit(QuestionLoaded());
  }  
  Future<void> getLevelQuestions(Level_ level, student std) async{
    emit(QuestionLoading());
    
    List<Question_> easyQuestions = [];
    List<Question_> mediumQuestions = [];
    List<Question_> hardQuestions = [];
    allQuestions = [];
    
    for(int y=0; y<level.topics.length; y++)
    {
    easyQuestions = await db.getTopicQuestions(level.topics[y].id, "easy");
    mediumQuestions = await db.getTopicQuestions(level.topics[y].id, "medium");
    hardQuestions = await db.getTopicQuestions(level.topics[y].id, "hard");
    if(y==0)
        allQuestions = easyQuestions + mediumQuestions + hardQuestions;
    else
        allQuestions += easyQuestions + mediumQuestions + hardQuestions;
  }
   topicsList = await db.get_weakness_topics(std.id, level.id);

    emit(QuestionLoaded());
  } 
  Future<void> getQuestions(String type, int ID, student std) async {
    if(type == "Topic")
    getTopicQuestions(ID);
    else if(type == "Level")
    {
      emit(QuestionLoading());
      Level_ level = await db.getLevelData(ID);
      getLevelQuestions(level, std);
    }
  }

  late List<Q_Question_> quizQuestions;
  Future<void> get_list_of_questions(List<int> IDs) async{
    emit(QuestionLoading());
    quizQuestions = [];
    for(var ID in IDs)
    {
      Q_Question_ question = Q_Question_();
      question = await db.get_quiz_question(ID);
      quizQuestions.add(question);
    }
    emit(QuestionLoaded());
  }
  }