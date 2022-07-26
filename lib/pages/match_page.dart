import 'package:cached_network_image/cached_network_image.dart';
import 'package:check_mate/helper/consts.dart';
import 'package:check_mate/helper/data_fetch.dart';
import 'package:check_mate/model/user_data.dart';
import 'package:check_mate/pages/Chat/chat_home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:velocity_x/velocity_x.dart';

class MatchPage extends StatefulWidget {
  const MatchPage({
    Key? key,
    required this.user,
  }) : super(key: key);
  final UserModel user;

  @override
  _MatchPageState createState() => _MatchPageState();
}

class _MatchPageState extends State<MatchPage> {
  int calculatedPercentage = 0;
  @override
  void initState() {
    calculatedPercentage = calculateMatchs(widget.user);
    setState(() {});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            end: const Alignment(0.0, 0.9),
            begin: const Alignment(0.0, -1),
            colors: <Color>[
              primaryColor.withOpacity(0.8),
              Colors.pink,
            ],
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Spacer(flex: 2),
            const Text(
              "It's a match! ",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w700,
                fontSize: 28,
              ),
            ),
            "You and ${widget.user.name} have liked each other."
                .text
                .color(Colors.grey[300])
                .justify
                .center
                .size(16.sp)
                .make()
                .centered(),
            const SizedBox(height: 44),
            Stack(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: 86,
                      width: 86,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(100),
                      ),
                      child: Center(
                        child: SizedBox(
                          height: 78,
                          width: 78,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(100),
                            child: CachedNetworkImage(
                              imageUrl: pictures![0],
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 32),
                    Container(
                      height: 86,
                      width: 86,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(100),
                      ),
                      child: Center(
                        child: SizedBox(
                          height: 78,
                          width: 78,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(100),
                            child: CachedNetworkImage(
                              imageUrl: widget.user.pictures[0],
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 86,
                  width: MediaQuery.of(context).size.width,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 64,
                        width: 64,
                        child: Stack(
                          children: [
                            Container(
                              height: 64,
                              width: 64,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100),
                                color: Colors.white,
                              ),
                            ),
                            Center(
                              child: SizedBox(
                                height: 56,
                                width: 56,
                                child: CircularProgressIndicator(
                                  strokeWidth: 4,
                                  color: Colors.green,
                                  value: calculatedPercentage / 100,
                                ),
                              ),
                            ),
                            Center(
                              child: Container(
                                height: 46,
                                width: 46,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(100),
                                ),
                              ),
                            ),
                            Center(
                                child: (calculatedPercentage)
                                    .toString()
                                    .split('.')[0]
                                    .text
                                    .bold
                                    .make()),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const Spacer(),
            GestureDetector(
              onTap: () {
                navigate(
                    context: context,
                    page: const ChannelListPage(),
                    isDistroyed: true);
              },
              child: Container(
                height: 56,
                width: MediaQuery.of(context).size.width,
                margin: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(100),
                ),
                child: Center(
                  child: Text(
                    "Message ${widget.user.gender == 'Female' ? 'her' : 'him'}",
                    style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
            ),
            Container(
              height: 56,
              width: MediaQuery.of(context).size.width,
              margin: const EdgeInsets.fromLTRB(16, 0, 16, 64),
              decoration: BoxDecoration(
                color: Colors.black26,
                borderRadius: BorderRadius.circular(100),
              ),
              child: InkWell(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: const Center(
                  child: Text(
                    "Keep swiping",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
