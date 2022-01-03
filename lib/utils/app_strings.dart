import 'package:bloodpressure_keeper_app/ui/pages/bp_management/bp_management_page.dart';
import 'package:bloodpressure_keeper_app/ui/pages/feed/feed_page.dart';
import 'package:bloodpressure_keeper_app/ui/pages/my/my_page.dart';

class AppStrings {
  static const  String strBpInput = '혈압등록';
  static const  String strSuccessTitle = '완료';
  static const  String strSuccessMsg = '성공적으로 등록되었습니다.';
  static const  String strButtonClose = '완료';
  static List tablist=[
    BpManagementPage(),
    FeedPage(),
    MyPage(),
  ];
}