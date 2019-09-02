abstract class ProfileEvent{}

class SetUsername extends ProfileEvent{
  final String newUsername;

  SetUsername(this.newUsername);
}

class setToken extends ProfileEvent{
  final String newToken;

  setToken(this.newToken);
}