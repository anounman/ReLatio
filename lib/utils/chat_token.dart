import 'dart:convert';

import 'package:http/http.dart' as http;

generateToken(id) async {
  final responce =
      await http.post(Uri.parse("https://re-lation.herokuapp.com/steamToken"),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode({
            "id": id,
          }));
  if (responce.statusCode == 200) {
    return responce.body;
  } else {
    return "";
  }
}
