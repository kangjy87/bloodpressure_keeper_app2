import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'feed_controller.dart';
import 'FeedItemView.dart';
import 'package:bloodpressure_keeper_app/model/feeds/FeedsItemDto.dart';
import 'config.dart';
// import 'package:prj_musical_flt/config/AppTranslations.dart';
// import 'package:prj_musical_flt/controllers/HomeController.dart';
// import 'package:prj_musical_flt/utils/SharedPrefUtil.dart';
// import 'package:prj_musical_flt/utils/logger_utils.dart';

class FeedPage extends StatelessWidget {


  //스태거드 그리드 뷰
  Widget _feedListView (FeedController controller) {

    if (controller.data == null) {
      return Container (color: Colors.white,);
    }

    return StaggeredGridView.countBuilder(
      controller: controller.scrollController,
      primary: false,
      key: PageStorageKey ("fuckedOne"),
      padding: EdgeInsets.all(10.0),
      crossAxisCount: 4,
      itemCount: controller.list.length,
      itemBuilder: (BuildContext context, int index) => FeedItemView (dto: controller.list[index], index: index,),
      staggeredTileBuilder: (int index) => new StaggeredTile.fit(2),
      mainAxisSpacing: 10.0,
      crossAxisSpacing: 10.0,
    );

  }


  @override
  Widget build(BuildContext context) {

    // Future.delayed(Duration.zero, ()=> Get.find<HomeController>().setTitle(AppTranslation.tab_title_3.tr));

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        title: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "피드",
                  textAlign : TextAlign.center,
                  style: TextStyle(
                      fontFamily: 'NanumRoundB',
                      fontSize: 18,
                      color: Color(0xff454f63)),
                ),
              ],
            )
        ),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),
      body: Container (
        color: Color (0xffe0e0e0),
        child: GetBuilder<FeedController>(
            init: FeedController (),
            // You can initialize your controller here the first time. Don't use init in your other GetBuilders of same controller
            builder: (controller) => _feedListView (controller)),
      ),
    );
  }

}