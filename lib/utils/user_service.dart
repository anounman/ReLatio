import 'package:http/http.dart' as http;

import '../model/user_data.dart';

class UserData {
  Future<List<UserModel>?> getUserdata() async {
    final uri = Uri.parse("https://re-lation.herokuapp.com/users");
    final respoce = await http.get(uri);
    if (respoce.statusCode == 200) {
      return userFromJson(respoce.body);
    } else {
      return null;
    }
  }
}
