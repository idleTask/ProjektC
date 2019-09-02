class Profile{
  String username;
  String email;
  String password;
  String token;
  String id;

  Profile._();
  Profile(
    this.username,
    this.email,
    this.password,
    this.token,
    this.id,
  );

  String getUsername() => username;
  String getEmail() => email;
  String getPassword() => password;
  String getToken() => token;
  String getId() => id;

  String toString() {
    return "Username: $username, Email: $email, Password: $password, Token: $token, id: $id,";
  }

  factory Profile.initial() {
    return Profile._()
      ..username = "lib/src/resources/images/surprised_pikatchu.png"
      ..email = "title"
      ..password = "describtion"
      ..token = ""
      ..id = "";
  }
}