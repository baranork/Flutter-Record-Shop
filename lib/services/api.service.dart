import 'dart:convert';
import 'package:http/http.dart' as http;

class Api {
  getToken() async {
    String clientId = "98580eabbb11402aadb9190a07c1e5ad";
    String clientSecret = '0947c8f97fbd4031a21158aee5cb0541';
    Codec<String, String> stringToBase64 = utf8.fuse(base64);
    String token;

    try {
      final futureToken = await http.post(
        Uri.encodeFull('https://accounts.spotify.com/api/token'),
        body: {'grant_type': 'client_credentials'},
        headers: {
          'Authorization':
              'Basic ' + stringToBase64.encode('$clientId:$clientSecret')
        },
      );
      token = jsonDecode(futureToken.body)['access_token'] as String;
    } on Exception catch (e) {
      print(e);
    }

    return token;
  }
}
