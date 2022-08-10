import 'package:cached_network_image/cached_network_image.dart';
import 'package:check_mate/data/profile_page_data.dart';
import 'package:check_mate/helper/consts.dart';
import 'package:check_mate/pages/landingPage/landing_page.dart';
import 'package:check_mate/pages/register/questions_hobbies/hobbies/hobbie_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../helper/keep_page_alive.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  int _imageIndex = 0;
  @override
  Widget build(BuildContext context) {
    return KeepAliveWrapper(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            CustomScrollView(
              slivers: [
                SliverAppBar(
                  backgroundColor: Colors.white,
                  expandedHeight: MediaQuery.of(context).size.height * 0.60,
                  floating: true,
                  pinned: true,
                  snap: true,
                  collapsedHeight: 116,
                  actionsIconTheme: const IconThemeData(opacity: 0.0),
                  toolbarHeight: 56,
                  titleSpacing: 0,
                  centerTitle: false,
                  leading: Align(
                    alignment: Alignment.centerRight,
                    child: Container(
                      height: 40,
                      width: 40,
                      margin: const EdgeInsets.only(left: 16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(100),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            spreadRadius: 0,
                            blurRadius: 4,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: IconButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        icon: const Icon(
                          Icons.edit,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                  flexibleSpace: FlexibleSpaceBar(
                    titlePadding: const EdgeInsets.all(0),
                    title: Container(
                      height: 57.h,
                      padding: const EdgeInsets.all(16),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(28),
                          topRight: Radius.circular(28),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  const SizedBox(width: 2),
                                  Text(
                                    '$name, ${ageCalculate(age!)}',
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 12,
                                    width: 12,
                                    child: Stack(
                                      children: [
                                        Container(
                                          decoration: BoxDecoration(
                                            color: Colors.blue[300],
                                            borderRadius:
                                                BorderRadius.circular(100),
                                          ),
                                        ),
                                        const Center(
                                          child: Icon(
                                            Icons.check,
                                            size: 10,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  const Icon(
                                    Icons.email,
                                    color: Colors.pink,
                                    size: 14,
                                  ),
                                  Text(
                                    userEmail.toString(),
                                    style: TextStyle(
                                      fontSize: 10,
                                      color: Colors.grey[400],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 34,
                            width: 34,
                            child: Stack(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    color: Colors.green[300],
                                    borderRadius: BorderRadius.circular(100),
                                  ),
                                ),
                                Container(
                                  height: 18,
                                  width: 18,
                                  color: Colors.white,
                                ),
                                Center(
                                  child: Container(
                                    height: 28,
                                    width: 28,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(100),
                                    ),
                                  ),
                                ),
                                const Center(
                                  child: Text(
                                    '60%',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 8,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    background: SizedBox(
                      height: MediaQuery.of(context).size.height * 0.50,
                      child: Stack(
                        children: <Widget>[
                          Positioned.fill(
                            child: Container(
                              padding: const EdgeInsets.only(bottom: 86),
                              child: CachedNetworkImage(
                                imageUrl: pictures![_imageIndex],
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.bottomCenter,
                            child: Container(
                              height: 150,
                              margin: const EdgeInsets.only(bottom: 60),
                              width: double.infinity,
                              decoration: const BoxDecoration(
                                gradient: LinearGradient(
                                  end: Alignment(0.0, 0.4),
                                  begin: Alignment(0.0, -1),
                                  colors: <Color>[
                                    Colors.transparent,
                                    Colors.black,
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.bottomCenter,
                            child: Container(
                                height: 120,
                                padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
                                margin: const EdgeInsets.only(bottom: 100),
                                width: double.infinity,
                                child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: pictures!.length,
                                    itemBuilder: (context, index) {
                                      return GestureDetector(
                                        onTap: () {
                                          _imageIndex = index;
                                          setState(() {});
                                        },
                                        child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: AspectRatio(
                                              aspectRatio: 1.4,
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(16),
                                                child: CachedNetworkImage(
                                                  imageUrl: pictures![index],
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            )),
                                      );
                                    })),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Column(children: [
                    const Divider(
                      height: 1,
                      thickness: 1,
                      indent: 32,
                      endIndent: 32,
                    ),
                    const SizedBox(height: 16),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          Text(
                            'Hobbies',
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Wrap(
                      spacing: 3,
                      runSpacing: 2,
                      children: List.generate(hobbies!.length,
                          (index) => hobbieCard(hoobie: hobbies![index])),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: const [
                                  Text(
                                    'Gender',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: height(context) * 0.25,
                              child: Container(
                                height: height(context) * 0.2,
                                width: width(context) * 0.4,
                                decoration: BoxDecoration(
                                    color: primaryColor,
                                    borderRadius: BorderRadius.circular(20),
                                    border: Border.all(color: primaryColor)),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Image.asset(
                                        image[(gender == "Male" ? 0 : 1)]
                                                ["image"]
                                            .toString()),
                                    image[(gender == "Male" ? 0 : 1)]["gender"]
                                        .toString()
                                        .text
                                        .color(Colors.white)
                                        .make()
                                        .centered(),
                                  ],
                                ).centered(),
                              ).p(10),
                            ).pOnly(top: 10.h),
                          ],
                        ),
                        Container(
                          color: Colors.black,
                          height: height(context) * 0.21,
                          width: 2,
                        ).pOnly(top: 10.h),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: const [
                                  Text(
                                    'Interested Gender',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: height(context) * 0.25,
                              child: Container(
                                height: height(context) * 0.2,
                                width: width(context) * 0.4,
                                decoration: BoxDecoration(
                                    color: primaryColor,
                                    borderRadius: BorderRadius.circular(20),
                                    border: Border.all(color: primaryColor)),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Image.asset(image[
                                            (interestedGender == "Male"
                                                ? 0
                                                : 1)]["image"]
                                        .toString()),
                                    image[(interestedGender == "Male" ? 0 : 1)]
                                            ["gender"]
                                        .toString()
                                        .text
                                        .color(Colors.white)
                                        .make()
                                        .centered(),
                                  ],
                                ).centered(),
                              ).p(10),
                            ).pOnly(top: 10.h),
                          ],
                        ),
                      ],
                    ).centered(),
                    const SizedBox(height: 16),
                    Padding(
                        padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                        child: Row())
                  ]),
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        (about == null)
                            ? Container()
                            : SizedBox(
                                width: 295,
                                height: 118,
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      "About",
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 16,
                                        fontFamily: "Sk-Modernist",
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                    const SizedBox(height: 5),
                                    SizedBox(
                                      width: 295,
                                      child: Text(
                                        about!,
                                        style: const TextStyle(
                                          color: Color(0xb2000000),
                                          fontSize: 14,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                        GestureDetector(
                          onTap: () {
                            setLogOut();
                            navigate(
                                context: context,
                                page: const LadingPage(),
                                isDistroyed: true);
                          },
                          child: "👋 Sign Out"
                              .text
                              .bold
                              .size(20)
                              .make()
                              .centered()
                              .pOnly(top: 10.h),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
