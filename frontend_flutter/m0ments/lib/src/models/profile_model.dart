import 'package:m0ments/src/blocs/m0mentCard_bloc.dart';

class Profile{
  String username;
  String email;
  String password;
  String token;
  String id;
  List<M0mentCardBloc> cardList = new List<M0mentCardBloc>();

  Profile._();
  Profile(
    this.username,
    this.email,
    this.password,
    this.token,
    this.id,
    this.cardList,
  );

  String getUsername() => username;
  String getEmail() => email;
  String getPassword() => password;
  String getToken() => token;
  String getId() => id;

  String toString() {
    return "Username: $username, Email: $email, Password: $password, Token: $token, Id: $id, CardList: $cardList";
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