import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';

import 'feed_main_controller.dart';

class FeedMainPage extends GetView<FeedMainController>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child:Obx((){
          return PageView(
            physics: new NeverScrollableScrollPhysics(),
            scrollDirection: Axis.vertical,
            controller: controller.pageController,
            children: controller.pageList.value,
            onPageChanged: (position){
              // if(int == 3){
              //   list.add(Fragment3());
              // }
            },
          );
        }),
      ),
    );
  }
}
