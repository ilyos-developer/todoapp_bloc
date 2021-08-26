import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_trello/bloc/auth/auth_bloc.dart';
import 'package:todo_trello/bloc/home/home_bloc.dart';
import 'package:todo_trello/ui/home/home_screen.dart';

import 'ui/auth/login_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(
          create: (context) => AuthBloc()..add(AuthorizationCheckEvent()),
        ),
        BlocProvider<HomeBloc>(
          create: (context) => HomeBloc()..add(HomeInitialEvent()),
        ),
      ],
      child: MaterialApp(
        title: 'Trello todo',
        theme: ThemeData.dark(),
        home: BlocBuilder<AuthBloc, AuthState>(
          builder: (context, state) {
            if (state is LoginScreenState) {
              return LoginScreen();
            }
            if (state is HomeScreenState) {
              return HomeScreen();
            }
            return Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
    );
  }
}
