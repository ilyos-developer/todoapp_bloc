part of 'home_bloc.dart';

@immutable
abstract class HomeState {}

class HomeInitial extends HomeState {}

class LoadedCardsState extends HomeState {
  final List<Cards> cards;

  LoadedCardsState(this.cards);
}