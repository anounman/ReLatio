import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

generateToken(id) async {
  final responce = await http.post(
      Uri.parse("https://fefb-202-142-80-18.ngrok.io/steamToken"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "id": id,
      }));
  if (responce.statusCode == 200) {
    debugPrint("TOKEN:${responce.body}");
    return responce.body;
  } else {
    return "";
  }
}
