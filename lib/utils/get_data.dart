import 'dart:convert';

import 'package:check_mate/helper/consts.dart';
import 'package:check_mate/model/get_user_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class Data {
  Future<AccountData?> getAccountData(id) async {
    final url = Uri.parse("https://re-lation.herokuapp.com/getData");
    final res = await http.post(url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "id": id.toString(),
          "Authentication": authToken,
        }));
    if (res.statusCode == 200) {
      debugPrint(res.body);
      return userDataFromJson(res.body);
    } else if (res.statusCode == 400) {
      showSnackbar(
          "User Deleted , please contact to the devlopers or clear your app data");
    }
    return null;
  }
}
