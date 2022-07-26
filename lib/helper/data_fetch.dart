import 'dart:convert';

import 'package:check_mate/model/user_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
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

checkUser(email) async {
  debugPrint("Email: $email");
  final uri = Uri.parse("https://re-lation.herokuapp.com/checkUser");
  final responce = await http.post(uri,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "email": email.toString(),
        "Authentication": authToken,
      }));
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
  int totalNumber = (user.hobbies.length + hobbies!.length) ~/ 2;
  int totalMatch = 0;
  List<String> bighoobiesList =
      (user.hobbies.length >= hobbies!.length) ? user.hobbies.first : hobbies!;
  List<String> smallHoobiesList =
      (user.hobbies.length <= hobbies!.length) ? user.hobbies.first : hobbies!;

  for (var hoobie in smallHoobiesList) {
    if (bighoobiesList.contains(hoobie)) {
      totalMatch++;
    }
  }
  double percentage = ((totalNumber / totalMatch) * 100);
  return percentage;
}
