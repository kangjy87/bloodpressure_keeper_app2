import 'package:bloodpressure_keeper_app/ui/pages/login/sns_login/login_page.dart';
import 'package:get/get.dart';
import 'package:bloodpressure_keeper_app/ui/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:package_info/package_info.dart';
import 'package:bloodpressure_keeper_app/utils/shared_preferences_info/login_info.dart';
import 'package:bloodpressure_keeper_app/model/users_dto.dart';

class MyController extends GetxController with SingleGetTickerProviderMixin{
  late TabController tabController ;
  final String title = '마이페이지';
  String version = '';
  String strTab1 = "images/book_mark_icon_on.png", strTab2 = "images/option_icon_off.png" ;
  userInfoAgreement() {
    Get.toNamed(AppRoutes.UserInfoAgreement);
  }

  @override
  void onInit() {
    super.onInit();
    tabController = TabController(length: 2, vsync: this);
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
  String viewMsg = '' ;
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
    StringBuffer msg = StringBuffer();
    if(age != ''){
      msg.write('${age}년생 ');
    }
    if(sex != '' && sex != '미선택'){
      msg.write('${sex} ');
    }
    msg.write('${nickName}님');
    viewMsg = msg.toString();
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
  tabSetting(int index){
    strTab1 = index == 0 ? "images/book_mark_icon_on.png" : "images/book_mark_icon_off.png" ;
    strTab2 = index == 1 ? "images/option_icon_on.png" : "images/option_icon_off.png" ;
    update();
  }
}