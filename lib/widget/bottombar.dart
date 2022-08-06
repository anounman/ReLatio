import 'package:check_mate/helper/consts.dart';
import 'package:check_mate/pages/Chat/chat_home.dart';
import 'package:check_mate/pages/Home/home.dart';
import 'package:check_mate/pages/likepage.dart/likepage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

import '../pages/Profile/profile_page.dart';

class BottomBar extends StatefulWidget {
  BottomBar({Key? key, required this.currentIndex}) : super(key: key);
  int currentIndex;

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  setIndex(int i) {
    setState(() {
      widget.currentIndex = i;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height(context) * 0.06,
      width: width(context),
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          InkWell(
            onTap: () {
              if ((widget.currentIndex != 0)) {
                navigate(
                    context: context,
                    page: const HomePage(),
                    isDistroyed: true);
              }
              setIndex(0);
            },
            child: const Icon(
              Icons.home_filled,
              size: 30,
            ).opacity(value: (widget.currentIndex == 0) ? 1 : 0.6),
          ),
          InkWell(
            onTap: () {
              if (widget.currentIndex != 1) {
                navigate(context: context, page: const ChannelListPage());
              }
            },
            child: const Icon(
              CupertinoIcons.chat_bubble_fill,
              size: 30,
            ).opacity(value: (widget.currentIndex == 1) ? 1 : 0.6),
          ),
          InkWell(
            onTap: () {
              if (widget.currentIndex != 2) {
                navigate(
                    context: context,
                    page: const LikePage(),
                    isDistroyed: true);
              }
              setIndex(2);
            },
            child: const Icon(
              CupertinoIcons.heart_fill,
              size: 30,
            ).opacity(value: (widget.currentIndex == 2) ? 1 : 0.6),
          ),
          InkWell(
            onTap: () {
              if (widget.currentIndex != 3) {
                navigate(
                    context: context,
                    page: const ProfilePage(),
                    isDistroyed: true);
              }

              setIndex(3);
            },
            child: const Icon(
              Icons.settings,
              size: 30,
            ).opacity(value: (widget.currentIndex == 3) ? 1 : 0.6),
          ),
        ],
      ),
    );
  }
}
