import 'package:check_mate/helper/consts.dart';
import 'package:check_mate/helper/data_fetch.dart';
import 'package:check_mate/pages/Home/home.dart';
import 'package:check_mate/pages/register/registerpage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../controller/get_geolocation.dart';
import '../../controller/google_signin.dart';
import '../../data/loding_page.dart';

class LadingPage extends StatefulWidget {
  const LadingPage({Key? key}) : super(key: key);

  @override
  State<LadingPage> createState() => _LadingPageState();
}

class _LadingPageState extends State<LadingPage> {
  PageController controller = PageController();
  int current = 0;
  bool isCheck = false;
  @override
  void initState() {
    LocationController().initLocation();
    getAuthData();
    getLocation();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: (isCheck)
            ? Image.asset("assets/images/loading.gif").centered()
            : SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      height: height(context) * 0.8,
                      width: width(context),
                      child: PageView.builder(
                          controller: controller,
                          onPageChanged: (index) {
                            setState(() {
                              current = index;
                            });
                          },
                          scrollDirection: Axis.horizontal,
                          itemCount: loadingPageImage.length,
                          itemBuilder: (BuildContext context, index) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Image.asset(loadingPageImage[index])
                                    .pOnly(top: 50.h),
                                loadingPageData[index]["title"]
                                    .toString()
                                    .text
                                    .size(35)
                                    .bold
                                    .justify
                                    .start
                                    .color(primaryColor)
                                    .make()
                                    .pOnly(top: 20.h),
                                SizedBox(
                                  width: width(context) * 0.5,
                                  child: loadingPageData[index]["subtitle"]
                                      .toString()
                                      .text
                                      .justify
                                      .start
                                      .size(15)
                                      .make()
                                      .opacity(value: 0.5)
                                      .pOnly(top: 5.h),
                                ),
                              ],
                            );
                          }),
                    ),
                    GestureDetector(
                            onTap: () async {
                              if (current != 2) {
                                controller.nextPage(
                                    duration: const Duration(seconds: 2),
                                    curve: Curves.easeOutCirc);
                              } else {
                                setState(() {
                                  isCheck = true;
                                });
                                GoogleSignInAccount user = await googlesignIn();
                                //set id and email value to a gobal variable
                                await setGoogleUser(user);
                                bool isExist = await checkUser(user.email);
                                setState(() {
                                  isCheck = false;
                                });
                                debugPrint("isExist: $isExist , ${user.email}");
                                if (isExist) {
                                  showSnackbar("Welcome Back!!");
                                  navigate(
                                      context: context, page: const HomePage());
                                } else {
                                  debugPrint(user.toString());
                                  if (user != null) {
                                    navigate(
                                        context: context,
                                        page: RegisterPage(user: user),
                                        isDistroyed: true);
                                  } else {
                                    showSnackbar("Sign In Faild");
                                  }
                                }
                              }
                            },
                            child: Container(
                                height: height(context) * 0.07,
                                width: (current == 2)
                                    ? width(context) * 0.7
                                    : width(context) * 0.55,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(30),
                                    color: primaryColor),
                                child: (current != 2)
                                    ? "Continue"
                                        .text
                                        .bold
                                        .size(15)
                                        .white
                                        .make()
                                        .centered()
                                    : Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Image.asset(
                                            "assets/images/google.png",
                                            color: Colors.white,
                                          ).scale(scaleValue: 0.3),
                                          "Continue with google"
                                              .text
                                              .bold
                                              .size(15)
                                              .white
                                              .make()
                                              .centered(),
                                        ],
                                      ).pOnly(right: 10.w)))
                        .pOnly(top: 5.h),
                    (current == 2)
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              "By clicking continue , you agree with our"
                                  .text
                                  .size(12)
                                  .make()
                                  .pOnly(top: 10),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  GestureDetector(
                                    onTap: () async {
                                      await launchURL(context,
                                          "https://sites.google.com/view/re-lation/home");
                                    },
                                    child: "Terms and Conditions"
                                        .text
                                        .size(12)
                                        .color(primaryColor)
                                        .make(),
                                  ),
                                  "&".text.size(12).make(),
                                  GestureDetector(
                                    onTap: () async {
                                      await launchURL(context,
                                          "https://sites.google.com/view/re-lation-privacy/home");
                                    },
                                    child: "Privacy and Policy"
                                        .text
                                        .size(12)
                                        .color(primaryColor)
                                        .make(),
                                  ),
                                ],
                              )
                            ],
                          )
                        : Container(),
                  ],
                ).p(20),
              ));
  }
}
