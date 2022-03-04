/**
 * 아래 주석 없으면 null-safety 지원 안되는 위 플러그인에서 에러남
 * flutter run --no-sound-null-safety 을통해 작성해야함
 * */

import 'dart:ui';

import 'package:bloodpressure_keeper_app/model/get_favorite_groups_dto.dart';
import 'package:bloodpressure_keeper_app/ui/pages/dashboard/dashboard_controller.dart';
import 'package:bloodpressure_keeper_app/ui/pages/feed/FeedFavoriteController.dart';
import 'package:bloodpressure_keeper_app/ui/pages/feed/utils/ContentsUtil.dart';
import 'package:bloodpressure_keeper_app/ui/pages/feed/utils/FormatUtil.dart';
import 'package:bloodpressure_keeper_app/ui/routes/app_routes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:bloodpressure_keeper_app/ui/pages/feed/config/AppStyle.dart';
import 'package:bloodpressure_keeper_app/ui/pages/feed/config/AppTranslations.dart';
import 'package:bloodpressure_keeper_app/ui/pages/feed/config/config.dart';
import 'package:bloodpressure_keeper_app/ui/pages/feed/common/BaseScaffold.dart';
import 'package:bloodpressure_keeper_app/ui/pages/feed/utils/GeneralUtils.dart';
import 'package:skeleton_loader/skeleton_loader.dart';
import 'TestAFeedController.dart';
import 'common/common_ui.dart';
import 'dtos/FeedsItemDto.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:fab_circular_menu/fab_circular_menu.dart';

import 'dtos/MediaInfo.dart';

import 'package:bloodpressure_keeper_app/ui/pages/feed/dtos/MediaInfo.dart';

import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:bloodpressure_keeper_app/ui/pages/feed/dtos/FeedsItemDto.dart';


class TestBFeedPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;
    if(!Get.isRegistered<TestAFeedController>()){
      Get.put(TestAFeedController());
    }
    if(!Get.isRegistered<DashboardController>(tag:'mainTag')){
      Get.put(DashboardController(),tag:'mainTag');
    }
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
                  width: 40,
                ),
                SizedBox(
                  width: 40,
                ),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "시안B",
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
      body: GetBuilder<TestAFeedController> (
          init: TestAFeedController (),
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
                  ),
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
      floatingActionButton : GetBuilder<TestAFeedController>(
          builder: (controller) {
            controller.snsCheckSync();
            return Builder(
              builder: (context) => FabCircularMenu(
                // Cannot be `Alignment.center`
                alignment: Alignment.bottomRight,
                ringColor: Color(0xFF192A56),
                ringDiameter: 500.0,
                ringWidth: 150.0,
                fabSize: 64.0,
                fabElevation: 8.0,
                fabIconBorder: CircleBorder(),
                // the menu is open or not:
                // fabOpenColor: Colors.blue,
                // fabCloseColor: Colors.white
                fabColor: Colors.white,
                fabOpenIcon: Icon(Icons.menu, color: primaryColor),
                fabCloseIcon: SvgPicture.asset(AppIcons.ic_search, width: getUiSize(11.8),color: primaryColor),
                fabMargin: const EdgeInsets.all(16.0),
                animationDuration: const Duration(milliseconds: 800),
                animationCurve: Curves.easeInOutCirc,
                onDisplayChange: (isOpen) {
                  print('>>>>>>>>>>>>>>>>>>>>>>>${isOpen}');
                },
                children: <Widget>[
                  SizedBox(
                    width: 30,
                    height: 30,
                  ),
                ],
              ),
            );
          }),
      onBackgroundTab: () {
        _unFocus (context);
      },
    );
  }

  /** 스태거드 그리드 뷰 */
  Widget _feedGridView (TestAFeedController controller) {
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
          padding: EdgeInsets.symmetric(horizontal: getUiSize(3)),
          // padding: EdgeInsets.symmetric(horizontal: Constants.feed_tab_horizontal_padding),
          crossAxisCount: Get.find<DashboardController>(tag:'mainTag').crossCount.value, //isTabletSize() ?  6 : 4 ,
          itemCount: controller.list.length,
          itemBuilder: (BuildContext context, int index){
            if(controller.list[index].media_id == 121212121212){
              return ClipRRect(
                borderRadius: BorderRadius.circular(10.0),
                child: Container(
                  width: 400,
                  height: 200,
                  color: Colors.white,
                  child: Column(
                    children: getKeyword(controller,index),
                  ),
                ),
              );
            }
            return FeedItemViewB (
              dto: controller.list[index], index: index,
              onTap: () {

              },
            );
          },
          staggeredTileBuilder: (int index) => controller.list[index].media_id == 121212121212 ?  new StaggeredTile.fit(8) :  new StaggeredTile.fit(2),
          mainAxisSpacing: getUiSize(2.2),
          crossAxisSpacing: getUiSize(2.2),
        );
      });
    }
  }


  List<Widget> getKeyword(TestAFeedController controller,int index){
    List<Widget> btnList = [] ;
    if(controller.list[index].article_medias! != null){
      for(int i = 0 ; i < controller.list[index].article_medias!.length; i++){
        if(i / 2 == 0 ||i / 2 == 1.0){
          String btn1 = controller.list[index].article_medias![i].storage_url! ;
          String btn2 = controller.list[index].article_medias![i+1].storage_url! ;
          btnList.add(SizedBox(
            height: 20,
          ));
          btnList.add(Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: ElevatedButton(
                    child: Text(btn1,
                        style: TextStyle(fontSize: getUiSize(9))),
                    style: ButtonStyle(
                        foregroundColor:
                        MaterialStateProperty.all<Color>(
                            Colors.white),
                        backgroundColor:
                        MaterialStateProperty.all<Color>(
                            Color(0xff454f63)),
                        shape: MaterialStateProperty.all<
                            RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                                borderRadius:
                                BorderRadius.circular(70.0),
                                side: BorderSide(
                                    color: Color(0xff454f63))))),
                    onPressed: () {
                      for(int i = 0 ; i < controller.list.length; i++){
                        if(controller.list[i].media_id == 121212121212){
                          controller.list.removeAt(i);
                        }
                      }
                      // controller.searchController.text
                      controller.searchFeeds(btn1);
                    }),
              ),
              SizedBox(width: 20,),
              Expanded(
                child: ElevatedButton(
                    child: Text(btn2,
                        style: TextStyle(fontSize: getUiSize(9))),
                    style: ButtonStyle(
                        foregroundColor:
                        MaterialStateProperty.all<Color>(
                            Colors.white),
                        backgroundColor:
                        MaterialStateProperty.all<Color>(
                            Color(0xff454f63)),
                        shape: MaterialStateProperty.all<
                            RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                                borderRadius:
                                BorderRadius.circular(70.0),
                                side: BorderSide(
                                    color: Color(0xff454f63))))),
                    onPressed: () {
                      for(int i = 0 ; i < controller.list.length; i++){
                        if(controller.list[i].media_id == 121212121212){
                          controller.list.removeAt(i);
                        }
                      }
                      // controller.searchController.text
                      controller.searchFeeds(btn2);
                    }),
              )
            ],
          ));
        }
      }
    }
    return btnList ;
  }


  //언포커스
  void _unFocus (BuildContext context) {
    FocusScope.of(context).requestFocus(FocusNode ());
  }

  _favoriteInfoShowModalBottomSheetStep(BuildContext buidContext,){
    if(!Get.isRegistered<FeedFavoriteController>()){
      Get.put(FeedFavoriteController());
    }
    Get.bottomSheet(
        GetBuilder<FeedFavoriteController>(
          init: FeedFavoriteController(),
          builder: (controller){
            controller.getfavoriteGroups();
            return SafeArea(child: Container(
              color: Colors.white,
              height:getUiSize(290),
              child: Column(
                children: [
                  SizedBox(height: 20,),
                  Container(
                      width: getUiSize(150),
                      height: getUiSize(40),
                      child: ElevatedButton(
                          child: Text('+새 건강 모음 추가',
                              style: TextStyle(fontSize: getUiSize(12))),
                          style: ButtonStyle(
                              foregroundColor:
                              MaterialStateProperty.all<Color>(
                                  Colors.white),
                              backgroundColor:
                              MaterialStateProperty.all<Color>(
                                  Color(0xff454f63)),
                              shape: MaterialStateProperty.all<
                                  RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius:
                                      BorderRadius.circular(70.0),
                                      side: BorderSide(
                                          color: Color(0xff454f63))))),
                          onPressed: () {
                            groupNameDialog(buidContext,controller);
                          })),
                  SizedBox(
                    width: double.infinity,
                    height: 300,
                    child: Obx(()=>ListView.separated(
                      itemCount: controller.favoriteGroups!.length,
                      itemBuilder: (context, index) {
                        print('>>>>>>>>>>>>${index}');
                        return listItem(controller.favoriteGroups![index],context);
                      },
                      separatorBuilder: (BuildContext context, int index) {
                        return Divider();
                      },
                    )),)
                ],
              ),
            ),);
          },
        )
    );
  }

  Widget listItem(FavoriteGroups data,BuildContext context) {
    return ListTile(
      title: Text(data.group_name!),
      onTap: (){
        Navigator.pop(context);
        Get.toNamed(AppRoutes.FeedFavoriteDetailListPage,arguments: {"group_id":'${data.id}',"title":data.group_name})!;
      },
      // onTap: () => 'ddddd',
    );
  }

  _filterShowModalBottomSheetStep(){
    Get.bottomSheet(
        GetBuilder<TestAFeedController>(
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

                            // Padding (
                            //   padding: EdgeInsets.symmetric(horizontal: getUiSize(20)),
                            //   child: Text (AppTranslation.description_request_stop_posting.tr,),
                            // ),
                            //
                            // SizedBox(height: getUiSize(18.5),),

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

                            //네이버 블로그
                            InkWell(
                              child: Container (
                                width: double.maxFinite,
                                height: getUiSize(40.5),
                                child: Stack (
                                  alignment: Alignment.center,
                                  children: [
                                    Text ('구글뉴스'),
                                    Obx (() {
                                      if (controller.snsGoogleNewCheck)
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
                                controller.snsGoogleNewCheck = !controller.snsGoogleNewCheck ;
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

  groupNameDialog(BuildContext buidContext,FeedFavoriteController controller){
    return showDialog(
        context: buidContext,
        builder: (BuildContext context) {
          return AlertDialog(
              contentPadding: EdgeInsets.only(top: 10.0),
              content : Container(
                width: getUiSize(200),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text('건강 모음 추가'),
                    TextField(
                      controller: controller.favoriteAddController,
                      decoration:
                      const InputDecoration(labelText: '최대 8글자까지'),
                    ),
                    Row(
                      children: [
                        ElevatedButton(
                            child: Text('추가',
                                style: TextStyle(fontSize: getUiSize(12))),
                            style: ButtonStyle(
                                foregroundColor:
                                MaterialStateProperty.all<Color>(
                                    Colors.white),
                                backgroundColor:
                                MaterialStateProperty.all<Color>(
                                    Color(0xff454f63)),
                                shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                        borderRadius:
                                        BorderRadius.circular(70.0),
                                        side: BorderSide(
                                            color: Color(0xff454f63))))),
                            onPressed: () {
                              controller.addFavoriteGroups(controller.favoriteAddController.text,(int statusCode){
                                Navigator.pop(context);
                                if(statusCode == 409){
                                  Fluttertoast.showToast(
                                      msg: "이미 등록된 즐겨찾기 그룹명 입니다.",
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.BOTTOM,
                                      timeInSecForIosWeb: 1,
                                      backgroundColor: Color(0xff454f63),
                                      textColor: Colors.white,
                                      fontSize: 16.0
                                  );
                                }else if(statusCode == 200){
                                  controller.favoriteAddController.text = "" ;
                                  Fluttertoast.showToast(
                                      msg: "추가 되었습니다.",
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.BOTTOM,
                                      timeInSecForIosWeb: 1,
                                      backgroundColor: Color(0xff454f63),
                                      textColor: Colors.white,
                                      fontSize: 16.0
                                  );
                                  controller.getfavoriteGroups();
                                }
                              });
                            }),
                        ElevatedButton(
                            child: Text('취소',
                                style: TextStyle(fontSize: getUiSize(12))),
                            style: ButtonStyle(
                                foregroundColor:
                                MaterialStateProperty.all<Color>(
                                    Colors.white),
                                backgroundColor:
                                MaterialStateProperty.all<Color>(
                                    Color(0xff454f63)),
                                shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                        borderRadius:
                                        BorderRadius.circular(70.0),
                                        side: BorderSide(
                                            color: Color(0xff454f63))))),
                            onPressed: () {
                              Navigator.pop(context);
                            })
                      ],
                    )
                  ],
                ),
              )
          );
        }
    );
  }
}

class FeedItemViewB extends StatelessWidget {

  /** 아래 스타일들 나중에 따로빼자 ------------------- */
  TextStyle tStyle1 = TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.bold,
      color: Color (0xff717171)
  );

  TextStyle tStyle2 = TextStyle(
      fontSize: 12,
      color: Color (0xff8b8b8b)
  );
  /** ------------------------------------------ */


  FeedsItemDto? dto;
  int? index;
  VoidCallback? onTap;

  FeedItemViewB ({
    this.dto,
    this.index,
    this.onTap
  });

  @override
  Widget build(BuildContext context) {

    MediaInfo _mediaInfo = ContentsUtil.getFeedsThumbNailInfo(dto!);

    List<Color> _colors = [Colors.transparent, Colors.black45];
    List<double> _stops = [0.6, 0.9];

    String? _userThumbnailURL = dto!.article_owner!.thumbnail_url;
    if (_userThumbnailURL == null || _userThumbnailURL.isEmpty) _userThumbnailURL = "";

    String strContents = '${(dto!.hashtag == null || dto!.hashtag == '')? dto!.contents! : dto!.hashtag!}';
    String strSnsImg = 'images/sns_youtube_icon.png' ;
    String? strPlatform = dto!.article_owner!.platform ;
    if(strPlatform != null){
      switch(strPlatform){
        case 'youtube' :
          strSnsImg = 'images/sns_youtube_icon.png' ;
          break ;
        case 'instagram' :
          strSnsImg = 'images/sns_instar_icon.png' ;
          break ;
        case 'google-news' :
          strSnsImg = 'images/sns_google_icon.png' ;
          break ;
        case 'naver-blog' :
          strSnsImg = 'images/sns_blog_icon.png' ;
          break ;
      }
    }
    return Container (
        child : InkWell (
            onTap: onTap,
            child: Column(
              children: [
                Stack (
                  children: [
                    ClipRRect(
                        borderRadius: BorderRadius.circular(10.0),
                        child: Container (
                          child: Stack (
                            children: [
                              /** 썸네일 */
                              Container(
                                // height: _mediaInfo.height,
                                height:  0 ,
                                constraints: BoxConstraints (
                                    minHeight: _mediaInfo.url!.startsWith ("http") ? _mediaInfo.height! : 0,
                                    minWidth: double.maxFinite
                                ),
                                child: _mediaInfo.url!.startsWith ("http")
                                    ? CachedNetworkImage(
                                  imageUrl: _mediaInfo.url!,
                                  cacheKey: dto!.url,
                                  cacheManager: DefaultCacheManager(),
                                  maxWidthDiskCache: 300,
                                  maxHeightDiskCache: 300,
                                  memCacheWidth: 300,
                                  memCacheHeight: 300,
                                  fit: BoxFit.cover,
                                  errorWidget: (context, url, error) => Container(
                                    height: _mediaInfo.height,
                                    color: Colors.transparent,
                                    child: Image.asset(
                                      Images.img_no_thumbnail,
                                      height: _mediaInfo.height,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                )
                                    : Container(
                                  child: Image.asset(
                                    Images.img_no_thumbnail,
                                    height: _mediaInfo.height,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),

                              /** 그라데이션 커버 */
                              if (_mediaInfo.url!.isNotEmpty)
                                Container (
                                  height: _mediaInfo.height,
                                  decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        begin: Alignment.topCenter,
                                        end: Alignment.bottomCenter,
                                        colors: _colors,
                                        stops: _stops,
                                      )
                                  ),
                                ),
                              /** 북마크**/
                              Positioned(
                                right: getUiSize (6.3),
                                top: getUiSize (6.3),
                                child: Image.asset(dto!.is_favorite == false ? AppIcons.book_makr_off : AppIcons.book_makr_on, height: getUiSize(15.5),width: getUiSize(15.5),),
                              ),
                              /** 플랫폼 아이콘**/
                              Positioned(
                                left: getUiSize (6.3),
                                bottom: getUiSize (6.3),
                                child: Image.asset(strSnsImg, height: getUiSize(15.5),width: getUiSize(15.5),),
                              ),
                            ],
                          ),
                        )
                    ),
                  ],
                ),
                SizedBox(height: getUiSize (2),),
                if(strContents.length > 0)
                  Container(
                    // padding: EdgeInsets.all(getUiSize(8)),
                    padding: EdgeInsets.only(left: getUiSize(8), right: getUiSize(8), top: getUiSize(2),bottom: getUiSize(2)),
                    child: Text('${strContents}',maxLines: 2,overflow: TextOverflow.ellipsis,style: TextStyle(fontSize: getUiSize(10)),),
                  ),
                SizedBox(height: getUiSize (2),),
                /** 별점 */
                Row (
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(width: getUiSize (5),),
                    Image.asset(AppIcons.ic_heart2, height: getUiSize(10.2),width: getUiSize(11.5),),
                    SizedBox (width: getUiSize(2.5),),
                    Text (
                        FormatUtil.numberWithComma(dto!.article_detail  == null ? 0 : dto!.article_detail!.like!),
                        style: TextStyle (
                            color: Colors.black,
                            //fontFamily: Font.NotoSansCJKkrRegular,
                            fontSize: getUiSize(9)
                        )
                    ),
                    SizedBox(
                      width: 5,
                    )

                  ],
                ),
                SizedBox(height: getUiSize (6),),
              ],
            )
        ),

        decoration: BoxDecoration(
          color: Color(0xfff4f5f7),
          borderRadius: BorderRadius.all(Radius.circular(getUiSize(10))),
        )
    );

  }

}