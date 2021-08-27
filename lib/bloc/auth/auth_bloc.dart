import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:meta/meta.dart';
import 'package:todo_trello/model/user.dart';
import 'package:todo_trello/service/dio_client.dart';

part 'auth_event.dart';

part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial());

  static final _storage = FlutterSecureStorage();

  @override
  Stream<AuthState> mapEventToState(
    AuthEvent event,
  ) async* {
    if (event is AuthorizationCheckEvent) {
      var token = await _storage.read(key: "userToken");
      print("line 24 $token");
      if (token != null) {
        yield HomeScreenState();
      } else {
        yield LoginScreenState();
      }
    }
    if (event is CreateUserEvent) {
      yield AuthInitial();
      try {
        User user = await DioClient().createUser(
            userName: event.userName, email: event.email, pass: event.password);
        await _storage.write(key: 'userToken', value: user.token);
        yield LoginedUserState();
      } catch (err) {
        print("line 39: $err");
      }
    }
    if (event is LoginUserEvent) {
      try {
        User user = await DioClient()
            .loginUser(userName: event.userName, pass: event.password);
        await _storage.write(key: 'userToken', value: user.token);
        if (user.token != null) {
          yield LoginedUserState();
        } else {
          yield LogErrorState(user.nonFieldErrors!);
        }
        print("line 53: ${user.nonFieldErrors}");
      } catch (e) {
        print("line 55: $e");
      }
    }
    if (event is LogOutEvent) {
      await _storage.delete(key: 'userToken');
      yield LoginScreenState();
    }
  }
}
