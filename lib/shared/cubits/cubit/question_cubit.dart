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
    //emit(QuestionLoading());
    
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

    emit(QuestionLoaded());
  } 
  Future<void> getQuestions(String type, int ID) async {
    if(type == "Topic")
    getTopicQuestions(ID);
    else if(type == "Level")
    {
      emit(QuestionLoading());
      Level_ level = await db.getLevelData(ID);
      getLevelQuestions(level);
    }
  }

}