import 'package:m0ments/src/blocs/m0mentCard_bloc.dart';

abstract class ProfileEvent{}

class SetUsername extends ProfileEvent{
  final String newUsername;

  SetUsername(this.newUsername);
}

class SetToken extends ProfileEvent{
  final String newToken;

  SetToken(this.newToken);
}

class AddCard extends ProfileEvent {
  M0mentCardBloc card;
  AddCard(this.card);
}