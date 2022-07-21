import 'package:check_mate/utils/chat_token.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

Color primaryColor = Colors.purple[400]!;
bool isLogedin = false;
String? userId;
String? name;
String? userEmail;

String userToken = "";
setGoogleUser(GoogleSignInAccount user) async {
  userToken = await generateToken(user.id);
  savedAuthData(user, userToken);
  upDateApp();
}

setUserId(id, userName) async {
  final prefs = await SharedPreferences.getInstance();
  prefs.setString("userID", id);
  prefs.setString("name", userName);
  name = name;
  userId = id;
  await getAuthData();
  upDateApp();
}

savedAuthData(GoogleSignInAccount user, userToken) async {
  debugPrint("saving user data...");
  final prefs = await SharedPreferences.getInstance();
  prefs.setString("userEmail", user.email);
  prefs.setString("userToken", userToken);
}

Future getAuthData() async {
  final prefs = await SharedPreferences.getInstance();
  isLogedin = prefs.getBool("isLogedin") ?? false;
  if (!isLogedin) return;
  var user = prefs.getString("userID");
  if (user != null) userId = user;
  var email = prefs.getString("userEmail");
  if (email != null) userEmail = email;
  var token = prefs.getString("userToken");
  if (token != null) userToken = token;
  upDateApp();
}

setLogin() async {
  final prefs = await SharedPreferences.getInstance();
  prefs.setBool("isLogedin", true);
  upDateApp();
}

setLogOut() async {
  final prefs = await SharedPreferences.getInstance();
  prefs.setBool("isLogedin", false);
  upDateApp();
}

height(context) {
  return MediaQuery.of(context).size.height;
}

width(context) {
  return MediaQuery.of(context).size.width;
}

upDateApp() {
  WidgetsBinding.instance.performReassemble();
}

navigate({required context, required page, isDistroyed = false}) {
  (!isDistroyed)
      ? Navigator.push(context, MaterialPageRoute(builder: (context) => page))
      : Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => page));
}

void showSnackbar(String snackText) {
  Fluttertoast.showToast(
      msg: snackText,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 1);
}

displayDialog({
  context,
  index,
  title,
  subTitle,
}) async {
  return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(title),
          content: Text(subTitle),
          actions: <Widget>[
            TextButton(
              child: const Text(
                'NO',
                style: TextStyle(color: Colors.green),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text(
                'YES',
                style: TextStyle(color: Colors.green),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      });
}
