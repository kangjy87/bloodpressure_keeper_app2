/**
 * 아래 주석 없으면 null-safety 지원 안되는 위 플러그인에서 에러남
 * flutter run --no-sound-null-safety 을통해 작성해야함
 * */

import 'package:bloodpressure_keeper_app/ui/routes/app_routes.dart';
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