import 'package:m0ments/src/blocs/m0mentCard_bloc.dart';

abstract class CardListEvent {}

class RemoveCard extends CardListEvent {
  M0mentCardBloc card;
  RemoveCard(this.card);
}

class RemoveAllCards extends CardListEvent {}

class AddCard extends CardListEvent {
  M0mentCardBloc card;
  AddCard(this.card);
}
