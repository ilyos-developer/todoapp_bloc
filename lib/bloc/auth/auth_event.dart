part of 'auth_bloc.dart';

@immutable
abstract class AuthEvent {}

class InitialEvent extends AuthEvent {}

class AuthorizationCheckEvent extends AuthEvent {}

class CreateUserEvent extends AuthEvent {
  final String userName;
  final String email;
  final String password;

  CreateUserEvent(
      {required this.userName, required this.email, required this.password});
}

class LoginUserEvent extends AuthEvent {
  final String userName;
  final String password;

  LoginUserEvent(this.userName, this.password);
}

class LogOutEvent extends AuthEvent {
  final bool isLogOut;

  LogOutEvent(this.isLogOut);
}