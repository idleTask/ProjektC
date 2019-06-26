import 'package:m0ments/src/blocs/m0mentCard_bloc.dart';
import 'package:m0ments/src/models/m0mentCard_model.dart';

abstract class CardListEvent {}

class RemoveCard extends CardListEvent {
  M0mentCardBloc card;
  RemoveCard(this.card);
}

class AddCard extends CardListEvent {
  M0mentCardBloc card;
  AddCard(this.card);
}