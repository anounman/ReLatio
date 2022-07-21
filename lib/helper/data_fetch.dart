import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import '../controller/get_geolocation.dart';
import 'consts.dart';

String location = "";
getLocation() async {
  location = await LocationController().getAddress();
  upDateApp();
}

setLocation(addres) {
  location = addres;
  upDateApp();
}

checkUser(email) async {
  debugPrint("Email: $email");
  final uri = Uri.parse("https://re-lation.herokuapp.com/checkUser");
  final responce = await http.post(uri,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"email": email.toString()}));
  debugPrint(responce.statusCode.toString());
  if (responce.statusCode == 200) {
    var data = jsonDecode(responce.body);
    setUserId(data["_id"], data["name"]);
    setLogin();
    return true;
  } else {
    return false;
  }
}

Map<dynamic, dynamic> userData = {
  "name": "",
  "email": "",
  "hobbies": [],
  "password": "",
  "confirmPassword": "",
  "gender": "",
  "pictures": [],
  "age": "",
  "iterestedGender": "",
};
