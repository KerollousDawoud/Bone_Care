part of 'home_layout_cubit.dart';

@immutable
abstract class HomeLayoutState {}

class HomeLayoutInitial extends HomeLayoutState {}

class LoadModelSuccess extends HomeLayoutState {}

class LoadModelError extends HomeLayoutState {}

class ChangeIndex extends HomeLayoutState {}
