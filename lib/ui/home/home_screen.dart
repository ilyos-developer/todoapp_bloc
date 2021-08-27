import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_trello/bloc/auth/auth_bloc.dart';
import 'package:todo_trello/bloc/home/home_bloc.dart';
import 'package:todo_trello/ui/auth/login_screen.dart';

import 'components/task_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    BlocProvider.of<HomeBloc>(context).add(GetCardsEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DefaultTabController(
        length: 4,
        initialIndex: 0,
        child: Scaffold(
          appBar: AppBar(
            bottom: TabBar(
              isScrollable: true,
              tabs: [
                Text("On hold"),
                Text("In progress"),
                Text("Needs review"),
                Text("Approved"),
              ],
            ),
            title: BlocListener<AuthBloc, AuthState>(
              listener: (context, state) {
                if (state is LoginScreenState) {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => LoginScreen(),
                    ),
                  );
                }
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Trello'),
                  IconButton(
                    onPressed: () {
                      BlocProvider.of<AuthBloc>(context)
                          .add(LogOutEvent(false));
                    },
                    icon: Icon(Icons.logout),
                  ),
                ],
              ),
            ),
          ),
          body: TabBarView(
            children: [
              TaskCard(
                rows: 0,
              ),
              TaskCard(
                rows: 1,
              ),
              TaskCard(
                rows: 2,
              ),
              TaskCard(
                rows: 3,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
