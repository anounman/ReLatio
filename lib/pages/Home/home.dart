import 'dart:convert';
import 'dart:developer';

import 'package:check_mate/controller/update_current_location.dart';
import 'package:check_mate/helper/consts.dart';
import 'package:check_mate/main.dart';
import 'package:check_mate/model/get_user_model.dart';
import 'package:check_mate/model/user_data.dart';
import 'package:check_mate/pages/Home/widget/user_card.dart';
import 'package:check_mate/pages/match_page.dart';
import 'package:check_mate/pages/notificationservice/local_notification_service.dart';
import 'package:check_mate/utils/apis.dart';
import 'package:check_mate/utils/get_data.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_swipecards/flutter_swipecards.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../helper/data_fetch.dart';
import '../../utils/user_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

List<UserModel>? user;
List<UserModel>? filteredUser = [];

class _HomePageState extends State<HomePage>
    with AutomaticKeepAliveClientMixin {
  late CardController cardController;
  TextEditingController? controller;
  AccountData? accountData;
  String id = "";

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
        if (message.notification != null) {
          LocalNotificationService.createanddisplaynotification(message);
        }
      },
    );

    FirebaseMessaging.onMessageOpenedApp.listen(
      (message) {},
    );
  }

  void filterUsers() async {
    final prefs = await SharedPreferences.getInstance();
    id = prefs.getString("userID")!;
    // if (filteredUser!.isEmpty) {
    //   for (var i = 0; i < user!.length; i++) {
    //     debugPrint("ID:${user![i].likes.contains(id)}");
    //     if (!(user![i].likes.contains(id))) {
    //       filteredUser!.add(user![i]);
    //     }
    //   }
    // }
    filteredUser = user;
    debugPrint("User filter done.");
    setState(() {});
  }

  void setupNotifications() async {
    final firebaseMessaging = FirebaseMessaging.instance;
    final res = await firebaseMessaging.requestPermission();
    if (res.authorizationStatus != AuthorizationStatus.authorized) {
      throw ArgumentError(
          'You must allow notification permissions in order to receive push notifications');
    }
    FirebaseMessaging.onMessage.listen((message) async {
      debugPrint('message.data: ${message.data}');
    });
    FirebaseMessaging.onBackgroundMessage(onBackgroundMessage);
  }

  addNotificationToken(id) async {
    String token = await getDeviceTokenToSendNotification();
    debugPrint(token);
    var responce = await http.post(Uri.parse(Api.addNotificationKey),
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

  getUser() async {
    final prefs = await SharedPreferences.getInstance();
    String id = prefs.getString("userID") ?? "";
    debugPrint("Data:$id");
    accountData = await Data().getAccountData(id);
    await setUserData(accountData!);
    user = await UserData().getUserdata(accountData!.iterestedGender);
    log(user.toString());
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

    setState(() {});
    debugPrint("Conected");
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: (user == null)
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
                          // width: width(context) * 0.6,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisSize: MainAxisSize.min,
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
                      ],
                    ),
                    SizedBox(
                      height: height(context) * 0.76,
                      child: TinderSwapCard(
                          cardController: cardController,
                          allowVerticalMovement: false,
                          maxHeight: height(context) * 0.8,
                          maxWidth: width(context),
                          minWidth: width(context) * 0.79,
                          minHeight: height(context) * 0.79,
                          cardBuilder: (context, index) {
                            return (filteredUser![index].id == id)
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
                            if ((filteredUser![index].id != id)) {
                              if (orientation.name == "right") {
                                final url = Uri.parse(Api.likeUser);
                                final responce = await http.post(url,
                                    headers: {
                                      "Content-Type": "application/json"
                                    },
                                    body: jsonEncode({
                                      "like": filteredUser![index].id,
                                      "userID": id
                                    }));
                                if (responce.statusCode == 200) {
                                  showSnackbar("It's a match");
                                  await navigate(
                                      context: context,
                                      page: MatchPage(
                                        user: filteredUser![index],
                                      ));
                                }
                                filteredUser!.removeAt(index);
                              }
                            } else if (orientation.name == "left") {
                              if ((filteredUser![index].id == id)) {
                                filteredUser!.removeAt(index);
                              }
                              debugPrint("left");
                            } else if (orientation.name == "up") {
                              if ((filteredUser![index].id == id)) {}
                              debugPrint("up");
                            } else if (orientation.name == "down") {
                              if ((filteredUser![index].id == id)) {}
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
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
