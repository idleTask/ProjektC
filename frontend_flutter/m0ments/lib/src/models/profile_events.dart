abstract class ProfileEvent{}

class SetUsername extends ProfileEvent{
  final String newUsername;

  SetUsername(this.newUsername);
}

class SetToken extends ProfileEvent{
  final String newToken;

  SetToken(this.newToken);
}