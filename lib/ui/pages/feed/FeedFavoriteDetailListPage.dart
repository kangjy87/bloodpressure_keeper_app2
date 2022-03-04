import 'package:bloodpressure_keeper_app/model/get_favorite_groups_dto.dart';
import 'package:bloodpressure_keeper_app/ui/pages/dashboard/dashboard_controller.dart';
import 'package:bloodpressure_keeper_app/ui/pages/feed/utils/GeneralUtils.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'FeedFavoriteDetailListController.dart';
import 'config/config.dart';
import 'package:bloodpressure_keeper_app/ui/pages/feed/config/config.dart';
import 'package:bloodpressure_keeper_app/ui/pages/feed/items/FeedItemView.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:skeleton_loader/skeleton_loader.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';


class FeedFavoriteDetailListPage extends GetView<FeedFavoriteDetailListController>{
  @override
  Widget build(BuildContext context) {
    return GetBuilder<FeedFavoriteDetailListController>(
        init: FeedFavoriteDetailListController(),
        builder:(controller) => Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            elevation: 0,
            title: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 50,
                    ),
                    SizedBox(
                      width: 30,
                    ),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            controller.title.value,
                            style: TextStyle(
                                fontFamily: 'NanumRoundB',
                                fontSize: (isSmallSize() ? getUiSize(15) : getUiSize(12)),
                                color: Color(0xff454f63)),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 30,
                    ),
                    SizedBox(
                      width: 50,
                    )
                  ],
                )),
            backgroundColor: Colors.white,
            foregroundColor: Colors.black,
          ),
          body: SafeArea(child: Container(
            child: RefreshIndicator(
                key: controller.refreshKey,
                child: Column (
                  children: [
                    SizedBox(height: getUiSize(5.8),),
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
                                _feedGridView(controller)

                              ],
                            ),
                          ),
                        )
                    ),
                  ],
                ),
                onRefresh: () => controller.refreshFeeds (true)
            ),
          ),),
        ));
  }

  /** 스태거드 그리드 뷰 */
  Widget _feedGridView (FeedFavoriteDetailListController controller) {
    print('>>>>>>>>췍췍췍췍크크크크크!!!!!!!!!!!!!!!${Get.isRegistered<DashboardController>(tag:'mainTag')}');
    if(!Get.isRegistered<DashboardController>(tag:'mainTag')){
      Get.put(DashboardController(),tag:'mainTag');
    }
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
        items: 9,
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
              controller.detailPageGo(index);
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