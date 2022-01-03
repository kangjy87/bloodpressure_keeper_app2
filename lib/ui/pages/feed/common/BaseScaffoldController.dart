import 'package:get/get.dart';

class BaseScaffoldController extends GetxController {

  final loadingFlag = false.obs;

  set isLoading (bool value) => loadingFlag.value = value;
  bool get isLoading => loadingFlag.value;



  @override
  void onInit () {
    super.onInit();
  }
}