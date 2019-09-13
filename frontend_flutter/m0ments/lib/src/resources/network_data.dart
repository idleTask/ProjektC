import 'dart:io';

class NetworkData {
  final String serverAdress = "https://pi.idletask.de/";

  NetworkData();

  String getServerAdress() => serverAdress;

  Map<String, String> getAuthHeaderApplicationJson(String token){
    return {
      'Content-type': 'application/json',
        HttpHeaders.authorizationHeader: 'Bearer ' + token,
    };
  }

  Map<String, String> getAuthHeader(String token){
    return {
        HttpHeaders.authorizationHeader: 'Bearer ' + token,
    };
  }

}
