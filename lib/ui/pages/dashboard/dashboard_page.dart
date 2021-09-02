import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:bloodpressure_keeper_app/ui/pages/bp_management/bp_management_page.dart';
import 'package:bloodpressure_keeper_app/ui/pages/feed/feed_page.dart';
import 'package:bloodpressure_keeper_app/ui/pages/my/my_page.dart';
import 'dashboard_controller.dart';

class DashboardPage extends StatelessWidget {
  List _list=[
    BpManagementPage(),
    FeedPage(),
    MyPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DashboardController>(
      builder: (controller) {
        return Scaffold(
          body: this._list[controller.tabIndex],//SingleChildScrollView(child: this._list[controller.tabIndex],),
          bottomNavigationBar: BottomAppBar(
            child: Container(
              //margin: EdgeInsets.only(left: 6.0, right: 6.0),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Expanded(flex : 1,child: Text(''),),
                  GestureDetector(
                    //update the bottom app bar view each time an item is clicked
                    onTap: () {
                      controller.changeTabIndex(0);
                    },
                    child: controller.tabIndex == 0
                        ? Image.asset('images/menu_on_1.png', height: 70, width: 120)
                        : Image.asset('images/menu_off_1.png', height: 70, width: 120),
                  ),
                  Expanded(flex : 1,child: Text(''),),
                  GestureDetector(
                    onTap: () {
                      controller.changeTabIndex(1);
                    },
                    child: controller.tabIndex == 1
                        ? Image.asset('images/menu_on_2.png', height: 70, width: 120)
                        : Image.asset('images/menu_off_2.png', height: 70, width: 120),
                  ),
                  Expanded(flex : 1,child: Text(''),),
                  GestureDetector(
                    onTap: () {
                      controller.changeTabIndex(2);
                    },
                    child: controller.tabIndex == 2
                        ? Image.asset('images/menu_on_3.png', height: 70, width: 120)
                        : Image.asset('images/menu_off_3.png', height: 70, width: 120),
                  ),
                  Expanded(flex : 1,child: Text(''),),
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