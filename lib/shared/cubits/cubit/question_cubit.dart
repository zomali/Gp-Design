import 'package:flutter_bloc/flutter_bloc.dart';
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
   Future<void> getLevelQuestions(Level_ level) async{
    emit(QuestionLoading());
    
    List<Question_> easyQuestions = [];
    List<Question_> mediumQuestions = [];
    List<Question_> hardQuestions = [];
    allQuestions = [];
    for(var topic in level.topics)
    {
    easyQuestions = await db.getTopicQuestions(topic.id, "easy");
    mediumQuestions = await db.getTopicQuestions(topic.id, "medium");
    hardQuestions = await db.getTopicQuestions(topic.id, "hard");
    allQuestions += easyQuestions + mediumQuestions + hardQuestions;
    }

    emit(QuestionLoaded());
  } 
  Future<void> getQuestions(String type, int ID) async {
    if(type == "topic")
    getTopicQuestions(ID);
    else if(type == "level")
    {
      Level_ level = await db.getLevelData(ID);
      getLevelQuestions(level);
    }
  }

}