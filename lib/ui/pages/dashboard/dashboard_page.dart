import 'dart:io';

import 'package:bloodpressure_keeper_app/ui/pages/feed/feed_controller.dart';
import 'package:bloodpressure_keeper_app/ui/pages/feed/feed_main_controller.dart';
import 'package:bloodpressure_keeper_app/ui/pages/feed/feed_main_page.dart';
import 'package:bloodpressure_keeper_app/ui/pages/feed/utils/GeneralUtils.dart';
import 'package:bloodpressure_keeper_app/ui/utils/msg_alert_dialog/twobutton_alert.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:bloodpressure_keeper_app/ui/pages/bp_management/bp_management_page.dart';
import 'package:bloodpressure_keeper_app/ui/pages/feed/feed_page.dart';
import 'package:bloodpressure_keeper_app/ui/pages/my/my_page.dart';
import 'dashboard_controller.dart';
import 'package:fluttertoast/fluttertoast.dart';

class DashboardPage extends StatelessWidget with WidgetsBindingObserver{
  List _list=[
    FeedPage(),
    BpManagementPage(),
    MyPage(),
  ];
  late DateTime backbuttonpressedTime;
  Future<bool> onWillPop() async {
    DateTime currentTime = DateTime.now();

    //Statement 1 Or statement2
    bool backButton = backbuttonpressedTime == null ||
        currentTime.difference(backbuttonpressedTime) > Duration(seconds: 3);

    if (backButton) {
      backbuttonpressedTime = currentTime;
      Fluttertoast.showToast(
          msg: "Double Click to exit app",
          backgroundColor: Colors.black,
          textColor: Colors.white);
      return false;
    }
    return true;
  }
  @override
  Widget build(BuildContext context) {
    print('asdfsdfsdfsadfsadfsadfsadfsadfsadfsadfsadfsdafsadf');
    return WillPopScope(child: GetBuilder<DashboardController>(
      tag: 'mainTag',
      init: DashboardController(),
      builder: (controller) {
        return Scaffold(
          body: this._list[controller.tabIndex],
          //SingleChildScrollView(child: this._list[controller.tabIndex],),
          bottomNavigationBar: BottomAppBar(
            child: Container(
              width: double.infinity,
              //margin: EdgeInsets.only(left: 6.0, right: 6.0),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: Text(''),
                  ),
                  GestureDetector(
                    //update the bottom app bar view each time an item is clicked
                    onTap: () {
                      if(controller.tabIndex == 0){
                        Get.find<FeedController>().searchFeeds(null);
                      }
                      controller.changeTabIndex(0);
                    },
                    child: controller.tabIndex == 0
                        ? Image.asset('images/menu_on_2.png',
                            height: getUiSize (40), width: getUiSize (80))
                        : Image.asset('images/menu_off_2.png',
                            height: getUiSize (40), width: getUiSize (80)),
                  ),
                  Expanded(
                    flex: 1,
                    child: Text(''),
                  ),
                  GestureDetector(
                    onTap: () {
                      controller.changeTabIndex(1);
                    },
                    child: controller.tabIndex == 1
                        ? Image.asset('images/menu_on_1.png',
                            height: getUiSize (40), width: getUiSize (80))
                        : Image.asset('images/menu_off_1.png',
                            height: getUiSize (40), width: getUiSize (80)),
                  ),
                  Expanded(
                    flex: 1,
                    child: Text(''),
                  ),
                  GestureDetector(
                    onTap: () {
                      controller.changeTabIndex(2);
                    },
                    child: controller.tabIndex == 2
                        ? Image.asset('images/menu_on_3.png',
                            height: getUiSize (40), width: getUiSize (80))
                        : Image.asset('images/menu_off_3.png',
                            height: getUiSize (40), width: getUiSize (80)),
                  ),
                  Expanded(
                    flex: 1,
                    child: Text(''),
                  ),
                ],
              ),
            ),
            //to add a space between the FAB and BottomAppBar
            // shape: CircularNotchedRectangle(),
            //color of the BottomAppBar
            color: Colors.white,
          ),
        );

        //   Scaffold(
        //   body: SafeArea(
        //     child: IndexedStack(
        //       index: controller.tabIndex,
        //       children: [
        //         BpManagementPage(),
        //         FeedPage(),
        //         MyPage(),
        //       ],
        //     ),
        //   ),
        //   bottomNavigationBar: BottomNavigationBar(
        //     unselectedItemColor: Colors.black,
        //     selectedItemColor: Colors.blue,
        //     onTap: controller.changeTabIndex,
        //     currentIndex: controller.tabIndex,
        //     showSelectedLabels: false,
        //     showUnselectedLabels: false,
        //     type: BottomNavigationBarType.fixed,
        //     backgroundColor: Colors.white,
        //     elevation: 0,
        //     items: [
        //       _bottomNavigationBarItem(
        //         icon: (controller.tabIndex == 0
        //             ? Image.asset('images/footer_management_enabled.png', height: 70, width: 70)
        //             : Image.asset('images/footer_management_disabled.png', height: 70, width: 70)),
        //         label: '혈압'
        //       ),
        //       _bottomNavigationBarItem(
        //         icon: (controller.tabIndex == 1
        //             ? Image.asset('images/footer_news_enabeld.png', height: 70, width: 70)
        //             : Image.asset('images/footer_news_disabled.png', height: 70, width: 70)),
        //         label: '피드'              ),
        //       _bottomNavigationBarItem(
        //         icon: (controller.tabIndex == 2
        //             ? Image.asset('images/footer_setting_enabled.png', height: 70, width: 70)
        //             : Image.asset('images/footer_setting_disabled.png', height: 70, width: 70)),
        //         label: '마이'
        //       ),
        //     ],
        //   ),
        // );
      },
    ),
    // onWillPop: onWillPop,
        onWillPop: () async {
          if(Get.find<FeedMainController>().pageList.value.length > 1){
            Get.find<FeedMainController>().onback();
          }else{
            twoButtonAlert(
                context,
                '종료',
                '앱을 종료 하시겠습니까?',
                '아니요', () {
              Get.back();
            },
                '예', () {
              exit(0);
            });
          }
      return false;
    }
    );
  }

  _bottomNavigationBarItem({Image? icon,String? label}) {
    return BottomNavigationBarItem(
      icon: Tab(icon : icon),
      label: label,
    );
  }
  // _bottomNavigationBarItem({IconData? icon, String? label}) {
  //   return BottomNavigationBarItem(
  //     icon: Icon(icon),
  //     label: label,
  //   );
  // }
}