import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:gp/classes/classes.dart';
import 'package:gp/DatabaseManager.dart';
part 'level_state.dart';

class LevelCubit extends Cubit<LevelState> {
  LevelCubit() : super(LevelInitial());
   static LevelCubit get(context){
    return BlocProvider.of(context);
  }
  late Level_ level;
  final DatabaseManager db = DatabaseManager();

  Future<void> getAudioData(int levelID) async{
    emit(LevelLoading());
    level = await db.getLevelData(levelID);
    emit(LevelLoaded());
  }  
}
