import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:gp/DatabaseManager.dart';
import 'package:gp/classes/classes.dart';

part 'topic_state.dart';

class TopicCubit extends Cubit<TopicState> {
  TopicCubit() : super(TopicInitial());
   static TopicCubit get(context){
    return BlocProvider.of(context);
  }
  late Topic_ topic;
  final DatabaseManager db = DatabaseManager();

  Future<void> getAudioData(int topicID) async{
    emit(TopicLoading());
    topic = await db.getTopicData(topicID);
    emit(TopicLoaded());
  }  
}
