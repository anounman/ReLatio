import 'package:check_mate/pages/Home/home.dart';
import 'package:check_mate/pages/Home/widget/user_card.dart';
import 'package:check_mate/widget/bottombar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_swipecards/flutter_swipecards.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';
import 'package:velocity_x/velocity_x.dart';
import '../../controller/chat_controller.dart';
import '../../helper/consts.dart';
import '../match_page.dart';

class LikePage extends StatefulWidget {
  const LikePage({Key? key}) : super(key: key);

  @override
  State<LikePage> createState() => _LikePageState();
}

class _LikePageState extends State<LikePage> {
  late CardController cardController;
  TextEditingController? controller;
  @override
  void initState() {
    cardController = CardController();
    controller = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: BottomBar(currentIndex: 2),
      body: ListView(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          "Liked You"
              .text
              .bold
              .size(30.sp)
              .make()
              .pOnly(top: 20.h, left: 20.w, bottom: 10.h),
          SizedBox(
            height: height(context) * 0.8,
            width: width(context),
            child: TinderSwapCard(
                cardController: cardController,
                allowVerticalMovement: false,
                maxHeight: height(context) * 0.8,
                maxWidth: width(context),
                minWidth: width(context) * 0.8,
                minHeight: height(context) * 0.79,
                cardBuilder: (context, index) {
                  return (!likes!.contains(user![index].id))
                      ? Container()
                      : UserCard(
                          user: user![index], cardController: cardController);
                },
                swipeUpdateCallback:
                    (DragUpdateDetails details, Alignment align) {
                  /// Get swiping card's alignment
                  if (align.x < 0) {
                    //Card is LEFT swiping
                  } else if (align.x > 0) {
                    //Card is RIGHT swiping
                  } else if (align.y > 0) {
                    //Card is Up swiping
                  }
                },
                swipeCompleteCallback:
                    (CardSwipeOrientation orientation, int index) async {
                  if (orientation.name == "right") {
                    if ((likes!.contains(user![index].id))) {
                      showSnackbar("It's a match");
                      await navigate(
                          context: context,
                          page: MatchPage(
                            user: user![index],
                          ));
                      await createChannel(
                          // ignore: use_build_context_synchronously
                          StreamChatCore.of(context),
                          user![index].id);
                    }
                  } else if (orientation.name == "left") {
                    if ((likes!.contains(user![index].id))) {}
                    debugPrint("left");
                  } else if (orientation.name == "up") {
                    if ((likes!.contains(user![index].id))) {}
                    debugPrint("up");
                  } else if (orientation.name == "down") {
                    if ((likes!.contains(user![index].id))) {}
                    debugPrint("down");
                  }

                  if (index == (user!.length - 1)) {
                    showSnackbar(
                        "Sorry we don't have more accounts in your location");
                  }
                },
                totalNum: user!.length),
          )
        ],
      ),
    );
  }
}
