import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gp/DatabaseManager.dart';
import 'package:gp/classes/classes.dart';
import 'package:meta/meta.dart';

part 'quiz_state.dart';

class QuizCubit extends Cubit<QuizState> {
  QuizCubit() : super(QuizInitial());
   static QuizCubit get(context){
    return BlocProvider.of(context);
  }
  late List<Quiz_> topicQuizzes;
  late List<Quiz_> levelQuizzes;

  final DatabaseManager db = DatabaseManager();

   Future<void> getStudentQuizzes(int std_id, String course_code) async{
    emit(QuizLoading());
    topicQuizzes = await db.get_quizzes(std_id, 'Topic');
    levelQuizzes = await db.get_quizzes(std_id, 'Level');
    emit(QuizLoaded());
  }  

}
