import 'dart:async';
import 'package:flutter/material.dart';
import 'package:advertising_id/advertising_id.dart';
import 'package:device_info/device_info.dart';
import 'dart:io';

import 'package:package_info/package_info.dart';

class PhoneInfo{
  String? appVersion ; //앱버전
  String? device ; //기종
  String? osVersion ; //OS버전
  String? advertsingId ;  //광고아이디
  String? os ;  //OS구분

  PhoneInfo({
    this.appVersion,
    this.device,
    this.osVersion,
    this.advertsingId,
    this.os,
  });
}
Future<PhoneInfo> getPhoneInfo()async{
  PhoneInfo phoneInfo = PhoneInfo();

  //앱버전
  var packageInfo = await PackageInfo.fromPlatform();
  phoneInfo.appVersion = packageInfo.version ;

  //광고 아이디
  phoneInfo.advertsingId = await AdvertisingId.id(true);

  //폰정보(ios, android)
  DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
  if (Platform.isAndroid) {
    phoneInfo.os = "Android" ; //OS 구분
    AndroidDeviceInfo build =  await deviceInfoPlugin.androidInfo ;
    phoneInfo.osVersion = '${build.version.sdkInt}' ; //OS 버전
    phoneInfo.device = build.model ; //모델

  }else if (Platform.isIOS) {
    phoneInfo.os = "IOS" ; //OS 구분
    IosDeviceInfo data = await deviceInfoPlugin.iosInfo ;
    phoneInfo.osVersion = '${data.systemVersion}' ; //OS 버전
    phoneInfo.device = data.model ; //모델
  }

  return phoneInfo ;
}

