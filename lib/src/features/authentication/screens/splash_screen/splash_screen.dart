import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logstock/src/common_widgets/fade_in_animation/fade_in_animation_controller.dart';
import 'package:logstock/src/constants/colors.dart';
import 'package:logstock/src/constants/image_strings.dart';
import 'package:logstock/src/constants/sizes.dart';
import 'package:logstock/src/constants/text_strings.dart';

import '../../../../common_widgets/fade_in_animation/animation_design.dart';
import '../../../../common_widgets/fade_in_animation/fade_in_animation_model.dart';

class SplashScreen extends StatelessWidget {
  SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(FadeInAnimationController());
    controller.startSplashAnimation();
    return Scaffold(
      body: Stack(children: [
        TFadeInAnimation(
          durationInMs: 1600,
          animate: TAnimatePosition(
            topAfter: 120,
            topBefore: 20,
            rightAfter: 15,
            rightBefore: 20,
          ),
          child: Image(
            image: AssetImage(tSplashTopIcon),
          ),
        ),
        TFadeInAnimation(
          durationInMs: 1600,
          animate: TAnimatePosition(
              topBefore: 100,
              topAfter: 180,
              leftAfter: tDefaultSize,
              leftBefore: 30),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Padding(padding: EdgeInsets.only(top: 80.0)),
            Text(tAppName,
                style: TextStyle(
                  fontSize: 45,
                  color: Colors.deepPurple,
                  fontWeight: FontWeight.bold,
                )),
            Text(tAppTagLine,
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                )),
          ]),
        ),
        TFadeInAnimation(
          durationInMs: 1600,
          animate: TAnimatePosition(
            bottomBefore: 0,
            bottomAfter: 30,
            leftAfter: 30,
            leftBefore: 0,
          ),
          child: Image(
            image: AssetImage(tSplashImage),
          ),
        ),
        TFadeInAnimation(
          durationInMs: 1600,
          animate: TAnimatePosition(
              bottomBefore: 0,
              bottomAfter: 60,
              rightBefore: tDefaultSize,
              rightAfter: tDefaultSize),
          child: Container(
            width: tSplashContainerSize,
            height: tSplashContainerSize,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(400),
              color: tSecondaryColor,
            ),
          ),
        ),
      ]),
    );
  }
}
