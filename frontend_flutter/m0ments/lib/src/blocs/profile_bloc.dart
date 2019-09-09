import 'package:bloc/bloc.dart';
import 'package:m0ments/src/models/profile_events.dart';
import 'package:m0ments/src/models/profile_model.dart';

import 'm0mentCard_bloc.dart';

class ProfileBloc extends Bloc<ProfileEvent, Profile> {
  @override
  get initialState => Profile.initial();

  onAddCard(M0mentCardBloc item) {
    dispatch(AddCard(item));
  }

  Stream<Profile> mapEventToState(
    ProfileEvent event,
  ) async* {
    if (event is AddCard) {
      //print(currentState.cardList.length);
      currentState.cardList.add(event.card);
    }
  }
}
