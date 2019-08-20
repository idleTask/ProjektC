import 'package:m0ments/src/blocs/m0mentCard_bloc.dart';

class CardListState {
  List<M0mentCardBloc> cardList = new List<M0mentCardBloc>();

  CardListState._();
  CardListState(this.cardList);

  factory CardListState.initial() {
    return CardListState._()..cardList = [];
  }
}