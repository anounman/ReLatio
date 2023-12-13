import 'dart:convert';

import 'package:check_mate/helper/consts.dart';
import 'package:check_mate/model/get_user_model.dart';
import 'package:check_mate/utils/apis.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Data {
  Future<AccountData?> getAccountData(id) async {
    debugPrint("ID:$id");
    final url = Uri.parse(Api.getUserData);
    final prefs = await SharedPreferences.getInstance();
    authToken = prefs.getString('authToken');
    debugPrint("auth token for get account data:$authToken");
    final res = await http.post(url,
        headers: {
          "Content-Type": "application/json",
          "Authorization": authToken ?? "",
        },
        body: jsonEncode({
          "id": id.toString(),
        }));
    debugPrint("Data out put:${res.body.toString()}");
    if (res.statusCode == 200) {
      debugPrint("account data :${res.body}");
      return userDataFromJson(res.body);
    } else {
      showSnackbar(
          "User Deleted , please contact to the devloper or clear your app data");
    }
    return null;
  }
}
