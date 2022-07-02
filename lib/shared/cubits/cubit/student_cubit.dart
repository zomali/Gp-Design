import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gp/classes/student.dart';
import 'package:meta/meta.dart';

import '../../../DatabaseManager.dart';
import '../../../classes/classes.dart';

part 'student_state.dart';

class StudentCubit extends Cubit<StudentState> {
  StudentCubit() : super(StudentInitial());

  static StudentCubit get(context) {
    return BlocProvider.of(context);
  }

  final DatabaseManager db = DatabaseManager();
  late List<student> list;
  late String TopicName;
  late List<String> MaxTopicScore;
  late List<String> MinTopicScore;
  late List<Level_> allLevels;

  Future<void> getStudentData() async {
    emit(StudentLoading());
    list = await db.fetchStudents();
    emit(StudentLoaded());
  }

  Future<void> retriveTopicName(int level, int topic) async {
    emit(StudentLoading());
    TopicName = await db.retriveTopicName(level, topic);
    emit(StudentLoaded());
  }

  Future<void> MaxTwoScoreTopics(int id) async {
    emit(StudentLoading());
    MaxTopicScore = await db.MaxTwoScoreTopics(id);
    emit(StudentLoaded());
  }

  Future<void> MinTwoScoreTopics(int id) async {
    emit(StudentLoading());
    MinTopicScore = await db.MinTwoScoreTopics(id);
    emit(StudentLoaded());
  }

  Future<void> getAllLevels(List<int> levelIDs) async {
    emit(StudentLoading());
    allLevels = [];
    for (int i = 0; i < levelIDs.length; i++) {
      allLevels.add(await db.getLevelData(levelIDs[i]));
    }
    emit(StudentLoaded());
  }
}
