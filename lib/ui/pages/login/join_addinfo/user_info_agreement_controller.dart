import 'dart:io';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
class UserInfoAgreementController extends GetxController {
  final String title = '개인정보 취급방침' ;
  @override
  void onInit() {
    super.onInit();
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
  }
}