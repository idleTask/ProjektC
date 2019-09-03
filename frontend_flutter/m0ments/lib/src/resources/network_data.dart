import 'dart:io';

class NetworkData {
  final String serverAdress = "http://localhost:3000/";

  NetworkData();

  String getServerAdress() => serverAdress;
  Map<String, String> getAuthorizationHeader(String token){
    return {
      'Content-type': 'application/json',
        HttpHeaders.authorizationHeader: 'Bearer ' + token,
    };
  }
}
