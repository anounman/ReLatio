import 'package:check_mate/helper/consts.dart';
import 'package:check_mate/helper/data_fetch.dart';
import 'package:check_mate/pages/register/registerpage3.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../widget/date_input.dart';

class RegisterPage2 extends StatefulWidget {
  const RegisterPage2({super.key, required this.user});
  final GoogleSignInAccount user;

  @override
  State<RegisterPage2> createState() => _RegisterPage2State();
}

class _RegisterPage2State extends State<RegisterPage2> {
  TextEditingController controller = TextEditingController();
  TextEditingController controller1 = TextEditingController();
  TextEditingController controller2 = TextEditingController();

  @override
  void dispose() {
    controller.dispose();
    controller1.dispose();
    controller2.dispose();
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          DInput(
                            controller: controller,
                            isNumber: true,
                            hintText: "DD",
                            maxInput: 2,
                            isNext: true,
                            color: Colors.grey[300],
                          ),
                          DInput(
                            controller: controller1,
                            maxInput: 2,
                            isNumber: true,
                            isNext: true,
                            hintText: "MM",
                            color: Colors.grey[300],
                          ),
                          DInput(
                            controller: controller2,
                            isNumber: true,
                            maxInput: 4,
                            isNext: false,
                            hintText: "YYYY",
                            color: Colors.grey[300],
                          ),
                        ],
                      ).pOnly(top: 50.h),
                      GestureDetector(
                        onTap: () {
                          if (controller1.text == "") {
                            showSnackbar("Please Enter you age");
                          } else {
                            if (controller1.text.length == 2 &&
                                controller.text.length == 2 &&
                                controller2.text.length == 4) {
                              String dob =
                                  "${controller.text}.${controller1.text}.${controller2.text}";

                              int age = ageCalculate(dob);
                              debugPrint("Age:$age");
                              if (age < 18) {
                                showSnackbar(
                                    "You are not old enogh to use this app");
                              } else {
                                if (!regExp.hasMatch(dob)) {
                                  showSnackbar("Please Enter A Valid DOB");
                                  return;
                                }
                                userData["age"] = dob;
                                debugPrint(userData.toString());
                                upDateApp();
                                navigate(
                                    context: context,
                                    page: RegisterPage3(user: widget.user));
                              }
                            } else {
                              showSnackbar("Please Ente A Valid DOB");
                            }
                          }
                        },
                        child: Container(
                          height: height(context) * 0.08,
                          width: width(context) * 0.4,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: primaryColor.withOpacity(
                                  (controller1.text.length == 2 &&
                                          controller.text.length == 2 &&
                                          controller2.text.length == 4)
                                      ? 1
                                      : 0.5)),
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
