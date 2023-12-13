import 'package:check_mate/pages/Chat/chat_page.dart';
import 'package:check_mate/pages/Home/home.dart';
import 'package:check_mate/pages/Profile/profile_page.dart';
import 'package:check_mate/pages/landingPage/landing_page.dart';
import 'package:check_mate/pages/likepage.dart/likepage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:velocity_x/velocity_x.dart';

import 'helper/consts.dart';
import 'helper/keep_page_alive.dart';

class PageSelector extends StatefulWidget {
  const PageSelector({super.key});

  @override
  State<PageSelector> createState() => _PageSelectorState();
}

class _PageSelectorState extends State<PageSelector> {
  int currentIndex = 0;

  List<Widget> pages = [
    const KeepAliveWrapper(child: HomePage()),
    const ChatPage(),
    const LikePage(),
    const ProfilePage(),
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

  setIndex(int i) {
    setState(() {
      currentIndex = i;
    });
  }

  Widget bottomAppbar(BuildContext context) {
    return Container(
      height: height(context) * 0.07,
      width: width(context),
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          InkWell(
            onTap: () {
              setIndex(0);
            },
            child: const Icon(
              Icons.home_filled,
              size: 30,
            ).opacity(value: (currentIndex == 0) ? 1 : 0.6),
          ),
          InkWell(
            onTap: () {
              setIndex(1);
            },
            child: const Icon(
              CupertinoIcons.chat_bubble_fill,
              size: 30,
            ).opacity(value: (currentIndex == 1) ? 1 : 0.6),
          ),
          InkWell(
            onTap: () {
              setIndex(2);
            },
            child: const Icon(
              CupertinoIcons.heart_fill,
              size: 30,
            ).opacity(value: (currentIndex == 2) ? 1 : 0.6),
          ),
          InkWell(
            onTap: () {
              setIndex(3);
            },
            child: const Icon(
              Icons.settings,
              size: 30,
            ).opacity(value: (currentIndex == 3) ? 1 : 0.6),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar:
          isLogedin == true ? bottomAppbar(context) : Container(),
      body: isLogedin == true
          ? SizedBox(
              height: MediaQuery.of(context).size.height * 0.96,
              child: pages[currentIndex],
            )
          : const LadingPage(),
    );
  }
}
