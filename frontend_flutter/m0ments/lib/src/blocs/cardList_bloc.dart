import 'package:bloc/bloc.dart';
import 'package:m0ments/src/models/cardList_events.dart';
import 'package:m0ments/src/models/cardList_model.dart';
import 'package:m0ments/src/models/m0mentCard_model.dart';

class CardListBloc extends Bloc<CardListEvent, CardListState> {

  onRemoveCard(M0mentCard item) {
    dispatch(RemoveCard(item));
  }

  onAddCard(M0mentCard item) {
    dispatch(AddCard(item));
  }

  @override
  CardListState get initialState => CardListState.initial();

  @override
  Stream<CardListState> mapEventToState(event) async*{
    if(event is RemoveCard){
      //print(currentState.cardList.length);
      currentState.cardList.remove(event.card);
      yield CardListState(currentState.cardList);
    }else if(event is AddCard){
      //print(currentState.cardList.length);
      currentState.cardList.add(event.card);
      yield CardListState(currentState.cardList);
    }
  }
  
}