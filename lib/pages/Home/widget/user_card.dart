import 'package:cached_network_image/cached_network_image.dart';
import 'package:check_mate/helper/consts.dart';
import 'package:check_mate/model/user_data.dart';
import 'package:check_mate/pages/Home/widget/button.dart';
import 'package:check_mate/widget/details_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_swipecards/flutter_swipecards.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:preload_page_view/preload_page_view.dart';
import "dart:core";

class UserCard extends StatelessWidget {
  UserCard({
    Key? key,
    required this.cardController,
    required this.user,
  }) : super(key: key);
  final CardController? cardController;
  final UserModel user;
  PreloadPageController controller = PreloadPageController();
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          Container(
            foregroundDecoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              gradient: const LinearGradient(
                colors: [
                  Colors.black,
                  Colors.transparent,
                  Colors.transparent,
                  Colors.black
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                stops: [0, 0, 0.4, 0.9],
              ),
            ),
            child: SizedBox(
              height: height(context) * 0.77,
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Listener(
                    onPointerDown: (event) {
                      if (event.position.direction < 1.2 &&
                          event.position.dy < 550) {
                        debugPrint(
                            "Right:${event.position.direction.toString()}");
                        controller.nextPage(
                            curve: Curves.easeInOut,
                            duration: const Duration(microseconds: 1));
                      } else if (event.position.direction > 1.2 &&
                          event.position.dy < 550) {
                        debugPrint(
                            "Left: ${event.position.direction.toString()}");
                        controller.previousPage(
                            curve: Curves.easeInOut,
                            duration: const Duration(microseconds: 1));
                      }
                    },
                    child: PreloadPageView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        controller: controller,
                        preloadPagesCount: user.pictures.length,
                        itemCount: user.pictures.length,
                        itemBuilder: (context, index) {
                          return CachedNetworkImage(
                            imageUrl: user.pictures[index].toString(),
                            height: height(context) * 0.77,
                            width: width(context),
                            fit: BoxFit.cover,
                            placeholder: (context, url) {
                              return skeleton();
                            },
                            errorWidget: (context, url, error) {
                              return const Icon(Icons.error);
                            },
                          );
                        }),
                  )),
            ),
          ),
          Align(
            alignment: Alignment.topRight,
            child: Container(
              width: 75.w,
              height: 25.h,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.grey.withOpacity(0.6)),
              child: "${(user.dist.calculated).toStringAsFixed(2)} KM"
                  .text
                  .size(1.sp)
                  .white
                  .bold
                  .make()
                  .pOnly(left: 5.w)
                  .centered(),
            ),
          ).pOnly(right: 20.w, top: 20.h),
          GestureDetector(
            onTap: () {
              navigate(
                  context: context,
                  page: DetailsPage(
                    user: user,
                  ));
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 20.h,
                  width: 85.w,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.grey.withOpacity(0.6)),
                  child: "Neadby You"
                      .text
                      .size(5.sp)
                      .fontWeight(FontWeight.w500)
                      .white
                      .make()
                      .centered(),
                ).pOnly(left: 20.w, bottom: 10.h),
                Row(
                  children: [
                    user.name.text
                        .fontFamily("Roboto")
                        .white
                        .wide
                        .headline6(context)
                        .fontWeight(FontWeight.w700)
                        .make(),
                    " $age"
                        .text
                        .fontFamily("Roboto")
                        .white
                        .wide
                        .headline6(context)
                        .fontWeight(FontWeight.w700)
                        .make(),
                    const Icon(
                      Icons.verified,
                      color: Colors.blue,
                    ).pOnly(left: 10.w)
                  ],
                ).pOnly(left: 20.w, bottom: 10.h),
                SizedBox(
                        width: width(context) * 0.8,
                        child:
                            "${user.hobbies[0][0]} ${user.hobbies[0][1]} ${user.hobbies[0][2]} ${user.hobbies[0][3]}"
                                .text
                                .white
                                .justify
                                .start
                                .fade
                                .make()
                                .opacity(value: 0.8))
                    .pOnly(left: 20.w, bottom: 20.h)
                    .opacity(value: 0.9),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    button(Colors.red, cardController, Icons.close, false)
                        .pOnly(right: 15.w),
                    button(
                        Colors.purple, cardController!, Icons.favorite, true),
                  ],
                )
              ],
            ).pOnly(top: height(context) * 0.51),
          )
        ],
      ),
    );
  }
}
