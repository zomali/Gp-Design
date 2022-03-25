part of 'student_behavior_cubit.dart';

@immutable
abstract class StudentBehaviorState {}

class StudentBehaviorInitial extends StudentBehaviorState {}

class StudentBehaviorLoading extends StudentBehaviorState {}

class StudentBehaviorLoaded extends StudentBehaviorState {}
