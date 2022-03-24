part of 'topic_cubit.dart';

@immutable
abstract class TopicState {}
class TopicInitial extends TopicState {}
class TopicLoading extends TopicState {}
class TopicLoaded extends TopicState {}
