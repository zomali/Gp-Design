import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gp/classes/studentBehavior.dart';
import 'package:meta/meta.dart';
import 'package:path/path.dart';

import '../../../DatabaseManager.dart';

part 'student_behavior_state.dart';

class StudentBehaviorCubit extends Cubit<StudentBehaviorState> {
  StudentBehaviorCubit() : super(StudentBehaviorInitial());

  static StudentBehaviorCubit get(context) {
    return BlocProvider.of(context);
  }

  final DatabaseManager db = DatabaseManager();
  late studentBehavior std;
  Future<void> getStudentBehaviorData(var ID) async {
    emit(StudentBehaviorLoading());
    std = await db.fetchStudentBehavior(ID);
    emit(StudentBehaviorLoaded());
  }
}
