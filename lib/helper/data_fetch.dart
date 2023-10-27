import 'dart:convert';

import 'package:check_mate/model/user_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';

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

singnIn(email, password) async {
  final prefs = await SharedPreferences.getInstance();
  debugPrint("Email: $email");
  final uri = Uri.parse("https://api-relation.vercel.app/signIn");
  final responce = await http.post(uri,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(
          {"email": email.toString(), "password": password.toString()}));
  debugPrint(responce.statusCode.toString());
  if (responce.statusCode == 200) {
    var data = jsonDecode(responce.body);
    authToken = data["token"];
    debugPrint("Token:$authToken");
    prefs.setString('token', authToken!);
    setUserId(data["_id"], data["name"]);
    setLogin();
    return true;
  } else {
    return false;
  }
}

String getChannelName(Channel channel, User currentUser) {
  if (channel.name != null) {
    return channel.name!;
  } else if (channel.state?.members.isNotEmpty ?? false) {
    final otherMembers = channel.state?.members
        .where(
          (element) => element.userId != currentUser.id,
        )
        .toList();

    if (otherMembers?.length == 1) {
      return otherMembers!.first.user!.name;
    } else {
      return 'Multiple users';
    }
  } else {
    return 'No Channel Name';
  }
}

String getChannelId(Channel channel, User currentUser) {
  if (channel.name != null) {
    return channel.name!;
  } else if (channel.state?.members.isNotEmpty ?? false) {
    final otherMembers = channel.state?.members
        .where(
          (element) => element.userId != currentUser.id,
        )
        .toList();

    if (otherMembers?.length == 1) {
      return otherMembers!.first.user!.id;
    } else {
      return 'Multiple users';
    }
  } else {
    return 'No Channel Name';
  }
}

String? getChannelImage(Channel channel, User currentUser) {
  if (channel.image != null) {
    return channel.image!;
  } else if (channel.state?.members.isNotEmpty ?? false) {
    final otherMembers = channel.state?.members
        .where(
          (element) => element.userId != currentUser.id,
        )
        .toList();

    if (otherMembers?.length == 1) {
      return otherMembers!.first.user?.image;
    }
  } else {
    return null;
  }
  return null;
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
