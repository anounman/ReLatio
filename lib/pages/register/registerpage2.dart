import 'package:check_mate/helper/consts.dart';
import 'package:check_mate/helper/data_fetch.dart';
import 'package:check_mate/pages/register/registerpage3.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../widget/text_field.dart';

class RegisterPage2 extends StatefulWidget {
  const RegisterPage2({Key? key, required this.user}) : super(key: key);
  final GoogleSignInAccount user;

  @override
  State<RegisterPage2> createState() => _RegisterPage2State();
}

class _RegisterPage2State extends State<RegisterPage2> {
  TextEditingController controller1 = TextEditingController();
  @override
  void dispose() {
    controller1.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
            height: height(context),
            child: Stack(
              children: [
                GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: const Icon(Icons.arrow_back_ios).p(30)),
                Align(
                    alignment: Alignment.bottomCenter,
                    child: Image.asset(
                      "assets/images/background1.png",
                      width: width(context),
                      fit: BoxFit.fitWidth,
                    )),
                SizedBox(
                  height: height(context) * 0.8,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      "Enter Your Age!!🎉"
                          .text
                          .size(25)
                          .color(primaryColor)
                          .bold
                          .make()
                          .centered(),
                      Input(
                        controller: controller1,
                        isNumber: true,
                        hintText: "18",
                        color: Colors.grey[300],
                      ).pOnly(left: 30.w, right: 30.w, top: 50.h),
                      GestureDetector(
                        onTap: () {
                          if (controller1.text == "") {
                            showSnackbar("Please Enter you age");
                          } else {
                            if (controller1.text.length == 2) {
                              if (int.parse(controller1.text.toString()) < 18) {
                                showSnackbar(
                                    "You are not old enogh to use this app");
                              } else {
                                userData["age"] = controller1.text;
                                debugPrint(userData.toString());
                                upDateApp();
                                navigate(
                                    context: context,
                                    page: RegisterPage3(user: widget.user));
                              }
                            } else {
                              showSnackbar("Please Ente A Valid Age");
                            }
                          }
                        },
                        child: Container(
                          height: height(context) * 0.08,
                          width: width(context) * 0.4,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: primaryColor.withOpacity(
                                  (controller1.text.length == 2) ? 1 : 0.5)),
                          child: "Continue"
                              .text
                              .white
                              .bold
                              .size(20)
                              .make()
                              .centered(),
                        ).pOnly(top: 40.h),
                      )
                    ],
                  ),
                ),
              ],
            )),
      ),
    );
  }
}
