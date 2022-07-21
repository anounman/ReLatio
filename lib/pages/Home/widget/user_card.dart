import 'package:cached_network_image/cached_network_image.dart';
import 'package:check_mate/helper/consts.dart';
import 'package:check_mate/pages/Home/widget/button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_swipecards/flutter_swipecards.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:preload_page_view/preload_page_view.dart';

class UserCard extends StatelessWidget {
  UserCard(
      {Key? key,
      required this.image,
      required this.cardController,
      // required this.age,
      required this.hoobies,
      required this.name})
      : super(key: key);
  final List<String> image;
  final CardController? cardController;
  final String name;
  // final String age;
  final List<String> hoobies;
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
                        controller: controller,
                        preloadPagesCount: image.length,
                        itemCount: image.length,
                        itemBuilder: (context, index) {
                          return CachedNetworkImage(
                            imageUrl: image[index].toString(),
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
              width: 50.w,
              height: 20.h,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.grey.withOpacity(0.6)),
              child: "1km"
                  .text
                  .size(1.sp)
                  .white
                  .bold
                  .make()
                  .pOnly(left: 5.w)
                  .centered(),
            ),
          ).pOnly(right: 20.w, top: 20.h),
          Column(
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
                  name.text
                      .fontFamily("Roboto")
                      .white
                      .wide
                      .headline6(context)
                      .fontWeight(FontWeight.w700)
                      .make(),
                  // age.text
                  //     .fontFamily("Roboto")
                  //     .white
                  //     .wide
                  //     .headline6(context)
                  //     .fontWeight(FontWeight.w700)
                  //     .make(),
                  const Icon(
                    Icons.verified,
                    color: Colors.blue,
                  ).pOnly(left: 10.w)
                ],
              ).pOnly(left: 20.w, bottom: 10.h),
              SizedBox(
                      width: width(context) * 0.8,
                      child:
                          "${hoobies[0]} ${hoobies[1]} ${hoobies[2]} ${hoobies[3]}"
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
                  button(Colors.purple, cardController!, Icons.favorite, true),
                ],
              )
            ],
          ).pOnly(top: height(context) * 0.51)
        ],
      ),
    );
  }
}
