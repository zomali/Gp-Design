import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gp/classes/course.dart';
import 'package:meta/meta.dart';

import '../../../DatabaseManager.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());

  static HomeCubit get(context) {
    return BlocProvider.of(context);
  }

  final DatabaseManager db = DatabaseManager();
  late course c;
  Future<void> getCoursesData() async {
    emit(HomeLoading());
    c = await db.getCourses();
    emit(HomeLoaded());
  }
}
