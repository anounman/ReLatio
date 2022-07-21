import 'package:check_mate/helper/consts.dart';
import 'package:check_mate/helper/data_fetch.dart';
import 'package:check_mate/pages/Home/home.dart';
import 'package:check_mate/pages/register/registerpage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_sign_in/google_sign_in.dart';
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
        body: SingleChildScrollView(
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
                          Image.asset(loadingPageImage[index]).pOnly(top: 50.h),
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
                          GoogleSignInAccount user = await googlesignIn();
                          //set id and email value to a gobal variable
                          await setGoogleUser(user);
                          bool isExist = await checkUser(user.email);
                          debugPrint("isExist: $isExist , ${user.email}");
                          if (isExist) {
                            showSnackbar("Welcome Back!!");
                            navigate(context: context, page: const HomePage());
                          } else {
                            debugPrint(user.toString());
                            if (user != null) {
                              setLogin();
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
                                  mainAxisAlignment: MainAxisAlignment.center,
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
                  .pOnly(top: 10.h),
            ],
          ).p(20),
        ));
  }
}
