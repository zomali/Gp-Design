part of 'level_cubit.dart';

@immutable
abstract class LevelState {}
class LevelInitial extends LevelState {}
class LevelLoading extends LevelState {}
class LevelLoaded extends LevelState {}
