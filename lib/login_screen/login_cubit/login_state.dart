part of 'login_cubit.dart';

@immutable
abstract class LoginState {}

class LoginInitial extends LoginState {}

class Isloading extends LoginState {}

class ChangeObscureSuccessfuly extends LoginState {}

class Users extends LoginState {}
