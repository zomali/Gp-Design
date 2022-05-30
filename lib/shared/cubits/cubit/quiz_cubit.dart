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
  late List<Quiz_> quizzes;
  final DatabaseManager db = DatabaseManager();

   Future<void> getStudentQuizzes(int std_id, String course_code) async{
    emit(QuizLoading());
    quizzes = await db.get_student_quizzes(std_id, course_code);
    emit(QuizLoaded());
  }  

}
