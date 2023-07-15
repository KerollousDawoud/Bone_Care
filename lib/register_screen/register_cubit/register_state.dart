part of 'register_cubit.dart';

@immutable
abstract class RegisterState {}

class RegisterInitial extends RegisterState {}

class Isloading extends RegisterState {}

class ChangeObscureSuccessfuly extends RegisterState {}

class SpecialtiesChangeValue extends RegisterState {}
