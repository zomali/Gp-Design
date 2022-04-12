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
  late Level_ level = Level_();
  late List<Level_> allLevels;
  final DatabaseManager db = DatabaseManager();

  Future<void> getLevelData(int levelID) async{
    emit(LevelLoading());
    level = await db.getLevelData(levelID);
    emit(LevelLoaded());
  }
   Future<void> getAllLevels(List<int> levelIDs) async{
    emit(LevelLoading());
    allLevels = [];
    for(int i= 0; i<levelIDs.length; i++)
    {
      allLevels.add(await db.getLevelData(levelIDs[i]));
    }
    emit(LevelLoaded());
  }  

}
