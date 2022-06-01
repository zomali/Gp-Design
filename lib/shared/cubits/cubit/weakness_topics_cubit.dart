import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gp/DatabaseManager.dart';
import 'package:gp/classes/classes.dart';
import 'package:meta/meta.dart';

part 'weakness_topics_state.dart';

class WeaknessTopicsCubit extends Cubit<WeaknessTopicsState> {
  WeaknessTopicsCubit() : super(WeaknessTopicsInitial());
  static WeaknessTopicsCubit get(context){
    return BlocProvider.of(context);
  }

  late List<TopicOfWeakness_> topicsList;
  final DatabaseManager db = DatabaseManager();

  Future<void> getTopicsOfWeakness(int std_id, int level_id) async{
    
    topicsList = await db.get_weakness_topics(std_id, level_id);

  }
}
