import 'package:bloc/bloc.dart';
import 'package:m0ments/src/models/m0mentCard_model.dart';
import 'package:m0ments/src/models/m0mentCard_events.dart';

class M0mentCardBloc extends Bloc<M0mentCardEvent, M0mentCard> {
  @override
  M0mentCard get initialState => M0mentCard.initial();

  @override
  Stream<M0mentCard> mapEventToState(
    M0mentCardEvent event,
  ) async*{
    if(event is Upvote){
      print("yay");
      yield M0mentCard(
        currentState.img,
        currentState.title,
        currentState.descr,
        currentState.id,
        currentState.votes++,
        [],
      );
    }
  }
}
