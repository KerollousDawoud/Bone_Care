part of 'home_page_cubit.dart';

@immutable
abstract class HomePageState {}

class HomePageInitial extends HomePageState {}

class LoadModelError extends HomePageState {}

class ImageIsXray extends HomePageState {}

class ImageIsNotXray extends HomePageState {}

class ClassifyIfXrayError extends HomePageState {}

class Users extends HomePageState {}

class LoadModelSuccess extends HomePageState {}
