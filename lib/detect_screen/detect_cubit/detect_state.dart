part of 'detect_cubit.dart';

@immutable
abstract class DetectState {}

class DetectInitial extends DetectState {}

class LoadModelSuccess extends DetectState {}

class LoadModelError extends DetectState {}

class ClassifyLungSuccess extends DetectState {}

class ClassifyLungError extends DetectState {}
