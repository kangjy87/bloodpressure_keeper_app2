import 'package:bloodpressure_keeper_app/ui/pages/bp_management/bp_detail_info_page.dart';
import 'package:bloodpressure_keeper_app/ui/pages/feed/PageFeedsDetail.dart';
import 'package:bloodpressure_keeper_app/ui/pages/feed_detail/FeedsDetailBind.dart';
import 'package:get/get.dart';
import 'package:bloodpressure_keeper_app/ui/pages/dashboard/dashboard_binding.dart';
import 'package:bloodpressure_keeper_app/ui/pages/splash_screen/splash_screen_page.dart';
import 'package:bloodpressure_keeper_app/ui/pages/dashboard/dashboard_page.dart';
import 'package:bloodpressure_keeper_app/ui/pages/login/sns_login/login_page.dart';
import 'package:bloodpressure_keeper_app/ui/pages/bp_management/bp_management_page.dart';
import 'package:bloodpressure_keeper_app/ui/pages/bp_management/self_bp_input/self_bp_input_page.dart';
import 'package:bloodpressure_keeper_app/ui/pages/login/join_addinfo/join_addinfo_page.dart';
import 'package:bloodpressure_keeper_app/ui/pages/login/join_addinfo/user_info_agreement_page.dart';
import 'app_routes.dart';

class AppPages {
  static var list = [
    GetPage(
      name: AppRoutes.Splash,
      page: () => SplashScreenPage(),
      binding: DashboardBinding(),
    ),
    GetPage(
      name: AppRoutes.DASHBOARD,
      page: () => DashboardPage(),
      binding: DashboardBinding(),
    ),
    GetPage(
      name: AppRoutes.BPManagemnet,
      page: ()=> BpManagementPage(),
      binding: DashboardBinding(),
    ),
    GetPage(
      name: AppRoutes.SELFINFUT,
      page: ()=> SelfBpInputPage(),
      binding: DashboardBinding(),
    ),
    GetPage(
      name: AppRoutes.LOGIN,
      page: () => LoginPage(),
      binding: DashboardBinding(),
      transition: Transition.native,
    ),
    GetPage(
      name: AppRoutes.JoinAddInfo,
      page: () => JoinAddInfoPage(),
      binding: DashboardBinding(),
      transition: Transition.native,
    ),
    GetPage(
      name: AppRoutes.UserInfoAgreement,
      page: () => UserInfoAgreementPage(),
      binding: DashboardBinding(),
      transition: Transition.native,
    ),
    GetPage(
      name: AppRoutes.BpDetailInfo,
      page: () => BpDetailInfoPage(),
      binding: DashboardBinding(),
      transition: Transition.native,
    ),
    /** KEVIN 추가 */
    GetPage(
      name: AppRoutes.FeedDetailPage,
      page: () => PageFeedsDetail(),
      binding: FeedsDetailBind(),
      transition: Transition.native,
    ),
  ];
}