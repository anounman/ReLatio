import 'dart:convert';

<<<<<<< HEAD
import 'package:check_mate/helper/consts.dart';
import 'package:http/http.dart' as http;

Future<bool> deleteAccount(id) async {
  final uri = Uri.parse("https://api-relation.vercel.app/delete");
=======
import 'package:check_mate/utils/apis.dart';
import 'package:http/http.dart' as http;

Future<bool> deleteAccount(id) async {
  final uri = Uri.parse(Api.deleteAccout);
>>>>>>> 62b38beeda1f0d7d623ad8a7c641554bf0c87ed8
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
