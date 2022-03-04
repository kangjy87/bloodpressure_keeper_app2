import 'dart:ffi';

import 'package:bloodpressure_keeper_app/ui/pages/dashboard/dashboard_controller.dart';
import 'package:bloodpressure_keeper_app/ui/pages/feed/config/AppStyle.dart';
import 'package:bloodpressure_keeper_app/ui/pages/feed/config/config.dart';
import 'package:bloodpressure_keeper_app/ui/pages/feed/favorite_controller.dart';
import 'package:bloodpressure_keeper_app/ui/pages/feed/feed_controller.dart';
import 'package:bloodpressure_keeper_app/ui/pages/feed/items/FeedItemView.dart';
import 'package:bloodpressure_keeper_app/ui/pages/feed/utils/GeneralUtils.dart';
import 'package:bloodpressure_keeper_app/ui/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:skeleton_loader/skeleton_loader.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:flutter_svg/flutter_svg.dart';

class FavoriteFeedListForm extends StatelessWidget {
  final _refreshKey = GlobalKey<RefreshIndicatorState>();

  @override
  Widget build(BuildContext context) {
    if(!Get.isRegistered<DashboardController>(tag:'mainTag')){
      Get.put(DashboardController(),tag:'mainTag');
    }
    return GetBuilder<FavoriteController> (
        init: FavoriteController (),
        builder: (controller) => RefreshIndicator(
            key: controller.refreshKey,
            child: Column (
              children: [
                Expanded(
                    child: SingleChildScrollView (
                      controller: controller.scrollController,
                      physics: AlwaysScrollableScrollPhysics (),
                      child: Container (
                        child: Column (
                          children: [
                            // _feedListView(),
                            SizedBox(height: getUiSize(5.8),),
                            // _tagCloud(),
                            Stack(
                              children: [
                                _feedGridView(controller),
                                Obx((){
                                  return Container(
                                    width: double.infinity,
                                    padding: EdgeInsets.fromLTRB(40, getUiSize(100), 40, 40),
                                    child: Text(controller.strDataZeroMsg.value,
                                        textAlign : TextAlign.center,
                                        style: TextStyle(
                                            fontFamily: 'NanumRoundB',
                                            fontSize: 20,
                                            color: Color(0xff454f63))),
                                  );
                                })
                              ],
                            )
                          ],
                        ),
                      ),
                    )
                )

              ],
            ),
            onRefresh: () => controller.refreshFeeds (true)
        )

      //_feedGridView(controller)

      /*SingleChildScrollView (
              controller: controller.scrollController,
              physics: AlwaysScrollableScrollPhysics (),
              child: Container (
                child: Column (
                  children: [

                    _feedListView(),
                    _tagCloud(),
                    _feedGridView(controller)

                  ],
                ),
              ),
            ),*/
    );
  }


  /** 스태거드 그리드 뷰 */
  Widget _feedGridView (FavoriteController controller) {

    //처음 서버타기전
    if (controller.data == null){ // || controller.list.length == 0) {
      return SkeletonGridLoader(
        builder: Card(
          color: Colors.transparent,
          child: GridTile(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                ClipRRect(
                  borderRadius: BorderRadius.circular(10.0),
                  child: Container(
                    width: getUiSize(90),
                    height: getUiSize(80),
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 5),
                Row(
                  children: [
                    SizedBox(width : 30),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: Image.asset(Images.img_no_profile,width: getUiSize (23), height: getUiSize (23),),
                    ),
                    SizedBox(width : 5),
                    Container(
                      width: 70,
                      height: 10,
                      color: Colors.white,
                    ),
                  ],
                ),
                SizedBox(height: 5),
                Container(
                  width: 100,
                  height: 5,
                  color: Colors.white,
                ),
                SizedBox(height: 2),
                Container(
                  width: 100,
                  height: 5,
                  color: Colors.white,
                ),
                SizedBox(height: 2),
              ],
            ),
          ),
        ),
        items: 4,
        itemsPerRow: 2,
        period: Duration(seconds: 2),
        highlightColor: Color(0xff454f63),
        direction: SkeletonDirection.ltr,
        childAspectRatio: 1,
      );
    }
    //정상적으로 서버 탔지만 데이터가 없을떄
    else if(controller.data!.statusCode == 200 && controller.list.length == 0){
      return Container (
        color: Colors.white,
        // height: double.infinity
        height: 600,
      );
    }else{
      return Obx((){
        return StaggeredGridView.countBuilder(
          shrinkWrap: true,
          // controller: controller.scrollController,
          physics: NeverScrollableScrollPhysics (),
          primary: false,
          key: PageStorageKey ("fuckedOne${Get.find<DashboardController>(tag:'mainTag').crossCount.value}"),
          padding: EdgeInsets.symmetric(horizontal: Constants.feed_tab_horizontal_padding),
          crossAxisCount: Get.find<DashboardController>(tag:'mainTag').crossCount.value, //isTabletSize() ?  6 : 4 ,
          itemCount: controller.list.length,
          itemBuilder: (BuildContext context, int index) => FeedItemView (
            dto: controller.list[index].article, index: index,
            onTap: () {
              // if (controller.searchFocusNode.hasFocus) {
              //   _unFocus (context);
              // } else {
              controller.detailPageGo(index);
              // }
            },
          ),
          staggeredTileBuilder: (int index) => new StaggeredTile.fit(2),
          mainAxisSpacing: getUiSize(2.2),
          crossAxisSpacing: getUiSize(2.2),
        );
      });
    }
  }
}
