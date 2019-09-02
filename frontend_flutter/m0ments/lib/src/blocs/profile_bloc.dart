import 'package:bloc/bloc.dart';
import 'package:m0ments/src/models/profile_events.dart';
import 'package:m0ments/src/models/profile_model.dart';

class ProfileBloc extends Bloc <ProfileEvent, Profile>{
  @override
  get initialState => Profile.initial();

 Stream<Profile> mapEventToState(
    ProfileEvent event,
  ) async* {

  }
}