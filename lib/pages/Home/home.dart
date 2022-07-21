import 'package:check_mate/helper/consts.dart';
import 'package:check_mate/model/user_data.dart';
import 'package:check_mate/pages/Home/widget/user_card.dart';
import 'package:check_mate/widget/bottombar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_swipecards/flutter_swipecards.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../controller/chat_controller.dart';
import '../../helper/data_fetch.dart';
import '../../utils/user_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

List<UserModel>? user;

class _HomePageState extends State<HomePage> {
  late CardController cardController;
  TextEditingController? controller;

  @override
  void initState() {
    cardController = CardController();
    controller = TextEditingController();
    getUser();
    getAuthData();
    getLocation();

    super.initState();
  }

  getUser() async {
    user = await UserData().getUserdata();
    connetct();

    setState(() {});
  }

  Future connetct() async {
    final prefs = await SharedPreferences.getInstance();
    final id = prefs.getString("userID");
    final token = prefs.getString("userToken");
    debugPrint("Connectiong.....");
    debugPrint("id and token:$id , $token");
    var client = StreamChat.of(context).client;
    client.connectUser(
      User(id: id.toString() , extraData: {
        'name' : name,
      }), 
      client.devToken(id.toString()).rawValue,
    );
    debugPrint(StreamChat.of(context).currentUser!.id);

    debugPrint("Conected");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: BottomBar(
        currentIndex: 0,
      ),
      body: (user == null)
          ? Container(
              color: Colors.white,
              child: Image.asset("assets/images/loading.gif").centered(),
            ).centered()
          : SingleChildScrollView(
              child: Container(
                color: Colors.white,
                height: height(context),
                width: width(context),
                child: SafeArea(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          SizedBox(
                            width: width(context) * 0.6,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Icon(
                                      Icons.location_on,
                                      color: primaryColor,
                                    ),
                                    (location == "")
                                        ? const CircularProgressIndicator()
                                            .scale(scaleValue: 0.2)
                                        : location.text.wide.make(),
                                  ],
                                ).pOnly(top: 5.h)
                              ],
                            ),
                          ).pOnly(right: 30.w),
                          SizedBox(
                            child: Row(children: [
                              // if (userId != null)
                              //   CircleAvatar(
                              //     radius: 15.r,
                              //     backgroundImage:
                              //         NetworkImage(googleUser!.photoUrl.toString()),
                              //   ).pOnly(right: 10.w),
                              Container(
                                height: 30.h,
                                width: 35.w,
                                decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey[200]!,
                                      offset: const Offset(0.0, 1.0), //(x,y)
                                      blurRadius: 4,
                                    ),
                                  ],
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Center(
                                  child: Stack(
                                    children: [
                                      const Icon(
                                        Icons.notifications,
                                        color: Colors.grey,
                                      ).opacity(value: 0.9).centered(),
                                      Align(
                                        alignment: Alignment.topRight,
                                        child: Container(
                                          height: 5.h,
                                          width: 5.h,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(100),
                                              color: Colors.purple),
                                        ),
                                      ).pOnly(top: 7.h, right: 10.w)
                                    ],
                                  ),
                                ),
                              ),
                            ]),
                          )
                        ],
                      ),
                      SizedBox(
                        height: height(context) * 0.8,
                        child: TinderSwapCard(
                            cardController: cardController,
                            allowVerticalMovement: false,
                            maxHeight: height(context) * 0.8,
                            maxWidth: width(context),
                            minWidth: width(context) * 0.79,
                            minHeight: height(context) * 0.79,
                            cardBuilder: (context, index) {
                              return UserCard(
                                image: user![index].pictures,
                                name: user![index].name,
                                hoobies: user![index].hobbies[0],
                                cardController: cardController,
                              );
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
                                (CardSwipeOrientation orientation,
                                    int index) async {
                              if (orientation.name == "right") {
                                debugPrint("right");
                                await createChannel(
                                    StreamChat.of(context), user![index].id);
                              } else if (orientation.name == "left") {
                                debugPrint("left");
                              } else if (orientation.name == "up") {
                                debugPrint("up");
                              } else if (orientation.name == "down") {
                                debugPrint("down");
                              }

                              if (index == (user!.length - 1)) {
                                showSnackbar(
                                    "Sorry we don't have more accounts in your location");
                              }
                            },
                            totalNum: user!.length),
                      ).pOnly(top: 20.h)
                    ],
                  ).pOnly(top: 20.h),
                ),
              ),
            ),
    );
  }
}
