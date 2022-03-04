import 'package:bloodpressure_keeper_app/ui/pages/dashboard/dashboard_controller.dart';
import 'package:bloodpressure_keeper_app/ui/pages/feed/utils/GeneralUtils.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'common/BaseScaffold.dart';
import 'common/common_ui.dart';
import 'config/AppStyle.dart';
import 'config/AppTranslations.dart';
import 'config/config.dart';
import 'feed_main_controller.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:skeleton_loader/skeleton_loader.dart';

import 'items/FeedItemView.dart';

class FeedListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    if(!Get.isRegistered<DashboardController>(tag:'mainTag')){
      Get.put(DashboardController(),tag:'mainTag');
    }
    Get.find<FeedMainController>().mainFeedinitList();
    return BaseScaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          elevation: 0,
          title: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 100,
                  ),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "소식",
                          style: TextStyle(
                              fontFamily: 'NanumRoundB',
                              fontSize: (isSmallSize() ? getUiSize(15) : getUiSize(12)),
                              color: Color(0xff454f63)),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 100,
                    child: GestureDetector(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            padding:
                            EdgeInsets.only(left: 0, top: 0, right: 0, bottom: 10),
                            child: Image.asset(
                              'images/sort_icon.png',
                              width: 20,
                              height: 20,
                            ),
                          )
                        ],
                      ),
                      onTap: () {
                        _filterShowModalBottomSheetStep();
                      },
                    ),
                  )
                ],
              )),
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
        ),
      body: GetBuilder<FeedMainController> (
        builder: (controller) => RefreshIndicator(
          key: controller.refreshKey,
          onRefresh: () => controller.refreshFeeds (true),
          child: Column(
            children: [
              Container (
                height: 50,
                padding: EdgeInsets.symmetric(horizontal: getUiSize (12)),
                child: Stack (
                  alignment: Alignment.centerLeft,
                  children: [
                    TextFormField(
                      autocorrect: false,
                      focusNode: controller.searchFocusNode,
                      cursorColor: Colors.black,
                      controller: controller.searchController,
                      decoration: AppStyle.decorationForSearch(hint: "검색어를 입력해 주세요"),
                      textInputAction: TextInputAction.search,
                      onChanged: (value) {
                        // controller.update();
                      },
                      onFieldSubmitted: (value) {
                        if (value.isEmpty) {
                          controller.searchFeeds(null);
                        } else {
                          controller.searchFeeds(value);
                        }

                      },
                    ),
                    SvgPicture.asset(AppIcons.ic_search, width: getUiSize(11.8),),
                    if (controller.searchController.text.isNotEmpty)
                      Positioned (
                        right: 0,
                        child: InkWell (
                          child: SvgPicture.asset(AppIcons.ic_x, width: getUiSize (8),),
                          onTap: () {
                            controller.keyword = null;
                            controller.searchController.text = "";
                            controller.refreshFeeds(false);
                          },
                        ),
                      )

                  ],
                ),
              ),
              SizedBox(height: getUiSize(5.8),),
              Expanded(
                  child: SingleChildScrollView (
                    controller: controller.mainFeedScrollController,
                    physics: AlwaysScrollableScrollPhysics (),
                    child: Container (
                      child: Column (
                        children: [
                          SizedBox(height: getUiSize(5.8),),
                          _feedGridView(controller)
                        ],
                      ),
                    ),
                  )
              ),
            ],
          ),
        ),
      ),
    );
  }
  _filterShowModalBottomSheetStep(){
    Get.bottomSheet(
        GetBuilder<FeedMainController>(
            builder: (controller) {
              controller.snsCheckSync();
              return Container (
                padding: EdgeInsets.symmetric(horizontal: getUiSize(11.2)),
                alignment: Alignment.bottomCenter,
                child: Column (
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container (
                      width: double.maxFinite,
                      constraints: BoxConstraints (
                          minHeight: getUiSize(20)
                      ),
                      child: SafeArea (
                        child: Column (
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            //회색 드래그 영역
                            Container(
                              width: getUiSize(27),
                              height: getUiSize (3),
                              margin: EdgeInsets.only(top: getUiSize(9)),
                              decoration: BoxDecoration (
                                  color: Color (0xffdbdbdb),
                                  borderRadius: BorderRadius.all(Radius.circular (100))
                              ),
                            ),
                            SizedBox (height: getUiSize(23.5)),
                            //게시중단 요청 제목
                            Text ('SNS 필터',style: TextStyle(fontSize: getUiSize(12)),),
                            SizedBox (height: getUiSize(6)),
                            Partition(weight: getUiSize(0.5)),
                            //인스타그램
                            InkWell(
                              child: Container (
                                width: double.maxFinite,
                                height: getUiSize(40.5),
                                child: Stack (
                                  alignment: Alignment.center,
                                  children: [
                                    Text ('인스타그램'),
                                    Obx (() {
                                      if (controller.snsInstarCheck)
                                        return Positioned (
                                            left: getUiSize(45),
                                            child: Image.asset(
                                              'images/sns_checked.png',
                                              width: getUiSize(22),
                                              height: getUiSize(22),
                                            )
                                        );
                                      else {
                                        return Container ();
                                      }
                                    })
                                  ],
                                ),
                              ),
                              onTap: () {
                                controller.snsInstarCheck = !controller.snsInstarCheck ;
                              },
                            ),
                            Partition(weight: getUiSize(0.5), color: Color (0xffd2d2d2)),
                            //유튜브
                            InkWell(
                              child: Container (
                                width: double.maxFinite,
                                height: getUiSize(40.5),
                                child: Stack (
                                  alignment: Alignment.center,
                                  children: [
                                    Text ('유튜브'),
                                    Obx (() {
                                      if (controller.snsYoutubeCheck)
                                        return Positioned (
                                            left: getUiSize(45),
                                            child: Image.asset(
                                              'images/sns_checked.png',
                                              width: getUiSize(22),
                                              height: getUiSize(22),
                                            )
                                        );
                                      else {
                                        return Container ();
                                      }
                                    })
                                  ],
                                ),
                              ),
                              onTap: () {
                                controller.snsYoutubeCheck = !controller.snsYoutubeCheck ;
                              },
                            ),
                            Partition(weight: getUiSize(0.5), color: Color (0xffd2d2d2)),
                            //네이버 블로그
                            InkWell(
                              child: Container (
                                width: double.maxFinite,
                                height: getUiSize(40.5),
                                child: Stack (
                                  alignment: Alignment.center,
                                  children: [
                                    Text ('네이버 블로그'),
                                    Obx (() {
                                      if (controller.snsNaverCheck)
                                        return Positioned (
                                            left: getUiSize(45),
                                            child: Image.asset(
                                              'images/sns_checked.png',
                                              width: getUiSize(22),
                                              height: getUiSize(22),
                                            )
                                        );
                                      else {
                                        return Container ();
                                      }
                                    })
                                  ],
                                ),
                              ),
                              onTap: () {
                                controller.snsNaverCheck = !controller.snsNaverCheck ;
                              },
                            ),

                            Partition(weight: getUiSize(0.5), color: Color (0xffd2d2d2)),

                            SizedBox (height: getUiSize (6.2),),

                            //확인 버튼
                            Padding (
                              // padding: EdgeInsets.symmetric(horizontal: getUiSize(20)),
                              padding: EdgeInsets.only(left: getUiSize(15), top: getUiSize(15), right: getUiSize(15),bottom: getUiSize(20)),
                              child: AppMaterialButton(
                                  label: Text (
                                    AppTranslation.btn_label_confirm.tr,
                                    style: TextStyle (fontFamily: Font.NotoSansCJKkrBold, color: Color (0xffeeeeee), fontSize: getUiSize(12)),
                                  ),
                                  color: Color (0xff434343),
                                  height: getUiSize(30.5),
                                  elevation: 0.0,
                                  onPressed:(){
                                    controller.snsCheckedSetting();
                                  }
                              ),
                            ),

                          ],
                        ),
                      ),
                      decoration: BoxDecoration (
                        color: Colors.white,
                        borderRadius: BorderRadius.only(topLeft: Radius.circular(getUiSize(10)), topRight: Radius.circular(getUiSize(10))),
                      ),

                    ),

                  ],
                ),
              );
            }
        )
    );
  }
  /** 스태거드 그리드 뷰 */
  Widget _feedGridView (FeedMainController controller) {
    //처음 서버타기전
    if (controller.mainFeeddata == null){ // || controller.list.length == 0) {
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
    else if(controller.mainFeeddata!.statusCode == 200 && controller.mainFeedlist.length == 0){
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
          itemCount: controller.mainFeedlist.length,
          itemBuilder: (BuildContext context, int index) => FeedItemView (
            dto: controller.mainFeedlist[index], index: index,
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