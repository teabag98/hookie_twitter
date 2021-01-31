import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:hookie_twitter/src/utils/custom_animation.dart';

void configLoading() {
  EasyLoading.instance
    ..displayDuration = const Duration(milliseconds: 2000)
    ..indicatorType = EasyLoadingIndicatorType.fadingCircle
    ..loadingStyle = EasyLoadingStyle.custom
    ..indicatorSize = 45.0
    ..radius = 10.0
    ..progressColor = Colors.yellow
    ..backgroundColor = Colors.transparent
    ..indicatorColor = Colors.greenAccent
    ..textColor = Colors.white
    ..maskColor = Colors.black
    ..userInteractions = false
    ..dismissOnTap = false
    ..customAnimation = CustomAnimation()
    ..textStyle = TextStyle(
      fontFamily: 'Averta',
      color: Colors.white,
    )
    ..maskType = EasyLoadingMaskType.black;
}
