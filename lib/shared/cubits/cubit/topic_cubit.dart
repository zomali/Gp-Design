import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:gp/analysis_controller.dart';

import 'package:gp/DatabaseManager.dart';
import 'package:gp/classes/classes.dart';

import '../../../classes/student.dart';
import '../../../classes/studentBehavior.dart';

part 'topic_state.dart';

class TopicCubit extends Cubit<TopicState> {
  TopicCubit() : super(TopicInitial());
  static TopicCubit get(context) {
    return BlocProvider.of(context);
  }

  late Topic_ topic = Topic_();
  final DatabaseManager db = DatabaseManager();
  final analysis_controller ac = analysis_controller();
  late List<double> weight;

  Future<void> getTopicData(int topicID) async {
    emit(TopicLoading());
    topic = await db.getTopicData(topicID);
    emit(TopicLoaded());
  }

  Future<void> getTimeTokenForEachContentType(
      student std, studentBehavior stdBehavior) async {
    emit(TopicLoading());
    weight = await db.getTimeTokenForEachContentType(std, stdBehavior);
    emit(TopicLoaded());
  }

  Future<void> collaborative_filtering(
      String id, String LevelID, String TopicID) async {
    emit(TopicLoading());
    weight = await ac.collaborative_filtering(id, LevelID, TopicID);
    emit(TopicLoaded());
  }
}
