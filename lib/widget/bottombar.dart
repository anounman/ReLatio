import 'package:check_mate/helper/consts.dart';
import 'package:check_mate/pages/Chat/chat_home.dart';
import 'package:check_mate/pages/Home/home.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

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
              setIndex(0);
              navigate(context: context, page: const HomePage());
            },
            child: const Icon(
              Icons.home_filled,
              size: 30,
            ).opacity(value: (widget.currentIndex == 0) ? 1 : 0.6),
          ),
          InkWell(
            onTap: () {
              navigate(context: context, page: const ChannelListPage());
            },
            child: const Icon(
              CupertinoIcons.chat_bubble_fill,
              size: 30,
            ).opacity(value: (widget.currentIndex == 1) ? 1 : 0.6),
          ),
          InkWell(
            onTap: () => setIndex(2),
            child: const Icon(
              CupertinoIcons.heart_fill,
              size: 30,
            ).opacity(value: (widget.currentIndex == 2) ? 1 : 0.6),
          ),
          InkWell(
            onTap: () => setIndex(3),
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
