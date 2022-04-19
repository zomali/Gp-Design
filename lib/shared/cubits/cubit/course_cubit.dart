import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gp/DatabaseManager.dart';
import 'package:gp/classes/classes.dart';
import 'package:meta/meta.dart';

part 'course_state.dart';

class CourseCubit extends Cubit<CourseState> {
  CourseCubit() : super(CourseInitial());
  static CourseCubit get(context){
  return BlocProvider.of(context);
  }
  Course_ course = Course_();
  final DatabaseManager db = DatabaseManager();
   Future<void> getCourseData(String courseCode) async{
    emit(CourseLoading());
    course = await db.getCourseData(courseCode);
    emit(CourseLoaded());
  }  
}
