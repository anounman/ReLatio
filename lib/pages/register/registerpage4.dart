import 'package:check_mate/helper/consts.dart';
import 'package:check_mate/helper/data_fetch.dart';
import 'package:check_mate/pages/register/upload_photo/photo_uploa.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:velocity_x/velocity_x.dart';

class RegisterPage4 extends StatefulWidget {
  const RegisterPage4({Key? key, required this.user}) : super(key: key);
  final GoogleSignInAccount user;

  @override
  State<RegisterPage4> createState() => _RegisterPage4State();
}

class _RegisterPage4State extends State<RegisterPage4> {
  List<Map<dynamic, String>> image = [
    {
      "gender": "Male",
      "image": "assets/images/female.png",
    },
    {
      "gender": "Female",
      "image": "assets/images/male.png",
    }
  ];
  int _curentIndex = 3;
  setIndex(index) {
    setState(() {
      _curentIndex = index;
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  TextEditingController controller1 = TextEditingController();
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
                      "assets/images/background2.png",
                      width: width(context),
                      fit: BoxFit.fitWidth,
                    )),
                SizedBox(
                  height: height(context) * 0.8,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      "Show me!!🥱"
                          .text
                          .size(25)
                          .color(primaryColor)
                          .bold
                          .make()
                          .centered(),
                      SizedBox(
                        height: height(context) * 0.25,
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ListView.builder(
                                  itemCount: 2,
                                  shrinkWrap: true,
                                  scrollDirection: Axis.horizontal,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemBuilder: (context, index) {
                                    return GestureDetector(
                                      onTap: () => setIndex(index),
                                      child: Container(
                                        height: height(context) * 0.2,
                                        width: width(context) * 0.4,
                                        decoration: BoxDecoration(
                                            color: (_curentIndex == index)
                                                ? primaryColor
                                                : null,
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            border: Border.all(
                                                color: (_curentIndex == index)
                                                    ? primaryColor
                                                    : Colors.black)),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Image.asset(image[index]["image"]
                                                .toString()),
                                            image[index]["gender"]
                                                .toString()
                                                .text
                                                .color((_curentIndex == index)
                                                    ? Colors.white
                                                    : Colors.black)
                                                .make()
                                                .centered(),
                                          ],
                                        ).centered(),
                                      ).p(10),
                                    );
                                  })
                            ]),
                      ).pOnly(top: 20.h),
                      GestureDetector(
                        onTap: () => setIndex(2),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              height: 20.h,
                              width: 25.w,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color:
                                      (_curentIndex == 2) ? primaryColor : null,
                                  border: Border.all(
                                      width: (_curentIndex == 2) ? 0 : 1)),
                            ),
                            "Everyone".text.size(20).make().pOnly(left: 10.w)
                          ],
                        ).centered().pOnly(top: 10.h),
                      ),
                      GestureDetector(
                        onTap: () {
                          if (_curentIndex == 3) {
                            showSnackbar(
                                "Please select your interested gender");
                          } else {
                            if (_curentIndex != 2) {
                              userData["iterestedGender"] =
                                  image[_curentIndex]["gender"];
                            } else {
                              userData["iterestedGender"] = "Everyone";
                            }
                            debugPrint(userData.toString());
                            upDateApp();
                            navigate(
                                context: context,
                                page: const PhotoUploadPage());
                          }
                        },
                        child: Container(
                          height: height(context) * 0.08,
                          width: width(context) * 0.4,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: primaryColor
                                  .withOpacity((_curentIndex == 3) ? 0.5 : 1)),
                          child: "Continue"
                              .text
                              .white
                              .bold
                              .size(20)
                              .make()
                              .centered(),
                        ).pOnly(top: 20.h),
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
