import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gp/classes/studentBehavior.dart';
import 'package:meta/meta.dart';
import 'package:path/path.dart';

import '../../../DatabaseManager.dart';
import '../../../analysis_controller.dart';
import '../../../classes/student.dart';

part 'student_behavior_state.dart';

class StudentBehaviorCubit extends Cubit<StudentBehaviorState> {
  StudentBehaviorCubit() : super(StudentBehaviorInitial());

  static StudentBehaviorCubit get(context) {
    return BlocProvider.of(context);
  }

  final DatabaseManager db = DatabaseManager();
  late studentBehavior std;
  late studentBehavior value;
  late List<int> times;
  late int Audio_time;
  late int Video_time;
  late int Image_time;
  late int Text_time;
  late List<int> timesForStudents;
  late String percent;
  late List<int> gradesStudent;
  late List<int> gradesAllStudent;
  late List<double> weight;
  late analysis_controller ac = analysis_controller();
  late top6 top;

  Future<void> fetchAllStudentGrades(student std) async {
    emit(StudentBehaviorLoading());
    gradesAllStudent = await db.fetchAllStudentGrades(std);
    emit(StudentBehaviorLoaded());
  }

  Future<void> fetchEachStudentGrades() async {
    emit(StudentBehaviorLoading());
    top = await ac.fetchEachStudentGrades();
    emit(StudentBehaviorLoaded());
  }

  Future<void> fetchStudentGrades(student std) async {
    emit(StudentBehaviorLoading());
    gradesStudent = await db.fetchStudentGrades(std);
    emit(StudentBehaviorLoaded());
  }

  Future<void> getTimeTokenForEachLevelForAllStudents(student std) async {
    emit(StudentBehaviorLoading());
    timesForStudents = await db.getTimeTokenForEachLevelForAllStudents(std);
    emit(StudentBehaviorLoaded());
  }

  Future<void> getTimeTokenInVideo(student std) async {
    emit(StudentBehaviorLoading());
    Video_time = await db.getTimeTokenInVideo(std);
    emit(StudentBehaviorLoaded());
  }

  Future<void> getTimeTokenInAudio(student std) async {
    emit(StudentBehaviorLoading());
    Audio_time = await db.getTimeTokenInAudio(std);
    emit(StudentBehaviorLoaded());
  }

  Future<void> getTimeTokenInText(student std) async {
    emit(StudentBehaviorLoading());
    Text_time = await db.getTimeTokenInText(std);
    emit(StudentBehaviorLoaded());
  }

  Future<void> getTimeTokenInImage(student std) async {
    emit(StudentBehaviorLoading());
    Image_time = await db.getTimeTokenInImage(std);
    emit(StudentBehaviorLoaded());
  }

  Future<void> getCurrentTopicPercet(student std) async {
    emit(StudentBehaviorLoading());
    percent = await db.getCurrentTopicPercet(std);
    emit(StudentBehaviorLoaded());
  }

  Future<void> getTimeTokenForEachLevel(student std) async {
    emit(StudentBehaviorLoading());
    times = await db.getTimeTokenForEachLevel(std);
    emit(StudentBehaviorLoaded());
  }

  Future<void> getTimeSpendEveryOnce(var ID, var Level, var Topic) async {
    emit(StudentBehaviorLoading());
    value = await db.fetchTimeSpendEveryOnce(ID, Level, Topic);
    emit(StudentBehaviorLoaded());
  }

  Future<void> getTimeTokenForEachContentType(
      student std, studentBehavior stdBehavior) async {
    emit(StudentBehaviorLoading());
    weight = await db.getTimeTokenForEachContentType(std, stdBehavior);
    emit(StudentBehaviorLoaded());
  }

  Future<void> getStudentBehaviorData(var ID, var Level, var Topic) async {
    emit(StudentBehaviorLoading());
    std = await db.fetchStudentBehavior(ID, Level, Topic);
    emit(StudentBehaviorLoaded());
  }
}
