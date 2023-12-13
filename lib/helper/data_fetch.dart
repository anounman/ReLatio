import 'dart:convert';

import 'package:check_mate/model/user_data.dart';
import 'package:check_mate/utils/apis.dart';
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

signIn(email, password) async {
  debugPrint("Email: $email");
  final uri = Uri.parse(Api.signIn);
  final responce = await http.post(uri,
      headers: {
        "Content-Type": "application/json",
      },
      body: jsonEncode({"email": email.toString(), "password": password}));
  debugPrint("user is exist response:${responce.body}");
  if (responce.statusCode == 200) {
    var data = jsonDecode(responce.body);
    setUserId(data["_id"], data["name"]);
    setLogin(data['token']);
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

calculateMatchs(UserModel user) {
  int userHobbiesLenth = user.hobbies.first.length;
  int ownHobbiesLenth = hobbies!.length;
  int m1 = 0;
  int m2 = 0;

  for (var hobbie in user.hobbies.first) {
    if (hobbie.contains(hobbie)) {
      m1++;
    }
  }

  for (var hobbie in hobbies!) {
    if (user.hobbies.first.contains(hobbie)) {
      m2++;
    }
  }
  int percentage1 = (m1 / userHobbiesLenth * 100).round();
  int percentage2 = (m2 / ownHobbiesLenth * 100).round();

  return ((percentage1 + percentage2) ~/ 2);
}
