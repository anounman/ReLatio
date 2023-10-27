import 'dart:convert';

import 'package:check_mate/helper/consts.dart';
import 'package:http/http.dart' as http;

Future<bool> deleteAccount(id) async {
  final uri = Uri.parse("https://api-relation.vercel.app/delete");
  var respoce = await http.post(uri,
      headers: {
        "Content-Type": "application/json",
        "Authorization": authToken!
      },
      body: jsonEncode({"id": id}));
  if (respoce.statusCode == 201) {
    return true;
  } else {
    return false;
  }
}
