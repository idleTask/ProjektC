import 'package:m0ments/src/models/m0mentCard_model.dart';

abstract class CardListEvent {}

class RemoveCard extends CardListEvent {
  M0mentCard card;
  RemoveCard(this.card);
}

class AddCard extends CardListEvent {
  M0mentCard card;
  AddCard(this.card);
}