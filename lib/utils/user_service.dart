import 'dart:convert';

import 'package:check_mate/controller/get_geolocation.dart';
import 'package:check_mate/helper/consts.dart';
import 'package:check_mate/utils/apis.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../model/user_data.dart';

class UserData {
  Future<List<UserModel>?> getUserdata(gender) async {
    position = await LocationController().initLocation();
    upDateApp();
    debugPrint(
        "Longitude:${position!.longitude} , latitude:${position!.latitude}");
    final uri = Uri.parse(Api.users);
    final prefs = await SharedPreferences.getInstance();
    authToken = prefs.getString('authToken');
    if (authToken != null) {
      final respoce = await http.post(uri,
          headers: {
            "Content-Type": "application/json",
            "Authorization": authToken ?? "",
          },
          body: jsonEncode({
            "gender": gender,
            "currentAddress": [position!.longitude, position!.latitude]
          }));
      if (respoce.statusCode == 200) {
        return userFromJson(respoce.body);
      }
    } else {
      debugPrint("Failed to retrive auth token :$authToken");
    }
    return null;
  }
}
