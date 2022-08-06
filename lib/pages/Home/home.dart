import 'dart:convert';

import 'package:check_mate/controller/update_current_location.dart';
import 'package:check_mate/helper/consts.dart';
import 'package:check_mate/helper/keep_page_alive.dart';
import 'package:check_mate/main.dart';
import 'package:check_mate/model/get_user_model.dart';
import 'package:check_mate/model/user_data.dart';
import 'package:check_mate/pages/Home/widget/user_card.dart';
import 'package:check_mate/pages/match_page.dart';
import 'package:check_mate/pages/notificationservice/local_notification_service.dart';
import 'package:check_mate/utils/get_data.dart';
import 'package:check_mate/widget/bottombar.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_swipecards/flutter_swipecards.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:http/http.dart' as http;
import '../../controller/chat_controller.dart';
import '../../helper/data_fetch.dart';
import '../../utils/user_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

List<UserModel>? user;
List<UserModel>? filteredUser = [];

class _HomePageState extends State<HomePage> {
  late CardController cardController;
  TextEditingController? controller;
  AccountData? accountData;
  StreamChatClient? client;

  @override
  void initState() {
    cardController = CardController();
    controller = TextEditingController();
    if (user == null) {
      getUser();
      getAuthData();
      getLocation();
    }
    setupNotifications();
    FirebaseMessaging.instance.getInitialMessage().then(
          (message) {},
        );
    FirebaseMessaging.onMessage.listen(
      (message) {
        print("FirebaseMessaging.onMessage.listen");
        if (message.notification != null) {
          print(message.notification!.title);
          print(message.notification!.body);
          print("message.data11 ${message.data}");
          LocalNotificationService.createanddisplaynotification(message);
        }
      },
    );

    FirebaseMessaging.onMessageOpenedApp.listen(
      (message) {},
    );

    super.initState();
  }

  void filterUsers() {
    for (var i = 0; i < user!.length; i++) {
      if (!(user![i].likes.contains(userId))) {
        filteredUser!.add(user![i]);
      }
    }
    setState(() {});
  }

  void setupNotifications() async {
    final firebaseMessaging = FirebaseMessaging.instance;
    final res = await firebaseMessaging.requestPermission();
    if (res.authorizationStatus != AuthorizationStatus.authorized) {
      throw ArgumentError(
          'You must allow notification permissions in order to receive push notifications');
    }
    firebaseMessaging.onTokenRefresh.listen(updateToken);
    FirebaseMessaging.onMessage.listen((message) async {
      debugPrint('message.data: ${message.data}');
      handleNotification(
        message,
        StreamChat.of(context).client,
      );
    });
    debugPrint("Conneted hahaha");
    FirebaseMessaging.onBackgroundMessage(onBackgroundMessage);
  }

  addNotificationToken(id) async {
    String token = await getDeviceTokenToSendNotification();
    updateToken(token);
    debugPrint(token);
    var responce = await http.post(
        Uri.parse("https://re-lation.herokuapp.com/addNotificationToken"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"id": id, "notKey": token}));
    debugPrint(responce.body.toString());
    debugPrint("Notificaiton Token ${responce.body}");
  }

  Future getDeviceTokenToSendNotification() async {
    final prefs = await SharedPreferences.getInstance();
    String id = prefs.getString("userID")!;
    final FirebaseMessaging fcm = FirebaseMessaging.instance;
    final token = await fcm.getToken(vapidKey: id);
    return token.toString();
  }

  updateToken(String token) {
    StreamChat.of(context).client.addDevice(token, PushProvider.firebase);
  }

  getUser() async {
    accountData = await Data().getAccountData(userId);
    await setUserData(accountData!);
    if (client == null) connetct();
    user = await UserData().getUserdata(accountData!.iterestedGender);
    UpdateLocation().updateLocation(accountData!.id);
    filterUsers();
    setState(() {});
  }

  Future connetct() async {
    final prefs = await SharedPreferences.getInstance();
    final id = prefs.getString("userID");
    addNotificationToken(id);
    // final token = prefs.getString("userToken");
    debugPrint("Connectiong.....");
    debugPrint("id and token:$id");
    // ignore: use_build_context_synchronously
    client = StreamChatCore.of(context).client;
    // // userToken = await generateToken(id);
    userToken = client!.devToken(id.toString()).rawValue;
    // debugPrint(userToken);
    client!.connectUser(
      User(id: id.toString(), name: name, extraData: {
        'name': name,
      }),
      userToken,
    );
    setState(() {});
    debugPrint("Conected");
  }

  @override
  Widget build(BuildContext context) {
    return KeepAlivePage(
      child: Scaffold(
        backgroundColor: Colors.white,
        bottomNavigationBar: (user == null)
            ? null
            : BottomBar(
                currentIndex: 0,
              ),
        body: (filteredUser == null)
            ? Container(
                color: Colors.white,
                child: Image.asset("assets/images/loading.gif").centered(),
              ).centered()
            : Container(
                color: Colors.white,
                height: height(context),
                width: width(context),
                child: SafeArea(
                  child: ListView(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
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
                                        : location.text.justify.start.make(),
                                  ],
                                ).pOnly(top: 5.h)
                              ],
                            ),
                          ).pOnly(left: 10.w),
                          // SizedBox(
                          //   child: Row(children: [
                          //     // if (userId != null)
                          //     //   CircleAvatar(
                          //     //     radius: 15.r,
                          //     //     backgroundImage:
                          //     //         NetworkImage(googleUser!.photoUrl.toString()),
                          //     //   ).pOnly(right: 10.w),
                          //     Container(
                          //       height: 30.h,
                          //       width: 35.w,
                          //       decoration: BoxDecoration(
                          //         boxShadow: [
                          //           BoxShadow(
                          //             color: Colors.grey[200]!,
                          //             offset: const Offset(0.0, 1.0), //(x,y)
                          //             blurRadius: 4,
                          //           ),
                          //         ],
                          //         color: Colors.white,
                          //         borderRadius: BorderRadius.circular(10),
                          //       ),
                          //       child: Center(
                          //         child: Stack(
                          //           children: [
                          //             const Icon(
                          //               Icons.notifications,
                          //               color: Colors.grey,
                          //             ).opacity(value: 0.9).centered(),
                          //             Align(
                          //               alignment: Alignment.topRight,
                          //               child: Container(
                          //                 height: 5.h,
                          //                 width: 5.h,
                          //                 decoration: BoxDecoration(
                          //                     borderRadius:
                          //                         BorderRadius.circular(100),
                          //                     color: Colors.purple),
                          //               ),
                          //             ).pOnly(top: 7.h, right: 10.w)
                          //           ],
                          //         ),
                          //       ),
                          //     ),
                          //   ]),
                          // )
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
                              return (filteredUser![index].id == userId)
                                  ? Container()
                                  : UserCard(
                                      user: filteredUser![index],
                                      cardController: cardController);
                            },
                            swipeUpdateCallback:
                                (DragUpdateDetails details, Alignment align) {
                              /// Get swiping card's alignment
                              if (align.x < 0) {
                                //Card is LEFT swiping
                              } else if (align.x > 0) {
                                //Card is RIGHT swiping
                              } else if (align.y > 0) {
                                debugPrint("up");
                                //Card is Up swiping
                              }
                            },
                            swipeCompleteCallback:
                                (CardSwipeOrientation orientation,
                                    int index) async {
                              if ((filteredUser![index].id != userId)) {
                                if (orientation.name == "right") {
                                  final url = Uri.parse(
                                      "https://re-lation.herokuapp.com/like");
                                  final responce = await http.post(url,
                                      headers: {
                                        "Content-Type": "application/json"
                                      },
                                      body: jsonEncode({
                                        "like": filteredUser![index].id,
                                        "userID": userId
                                      }));
                                  if (responce.statusCode == 200) {
                                    showSnackbar("It's a match");
                                    await navigate(
                                        context: context,
                                        page: MatchPage(
                                          user: filteredUser![index],
                                        ));
                                    await createChannel(
                                        // ignore: use_build_context_synchronously
                                        StreamChatCore.of(context),
                                        filteredUser![index].id);
                                  }
                                }
                              } else if (orientation.name == "left") {
                                if ((filteredUser![index].id == userId)) {}
                                debugPrint("left");
                              } else if (orientation.name == "up") {
                                if ((filteredUser![index].id == userId)) {}
                                debugPrint("up");
                              } else if (orientation.name == "down") {
                                if ((filteredUser![index].id == userId)) {}
                                debugPrint("down");
                              }

                              if (index == (filteredUser!.length - 1)) {
                                showSnackbar(
                                    "Sorry we don't have more accounts in your location");
                              }
                            },
                            totalNum: filteredUser!.length),
                      ).pOnly(top: 20.h)
                    ],
                  ).pOnly(top: 20.h),
                ),
              ),
      ),
    );
  }
}
