import 'dart:convert';

import 'package:check_mate/helper/consts.dart';
import 'package:check_mate/model/get_user_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class Data {
  Future<AccountData?> getAccountData(id) async {
    debugPrint("ID:$id");
    final url = Uri.parse("https://api-relation.vercel.app/getData");
    final res = await http.post(url,
        headers: {
          "Content-Type": "application/json",
          "Authorization": authToken!
        },
        body: jsonEncode({"id": id.toString()}));
    if (res.statusCode == 200) {
      debugPrint(res.body);
      return userDataFromJson(res.body);
    } else {
      showSnackbar(
          "User Deleted , please contact to the devloper or clear your app data");
    }
    return null;
  }
}
