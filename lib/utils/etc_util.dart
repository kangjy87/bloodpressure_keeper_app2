import 'package:flutter/material.dart';
import 'package:get/get.dart';

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