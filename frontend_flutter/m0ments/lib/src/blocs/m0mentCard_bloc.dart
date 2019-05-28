import 'package:bloc/bloc.dart';
import 'package:m0ments/src/models/m0mentCard.dart';
import 'package:m0ments/src/models/m0mentCard_events.dart';

class M0mentCardBloc extends Bloc<M0mentCardEvent, M0mentCard> {
  @override
  M0mentCard get initialState => M0mentCard.initial();

  @override
  Stream<M0mentCard> mapEventToState(
    M0mentCardEvent event,
  ) async*{
    if(event is TestEvent){
      print("yay");
      yield M0mentCard(
        "lib/src/resources/images/surprised_pikatchu.png",
        "title",
        "describtion",
        0,
        currentState.votes++,
        [],
      );
    }
  }
}
