import 'package:check_mate/pages/Home/home.dart';
import 'package:check_mate/pages/landingPage/landing_page.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'helper/consts.dart';

class PageSelector extends StatefulWidget {
  const PageSelector({Key? key}) : super(key: key);

  @override
  State<PageSelector> createState() => _PageSelectorState();
}

class _PageSelectorState extends State<PageSelector> {
  List<Widget> pages = [
    const LadingPage(),
    const HomePage(),
  ];
  bool isLogedin = false;
  getLoginStatus() async {
    final prefs = await SharedPreferences.getInstance();
    isLogedin = prefs.getBool('isLogedin') ?? false;
    setState(() {});
  }

  @override
  void initState() {
    getLoginStatus();
    getAuthData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLogedin == true ? pages[1] : pages[0],
    );
  }
}
