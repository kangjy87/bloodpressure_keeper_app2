import 'package:get/get.dart';
import 'package:get/get_instance/src/bindings_interface.dart';

import '../FeedsDetailController.dart';

class FeedsDetailBind extends Bindings {

  @override
  void dependencies() {
    Get.lazyPut<FeedsDetailController>(() => FeedsDetailController());
  }

}