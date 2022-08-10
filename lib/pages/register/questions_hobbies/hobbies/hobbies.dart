import 'package:check_mate/helper/data_fetch.dart';
import 'package:check_mate/model/form_data.dart';
import 'package:check_mate/pages/register/questions_hobbies/hobbies/hobbie_box.dart';
import 'package:check_mate/utils/formdata_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:restart_app/restart_app.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../../../helper/consts.dart';
import '../../../../utils/signup.dart';

class Hobbies extends StatefulWidget {
  const Hobbies({Key? key}) : super(key: key);

  @override
  State<Hobbies> createState() => _HobbiesState();
}

class _HobbiesState extends State<Hobbies> {
  List<ApiFormData>? formData;
  @override
  void initState() {
    getData();
    super.initState();
  }

  List<String> seledtedHoobies = [];
  getData() async {
    formData = await FormDataService().getFormData();
    debugPrint("PostData:${formData![0].hobbies[0].hobbie}");
    // _currentIndex = (formData![0].hobbies.length);
    setState(() {});
  }

  bool isSigninUp = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        floatingActionButton: (seledtedHoobies.length < 5)
            ? null
            : GestureDetector(
                onTap: () async {
                  userData["hobbies"] = [seledtedHoobies];
                  upDateApp();
                  isSigninUp = true;
                  setState(() {});
                  List<String> data = (await signUp())!;
                  if (data.isNotEmpty) setUserId(data[0], data[1]);
                  // ignore: use_build_context_synchronously
                  // Navigator.pop(context);
                  // // ignore: use_build_context_synchronously
                  // Navigator.pop(context);
                  // // ignore: use_build_context_synchronously
                  // Navigator.pop(context);
                  // // ignore: use_build_context_synchronously
                  // Navigator.pop(context);
                  // // ignore: use_build_context_synchronously
                  // Navigator.pop(context);
                  setLogin();
                  Restart.restartApp();
                },
                child: Container(
                  height: height(context) * 0.07,
                  width: height(context) * 0.07,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      color: primaryColor),
                  child: const RotatedBox(
                      quarterTurns: 2,
                      child: Icon(
                        Icons.arrow_back_ios,
                        color: Colors.white,
                        size: 30,
                      )).centered().pOnly(right: 10.w),
                ),
              ),
        body: (isSigninUp)
            ? Container(
                height: height(context),
                width: width(context),
                color: Colors.white,
                child: Center(child: Image.asset("assets/images/loading.gif")))
            : (formData == null)
                ? const CircularProgressIndicator().centered()
                : SafeArea(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          GestureDetector(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: const Align(
                                  alignment: Alignment.topLeft,
                                  child: Icon(Icons.arrow_back_ios))),
                          "Select your hobbies"
                              .text
                              .size(24)
                              .bold
                              .black
                              .make()
                              .centered()
                              .pOnly(top: 20.h),
                          "Your hobbies will be displayed on your profile"
                              .text
                              .justify
                              .center
                              .size(12.sp)
                              .make()
                              .pOnly(top: 20.h),
                          Wrap(
                            spacing: 8,
                            runSpacing: 8,
                            children: List.generate(
                                formData![0].hobbies.length,
                                (index) => GestureDetector(
                                      onTap: () {
                                        if (!seledtedHoobies.contains(
                                            formData![0]
                                                .hobbies[index]
                                                .hobbie)) {
                                          seledtedHoobies.add(formData![0]
                                              .hobbies[index]
                                              .hobbie);
                                        } else {
                                          seledtedHoobies.remove(formData![0]
                                              .hobbies[index]
                                              .hobbie);
                                        }
                                        setState(() {});
                                      },
                                      child: hobbieCard(
                                          isClicked: seledtedHoobies.contains(
                                              formData![0]
                                                  .hobbies[index]
                                                  .hobbie),
                                          hoobie: formData![0]
                                              .hobbies[index]
                                              .hobbie),
                                    )),
                          ).pOnly(top: 30.h),
                        ],
                      ).p(20),
                    ),
                  ));
  }
}
