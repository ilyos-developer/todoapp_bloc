import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_trello/bloc/home/home_bloc.dart';

class TaskCard extends StatefulWidget {
  final int rows;

  const TaskCard({Key? key, required this.rows}) : super(key: key);

  @override
  _TaskCardState createState() => _TaskCardState(rows);
}

class _TaskCardState extends State<TaskCard> {
  final int rows;

  _TaskCardState(this.rows);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        if (state is HomeInitial) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        if (state is LoadedCardsState) {
          return ListView.builder(
            itemCount: state.cards.length,
            itemBuilder: (context, index) {
              return int.parse(state.cards[index].row) == rows
                  ? Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 10),
                      child: Container(
                        padding: EdgeInsets.all(10),
                        color: Colors.grey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "ID: ${state.cards[index].id}",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 25,
                              ),
                            ),
                            SizedBox(height: 10),
                            Text(
                              state.cards[index].text,
                              style: TextStyle(
                                fontStyle: FontStyle.italic,
                                fontSize: 18,
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  : Container();
            },
          );
        }
        return Container();
      },
    );
  }
}
