import 'package:bloc/bloc.dart';
import 'package:m0ments/src/models/m0mentCard_model.dart';
import 'package:m0ments/src/models/m0mentCard_events.dart';

class M0mentCardBloc extends Bloc<M0mentCardEvent, M0mentCard> {
  @override
  M0mentCard get initialState => M0mentCard.initial();

  void upvote(){
    dispatch(Upvote());
  }

  void vote(){
    dispatch(Vote());
  }

  void downvote(){
    dispatch(Downvote());
  }

  @override
  Stream<M0mentCard> mapEventToState(
    M0mentCardEvent event,
  ) async* {

    if (event is Upvote) {
      if (!currentState.upvoted && !currentState.downvoted) {
        print("Bloc: Upvote");
        currentState.votes++;
        currentState.upvoted = true;
        currentState.downvoted = false;
      }else if (currentState.upvoted && !currentState.downvoted) {
        print("Bloc: Reverse Upvote");
      currentState.votes--;
      currentState.upvoted = false;
      currentState.downvoted = false;
      }else if(!currentState.upvoted && currentState.downvoted){
        print("Bloc: Reverse Downvote + Upvote");
        currentState.votes = currentState.votes + 2;
        currentState.upvoted = true;
        currentState.downvoted = false;
      }
    }
    if (event is Downvote) {
      if (!currentState.upvoted && !currentState.downvoted) {
        print("Bloc: Downvote");
        currentState.votes--;
        currentState.downvoted = true;
        currentState.upvoted = false;
      } else if (!currentState.upvoted && currentState.downvoted) {
        print("Bloc: Reverse Downvote");
        currentState.votes++;
        currentState.downvoted = false;
        currentState.upvoted = false;
      }else if(currentState.upvoted && !currentState.downvoted){
        print("Bloc: Reverse Upvote + Downvote");
        currentState.votes = currentState.votes - 2;
        currentState.downvoted = true;
        currentState.upvoted = false;
      }
    }
  }
}
