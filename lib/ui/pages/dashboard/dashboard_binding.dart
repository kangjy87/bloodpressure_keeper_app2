import 'package:bloodpressure_keeper_app/ui/pages/bp_management/bp_detail_info_controller.dart';
import 'package:get/get.dart';
import 'dashboard_controller.dart';
import 'package:bloodpressure_keeper_app/ui/pages/bp_management/bp_management_controller.dart';
import 'package:bloodpressure_keeper_app/ui/pages/feed/feed_controller.dart';
import 'package:bloodpressure_keeper_app/ui/pages/my/my_controller.dart';
import 'package:bloodpressure_keeper_app/ui/pages/login/sns_login/login_controller.dart';
import 'package:bloodpressure_keeper_app/ui/pages/bp_management/self_bp_input/self_bp_input_controller.dart';
import 'package:bloodpressure_keeper_app/ui/pages/splash_screen/splash_screen_controller.dart';
import 'package:bloodpressure_keeper_app/ui/pages/login/join_addinfo/join_addinfo_controller.dart';
import 'package:bloodpressure_keeper_app/ui/pages/login/join_addinfo/user_info_agreement_controller.dart';
class DashboardBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SplashScreenController>(() => SplashScreenController());
    Get.lazyPut<DashboardController>(() => DashboardController());
    Get.lazyPut<BpManagementController>(() => BpManagementController());
    Get.lazyPut<FeedController>(() => FeedController());
    Get.lazyPut<MyController>(() => MyController());
    Get.lazyPut<LoginController>(() => LoginController());
    Get.lazyPut<SelfBpInputController>(() => SelfBpInputController());
    Get.lazyPut<JoinAddInfoController>(() => JoinAddInfoController());
    Get.lazyPut<UserInfoAgreementController>(() => UserInfoAgreementController());
    Get.lazyPut<BpDetailInfoController>(() => BpDetailInfoController());
  }
}