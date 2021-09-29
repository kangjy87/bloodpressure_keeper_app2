/**
 * 아래 주석 없으면 null-safety 지원 안되는 위 플러그인에서 에러남
 * flutter run --no-sound-null-safety 을통해 작성해야함
 * */

import 'dart:ui';

import 'package:bloodpressure_keeper_app/ui/routes/app_routes.dart';
import 'package:bloodpressure_keeper_app/ui/utils/btns/bottom_fullsize_btn.dart';
import 'package:bloodpressure_keeper_app/utils/app_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:bloodpressure_keeper_app/ui/pages/feed/config/AppStyle.dart';
import 'package:bloodpressure_keeper_app/ui/pages/feed/config/AppTranslations.dart';
import 'package:bloodpressure_keeper_app/ui/pages/feed/config/config.dart';
import 'package:bloodpressure_keeper_app/ui/pages/feed/config/enums.dart';
import 'package:bloodpressure_keeper_app/ui/pages/feed/feed_controller.dart';
import 'package:bloodpressure_keeper_app/ui/pages/feed/common/BaseScaffold.dart';
import 'package:bloodpressure_keeper_app/ui/pages/feed/common/InputLabelForm.dart';
import 'package:bloodpressure_keeper_app/ui/pages/feed/common/TopperIconMenuAsset.dart';
import 'package:bloodpressure_keeper_app/ui/pages/feed/items/FeedItemView.dart';
import 'package:bloodpressure_keeper_app/ui/pages/feed/utils/GeneralUtils.dart';
import 'package:bloodpressure_keeper_app/ui/pages/feed/components/TitleView.dart';
import 'package:bloodpressure_keeper_app/ui/pages/feed/items/FeedItemViewForHome.dart';
// import 'package:flutter_statusbar_manager/flutter_statusbar_manager.dart';
// // @dart=2.8
// import 'package:flutter_tags/flutter_tags.dart';

class FeedPage extends StatelessWidget {



  final _refreshKey = GlobalKey<RefreshIndicatorState>();

  //리프레시
  Future<void> _onRefresh ()async {
    _refreshKey.currentState?.show(atTop: true);

  }



  @override
  Widget build(BuildContext context) {
    // Future.delayed(Duration.zero, ()=> Get.find<HomeController>().setTitle(AppTranslation.tab_title_3.tr));
    // GeneralUtils.setStatusBar(StatusBarStyle.DARK_CONTENT, true);
    return BaseScaffold (
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
                    "피드",
                    style: TextStyle(
                        fontFamily: 'NanumRoundB',
                        fontSize: 18,
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
                  showModalBottomSheet(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      context: context,
                      builder: (context) {
                        return GetBuilder<FeedController>(
                          init: FeedController(),
                          builder: (controller) =>
                              Column(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment
                                        .center,
                                    children: [
                                      Container(
                                        padding:
                                        EdgeInsets.only(left: 0,
                                            top: 10,
                                            right: 0,
                                            bottom: 10),
                                        child: Image.asset(
                                          'images/sns_popup_topbtn.png',
                                          width: 40,
                                          height: 10,
                                        ),
                                      )
                                    ],
                                  ),
                                  Container(
                                      padding: EdgeInsets.fromLTRB(
                                          0, 10, 0, 20),
                                      child: Text('SNS 필터',
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontFamily: 'NanumRoundEB',
                                              color: Color(0xff454f63)))),
                                  Container(color: Color(0xff454f63),
                                    width: double.infinity,
                                    height: 1,),
                                  GestureDetector(
                                    child: Container(
                                      width: double.infinity,
                                      height: 58,
                                      padding: EdgeInsets.fromLTRB(
                                          0, 10, 0, 10),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment
                                            .center,
                                        crossAxisAlignment: CrossAxisAlignment
                                            .center,
                                        children: [
                                          Container(
                                            padding: EdgeInsets.fromLTRB(
                                                0, 0, 20, 0),
                                            width: 40,
                                            height: 30,
                                            child: Visibility(
                                              visible: controller.snsInstar.isTrue,
                                              child: Image.asset(
                                                'images/sns_checked.png',
                                                width: 30,
                                                height: 30,
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 100,
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment
                                                  .center,
                                              crossAxisAlignment: CrossAxisAlignment
                                                  .center,
                                              children: [
                                                Text('인스타그램',
                                                    style: TextStyle(
                                                        fontSize: 14,
                                                        fontFamily: 'NanumRoundR',
                                                        color: Color(0xff5a5d64))),
                                              ],
                                            )
                                          ),
                                          SizedBox(
                                            width: 40,
                                            height: 30,
                                          )
                                        ],
                                      ),
                                    ),
                                    onTap: (){
                                      controller.setSnsInStar();
                                    },
                                  ),
                                  Container(color: Color(0xffa0a5b1),
                                    width: double.infinity,
                                    height: 1,),
                                  GestureDetector(
                                    child: Container(
                                      width: double.infinity,
                                      height: 58,
                                      padding: EdgeInsets.fromLTRB(
                                          0, 10, 0, 10),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment
                                            .center,
                                        crossAxisAlignment: CrossAxisAlignment
                                            .center,
                                        children: [
                                          Container(
                                            padding: EdgeInsets.fromLTRB(
                                                0, 0, 20, 0),
                                            width: 40,
                                            height: 30,
                                            child: Visibility(
                                              visible: controller.snsYoutube.isTrue,
                                              child: Image.asset(
                                                'images/sns_checked.png',
                                                width: 30,
                                                height: 30,
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 100,
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment
                                                  .center,
                                              crossAxisAlignment: CrossAxisAlignment
                                                  .center,
                                              children: [
                                                Text('유튜브',
                                                    style: TextStyle(
                                                        fontSize: 14,
                                                        fontFamily: 'NanumRoundR',
                                                        color: Color(0xff5a5d64)))
                                              ],
                                            ),
                                          ),
                                          SizedBox(
                                            width: 40,
                                            height: 30,
                                          )
                                        ],
                                      ),
                                    ),
                                    onTap: (){
                                      controller.setSnsYoutube();
                                    },
                                  ),
                                  Container(color: Color(0xffa0a5b1),
                                    width: double.infinity,
                                    height: 1,),
                                  GestureDetector(
                                    child: Container(
                                      width: double.infinity,
                                      height: 58,
                                      padding: EdgeInsets.fromLTRB(
                                          0, 10, 0, 10),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment
                                            .center,
                                        crossAxisAlignment: CrossAxisAlignment
                                            .center,
                                        children: [
                                          Container(
                                            padding: EdgeInsets.fromLTRB(
                                                0, 0, 20, 0),
                                            width: 40,
                                            height: 30,
                                            child: Visibility(
                                              visible: controller.snsNaver.isTrue,
                                              child: Image.asset(
                                                'images/sns_checked.png',
                                                width: 30,
                                                height: 30,
                                              ),
                                            ),
                                          ),
                                          SizedBox(width: 100,
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment
                                                  .center,
                                              crossAxisAlignment: CrossAxisAlignment
                                                  .center,
                                              children: [
                                              Text('네이버 블로그',
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    fontFamily: 'NanumRoundR',
                                                    color: Color(0xff5a5d64)))],),),
                                          SizedBox(
                                            width: 40,
                                            height: 30,
                                          )
                                        ],
                                      ),
                                    ),
                                    onTap: (){
                                      controller.setSnsNaver();
                                    },
                                  ),
                                  BottomFullSizeBtn(
                                      text: '선택완료',
                                      textColor: Colors.white,
                                      backgroundColor: Color(
                                          AppColors.colorBtnActivate),
                                      setonclicklistener: () {
                                        controller.snsCheckedSetting();
                                      })
                                ],
                              ),
                        );
                      });
                },
              ),
            )
          ],
        )),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),
      body: GetBuilder<FeedController> (
          init: FeedController (),
          builder: (controller) => RefreshIndicator(
              key: controller.refreshKey,
              child: Column (
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
      ),
      onBackgroundTab: () {
        _unFocus (context);
      },

    );
  }


  /** 피드 리스트 뷰 */
  Widget _feedListView () {
    return Column (
        children: [

          SizedBox(
            height: getUiSize(150),
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.symmetric(horizontal: Constants.feed_tab_horizontal_padding),
              shrinkWrap: true,
              itemCount: Images.SampleImages.length,
              itemBuilder: (context, index) => FeedItemViewForHome (dto: Images.SampleImages[index]),
              separatorBuilder: (context, index) => SizedBox(width: getUiSize(4.3)),
            ),
          )
        ]
    );
  }

  /** 스태거드 그리드 뷰 */
  Widget _feedGridView (FeedController controller) {

    if (controller.data == null || controller.list.length == 0) {
      return Container (
        color: Colors.white,
          // height: double.infinity
        height: 600,
      );
    }

    return StaggeredGridView.countBuilder(
      shrinkWrap: true,
      // controller: controller.scrollController,
      physics: NeverScrollableScrollPhysics (),
      primary: false,
      key: PageStorageKey ("fuckedOne"),
      padding: EdgeInsets.symmetric(horizontal: Constants.feed_tab_horizontal_padding),
      crossAxisCount: 4,
      itemCount: controller.list.length,
      itemBuilder: (BuildContext context, int index) => FeedItemView (
        dto: controller.list[index], index: index,
        onTap: () {
          // if (controller.searchFocusNode.hasFocus) {
          //   _unFocus (context);
          // } else {
          print('>>>>>>>>>${controller.list[index].title}');
            Get.toNamed(AppRoutes.FeedDetailPage, arguments: controller.list[index]); /** 상세페이지로!! */
          // }
        },
      ),
      staggeredTileBuilder: (int index) => new StaggeredTile.fit(2),
      mainAxisSpacing: getUiSize(2.2),
      crossAxisSpacing: getUiSize(2.2),
    );
  }





  //언포커스
  void _unFocus (BuildContext context) {
    FocusScope.of(context).requestFocus(FocusNode ());
  }

}