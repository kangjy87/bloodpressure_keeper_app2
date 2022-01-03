import 'package:bloodpressure_keeper_app/ui/pages/feed/utils/FirebaseUtil.dart';
import 'package:bloodpressure_keeper_app/ui/pages/feed/utils/GeneralUtils.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

class DashboardController extends GetxController with WidgetsBindingObserver{
  var tabIndex = 0;
  RxInt crossCount = (isTabletSize() ? 6 : 4).obs;
  RxBool tabletCheck = isTabletSize().obs ;
  void changeTabIndex(int index) {
    tabIndex = index;
    update();
  }
  @override
  void onInit() {
    FirebaseUtil.initDynamicLinks(); //--> 파이어 베이스
    WidgetsBinding.instance!.addObserver(this);
    super.onInit();
  }
  @override
  void onClose() {
    WidgetsBinding.instance!.removeObserver(this);
    super.onClose();
  }
  @override
  void didChangeMetrics() {
    crossCount.value = isTabletSize() ? 6 : 4 ;
    tabletCheck.value = isTabletSize();
  }
}