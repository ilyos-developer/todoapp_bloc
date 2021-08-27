part of 'auth_bloc.dart';

@immutable
abstract class AuthState {}

class AuthInitial extends AuthState {}

class LoginedUserState extends AuthState {}

class LogErrorState extends AuthState {
  final String msgError;

  LogErrorState(this.msgError);
}

class LoginScreenState extends AuthState {}

class HomeScreenState extends AuthState {}
