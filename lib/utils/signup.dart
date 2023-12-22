import 'dart:convert';

import 'package:check_mate/helper/consts.dart';
import 'package:check_mate/helper/data_fetch.dart';
import 'package:check_mate/utils/apis.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

Future<List<String>?> signUp() async {
  final prefs = await SharedPreferences.getInstance();
  debugPrint("Data:$userData");
  final uri = Uri.parse("https://api-relation.vercel.app/signup");
  final responce = await http.post(uri,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(userData));
  debugPrint(responce.body);
  if (responce.statusCode == 201) {
    debugPrint(responce.body);
    var data = jsonDecode(responce.body);
    String token = data["tokens"][0]["token"];
    debugPrint("Token:$token");
    prefs.setString('token', token);
    authToken = token;
    return [data["_id"], data["name"]];
  }
  if (responce.statusCode == 400) {
    debugPrint("Signup Error: ${responce.body}");
  }
  if (responce.statusCode == 422) {
    showSnackbar("User alrady exist");
  }
  return null;
}
