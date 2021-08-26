import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:todo_trello/model/cards.dart';
import 'package:todo_trello/service/dio_client.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial());

  @override
  Stream<HomeState> mapEventToState(
    HomeEvent event,
  ) async* {
    if (event is GetCardsEvent) {
      yield HomeInitial();
      try {
        List<Cards> cards = await DioClient().getCards();
        yield LoadedCardsState(cards);
      } catch (err) {
        print("line 25: $err");
      }
    }
  }
}
