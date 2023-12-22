import 'package:check_mate/model/form_data.dart';
import 'package:check_mate/pages/Home/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../../../helper/consts.dart';
import '../../../../utils/signup.dart';

class QuestionPage extends StatefulWidget {
  QuestionPage({super.key, required this.post});
  List<ApiFormData> post;

  @override
  State<QuestionPage> createState() => _QuestionPageState();
}

class _QuestionPageState extends State<QuestionPage> {
  bool isSigninUp = false;
  String dorpDown1 = "";
  String dropDown2 = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
              child: (isSigninUp)
                  ? Center(child: Image.asset("assets/images/loading.gif"))
                  : SingleChildScrollView(
                      child: Column(
                        children: [
                          GestureDetector(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: const Align(
                                  alignment: Alignment.topLeft,
                                  child: Icon(Icons.arrow_back_ios))),
                          "Please answer all this"
                              .text
                              .size(24)
                              .bold
                              .black
                              .make()
                              .centered()
                              .pOnly(top: 20.h),
                          "Please help us to find find your best matchs"
                              .text
                              .justify
                              .center
                              .size(12.sp)
                              .make()
                              .pOnly(top: 20.h),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              widget.post[0].questions[0].question.text
                                  .size(25)
                                  .make()
                                  .pOnly(top: 10),
                              Container(
                                height: height(context) * 0.08,
                                width: width(context),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20.0),
                                    color: primaryColor.withOpacity(0.5)),
                                child: DropdownButtonFormField(
                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: "Select an item...",
                                      hintStyle:
                                          TextStyle(color: Colors.grey[250])),
                                  items: List.generate(
                                      widget
                                          .post[0].questions[0].options.length,
                                      (optionIndex) => DropdownMenuItem(
                                          value: widget.post[0].questions[0]
                                              .options[optionIndex].option,
                                          child: widget.post[0].questions[0]
                                              .options[optionIndex].option.text
                                              .color(Colors.black)
                                              .make())),
                                  onChanged: (val) {
                                    dorpDown1 = val.toString();
                                    setState(() {});
                                  },
                                ).centered().p(10),
                              )
                            ],
                          ).pOnly(top: 50.h, left: 5.w, right: 5.w),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              widget.post[0].questions[1].question.text
                                  .size(25)
                                  .make()
                                  .pOnly(top: 10),
                              Container(
                                height: height(context) * 0.08,
                                width: width(context),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20.0),
                                    color: primaryColor.withOpacity(0.5)),
                                child: DropdownButtonFormField(
                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: "Select an item...",
                                      hintStyle:
                                          TextStyle(color: Colors.grey[250])),
                                  items: List.generate(
                                      widget
                                          .post[0].questions[1].options.length,
                                      (optionIndex) => DropdownMenuItem(
                                          value: widget.post[0].questions[1]
                                              .options[optionIndex].option,
                                          child: widget.post[0].questions[1]
                                              .options[optionIndex].option.text
                                              .color(Colors.black)
                                              .make())),
                                  onChanged: (val) {
                                    dropDown2 = val.toString();
                                    setState(() {});
                                  },
                                ).centered().p(10),
                              )
                            ],
                          ).pOnly(top: 20.h, left: 5.w, right: 5.w),
                          GestureDetector(
                            onTap: () async {
                              if (dorpDown1.isNotEmpty ||
                                  dropDown2.isNotEmpty) {
                                isSigninUp = true;
                                setState(() {});
                                List<String> data = (await signUp())!;
                                setUserId(data[0], data[1]);
                                navigate(
                                    context: context,
                                    page: const HomePage(),
                                    isDistroyed: true);
                              }
                            },
                            child: Container(
                              height: height(context) * 0.075,
                              width: width(context) * 0.4,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: primaryColor.withOpacity(
                                      (dorpDown1.isEmpty || dropDown2.isEmpty)
                                          ? 0.5
                                          : 1)),
                              child: "Continue"
                                  .text
                                  .bold
                                  .white
                                  .size(20)
                                  .make()
                                  .centered(),
                            ),
                          ).pOnly(top: 70.h)
                        ],
                      ),
                    ))
          .p(20),
    );
  }
}
