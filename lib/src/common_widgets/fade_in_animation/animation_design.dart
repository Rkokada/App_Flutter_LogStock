import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logstock/src/common_widgets/fade_in_animation/fade_in_animation_controller.dart';
import 'package:logstock/src/common_widgets/fade_in_animation/fade_in_animation_model.dart';

class TFadeInAnimation extends StatelessWidget {
  TFadeInAnimation({
    Key? key,
    required this.durationInMs,
    required this.child,
    this.animate,
  }) : super(key: key);

  final controller = Get.put(FadeInAnimationController());
  final int durationInMs;
  final TAnimatePosition? animate;
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => AnimatedPositioned(
        duration: Duration(milliseconds: durationInMs),
        top: controller.animate.value ? animate!.topAfter : animate!.topBefore,
        left:controller.animate.value ? animate!.leftAfter : animate!.leftBefore,
        right:controller.animate.value ? animate!.rightAfter : animate!.rightBefore,
        bottom: controller.animate.value ? animate!.bottomAfter : animate!.bottomBefore,
        child: child,
        // child: Image(image: AssetImage(tSplashTopIcon)),
      ),
    );
  }
}
