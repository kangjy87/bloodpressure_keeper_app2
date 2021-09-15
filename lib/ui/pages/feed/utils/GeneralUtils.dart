/**
 * 아래 주석 없으면 null-safety 지원 안되는 위 플러그인에서 에러남
 * flutter run --no-sound-null-safety 을통해 작성해야함
 * */

import 'package:flutter/material.dart';
import 'package:get/get.dart';
// @dart=2.8
// import 'package:flutter_statusbar_manager/flutter_statusbar_manager.dart';
import 'package:bloodpressure_keeper_app/ui/pages/feed/utils/logger_utils.dart';

// class GeneralUtils {
//
//   static void setStatusBar (StatusBarStyle statusBarStyle, bool animated) {
//     FlutterStatusbarManager.setStyle(statusBarStyle);
//   }
// }

/** prop for object height */
final double W_PROP = Get.width / 281.3;
double getUiSize (double size) {
  return size * W_PROP;
}