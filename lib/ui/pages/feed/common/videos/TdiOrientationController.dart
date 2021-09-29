import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class TdiOrientationController extends GetxController {


  final orientation = Orientation.portrait.obs;


  @override
  void onInit () {
    super.onInit();

    ///나는 가로모드 지원해요~~
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft
    ]);
  }

  @override
  void onClose () {
    super.onClose();

    ///이제 가로모드 필요 없어요 ~
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
  }

}