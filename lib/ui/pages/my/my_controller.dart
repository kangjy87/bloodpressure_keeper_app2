import 'package:bloodpressure_keeper_app/ui/pages/login/sns_login/login_page.dart';
import 'package:get/get.dart';
import 'package:bloodpressure_keeper_app/ui/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:package_info/package_info.dart';
import 'package:bloodpressure_keeper_app/utils/shared_preferences_info/login_info.dart';
import 'package:bloodpressure_keeper_app/model/users_dto.dart';

class MyController extends GetxController {
  final String title = '마이페이지';
  String version = '';

  userInfoAgreement() {
    Get.toNamed(AppRoutes.UserInfoAgreement);
  }

  @override
  void onInit() {
    super.onInit();
    getVersionInfo();
    getInfo();
  }

  getVersionInfo() async {
    var packageInfo = await PackageInfo.fromPlatform();
    version = packageInfo.version;
    update();
  }

  String email = '';

  String nickName = '';

  String age = '';

  String sex = '';

  Future<UsersDto> getInfo() async {
    UsersDto gcDto = await getUserInfo();
    email = gcDto.email!;
    nickName = gcDto.nickname!;
    age = gcDto.age!;
    switch (gcDto.gender) {
      case 'M' :
        sex = '남성';
        break;
      case 'W' :
        sex = '여성';
        break;
      case 'N' :
        sex = '미선택';
        break;
    }
    update();
    return gcDto;
  }

  newLogin(Function refresh) {
    setUserClaer(() {
      Get.offAllNamed(AppRoutes.LOGIN)!.then((value) {
        refresh();
      });
    });
  }
}