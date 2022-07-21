import 'package:check_mate/helper/consts.dart';
import 'package:check_mate/helper/data_fetch.dart';
import 'package:check_mate/pages/register/registerpage2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../widget/text_field.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key, required this.user}) : super(key: key);
  final GoogleSignInAccount user;

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController controller = TextEditingController();
  @override
  void dispose() {
    controller.dispose();
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
                Align(
                    alignment: Alignment.bottomCenter,
                    child: Image.asset(
                      "assets/images/landing_background.png",
                      width: width(context),
                      fit: BoxFit.fitWidth,
                    )),
                SizedBox(
                  height: height(context) * 0.8,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      "Your name!!😉"
                          .text
                          .size(25)
                          .color(primaryColor)
                          .bold
                          .make()
                          .centered(),
                      Input(
                        controller: controller,
                        hintText: "Enter your name",
                        color: Colors.grey[300],
                      ).pOnly(left: 30.w, right: 30.w, top: 50.h),
                      GestureDetector(
                        onTap: () {
                          if (controller.text == "") {
                            showSnackbar("Please Enter Your Name");
                          } else {
                            userData["name"] = controller.text;
                            userData["email"] = widget.user.email.toString();
                            userData["password"] = widget.user.id;
                            userData["confirmPassword"] = widget.user.id;
                            debugPrint(userData.toString());
                            upDateApp();
                            navigate(
                                context: context,
                                page: RegisterPage2(user: widget.user));
                          }
                        },
                        child: Container(
                          height: height(context) * 0.08,
                          width: width(context) * 0.4,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: primaryColor.withOpacity(
                                  (controller.text == "") ? 0.5 : 1)),
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
