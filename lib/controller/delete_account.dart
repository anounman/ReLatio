import 'dart:convert';

import 'package:http/http.dart' as http;

Future<bool> deleteAccount(id) async {
  final uri = Uri.parse("https://re-lation.herokuapp.com/delete");
  var respoce = await http.post(uri,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"id": id}));
  if (respoce.statusCode == 201) {
    return true;
  } else {
    return false;
  }
}
