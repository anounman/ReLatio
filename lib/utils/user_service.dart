import 'dart:convert';

import 'package:check_mate/controller/get_geolocation.dart';
import 'package:check_mate/helper/consts.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../model/user_data.dart';

class UserData {
  Future<List<UserModel>?> getUserdata(gender) async {
    position = await LocationController().initLocation();
    upDateApp();
    debugPrint(
        "Longitude:${position!.longitude} , latitude:${position!.latitude}");
    final uri = Uri.parse("https://re-lation.herokuapp.com/users");
    final respoce = await http.post(uri,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "gender": gender,
          "Authentication": authToken,
          "currentAddress": [position!.longitude, position!.latitude]
        }));
    if (respoce.statusCode == 200) {
      return userFromJson(respoce.body);
    } else {
      return null;
    }
  }
}
