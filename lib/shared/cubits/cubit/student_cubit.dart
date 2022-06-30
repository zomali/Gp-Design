import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gp/classes/student.dart';
import 'package:meta/meta.dart';

import '../../../DatabaseManager.dart';

part 'student_state.dart';

class StudentCubit extends Cubit<StudentState> {
  StudentCubit() : super(StudentInitial());

  static StudentCubit get(context) {
    return BlocProvider.of(context);
  }

  final DatabaseManager db = DatabaseManager();
  late List<student> list;

  Future<void> getStudentData() async {
    emit(StudentLoading());
    list = await db.fetchStudents();
    emit(StudentLoaded());
  }
}
