import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_trello/bloc/auth/auth_bloc.dart';

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
          create: (context) => AuthBloc()..add(InitialEvent()),
        ),
      ],
      child: MaterialApp(
        title: 'Trello todo',
        theme: ThemeData.dark(),
        home: LoginScreen(),
      ),
    );
  }
}

