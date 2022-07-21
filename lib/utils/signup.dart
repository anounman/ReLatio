import 'dart:convert';

import 'package:check_mate/helper/consts.dart';
import 'package:check_mate/helper/data_fetch.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

Future<List<String>?> signUp() async {
  debugPrint("Data:$userData");
  final uri = Uri.parse("https://re-lation.herokuapp.com/signup");
  final responce = await http.post(uri,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(userData));
  debugPrint(responce.statusCode.toString());
  if (responce.statusCode == 201) {
    debugPrint(responce.body);
    await setLogin();
    var data = jsonDecode(responce.body);
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
