import 'package:m0ments/src/models/m0mentCard_model.dart';

class CardListState {
  List<M0mentCard> cardList = new List<M0mentCard>();

  CardListState._();
  CardListState(this.cardList);

  factory CardListState.initial() {
    return CardListState._()..cardList = [];
  }
}