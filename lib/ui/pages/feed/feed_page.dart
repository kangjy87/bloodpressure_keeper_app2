/**
 * 아래 주석 없으면 null-safety 지원 안되는 위 플러그인에서 에러남
 * flutter run --no-sound-null-safety 을통해 작성해야함
 * */

import 'dart:ui';

import 'package:bloodpressure_keeper_app/model/feed_favorite_groups_add_dto.dart';
import 'package:bloodpressure_keeper_app/model/get_favorite_groups_dto.dart';
import 'package:bloodpressure_keeper_app/ui/pages/dashboard/dashboard_controller.dart';
import 'package:bloodpressure_keeper_app/ui/pages/feed/FeedFavoriteController.dart';
import 'package:bloodpressure_keeper_app/ui/pages/feed/test_a_feed_page.dart';
import 'package:bloodpressure_keeper_app/ui/pages/feed/test_b_feed_page.dart';
import 'package:bloodpressure_keeper_app/ui/routes/app_routes.dart';
import 'package:bloodpressure_keeper_app/ui/utils/btns/bottom_fullsize_btn.dart';
import 'package:bloodpressure_keeper_app/ui/utils/native_container.dart';
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
import 'package:skeleton_loader/skeleton_loader.dart';
import 'common/common_ui.dart';
import 'dtos/FeedsItemDto.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:fab_circular_menu/fab_circular_menu.dart';


class FeedPage extends StatelessWidget {

  final GlobalKey<FabCircularMenuState> fabKey = GlobalKey();

  final _refreshKey = GlobalKey<RefreshIndicatorState>();

  //리프레시
  Future<void> _onRefresh ()async {
    _refreshKey.currentState?.show(atTop: true);

  }

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;
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
              child: GestureDetector(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      padding:
                      EdgeInsets.only(left: 0, top: 0, right: 0, bottom: 10),
                      child: Text('A시안',style: TextStyle(fontSize: getUiSize(9),color: Colors.blue)),
                    )
                  ],
                ),
                onTap: () {
                  Navigator.push(
                      context, MaterialPageRoute(builder: (_) => TestAFeedPage()));
                },
              ),
            ),
            SizedBox(
              width: 20),
            SizedBox(
              width: 40,
              child: GestureDetector(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      padding:
                      EdgeInsets.only(left: 0, top: 0, right: 0, bottom: 10),
                      child: Text('B시안',style: TextStyle(fontSize: getUiSize(9),color: Colors.blue)),
                    )
                  ],
                ),
                onTap: () {
                  Navigator.push(
                      context, MaterialPageRoute(builder: (_) => TestBFeedPage()));
                  // Get.toNamed(AppRoutes.FeedFavoritePage);
                },
              ),
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
              width: 80,
              child: GestureDetector(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      padding:
                      EdgeInsets.only(left: 0, top: 0, right: 0, bottom: 10),
                      child: Image.asset(
                        'images/main_favorite.png',
                        width: 20,
                        height: 20,
                      ),
                    )
                  ],
                ),
                onTap: () {
                  _favoriteInfoShowModalBottomSheetStep(context);
                  // Get.toNamed(AppRoutes.FeedFavoritePage);
                },
              ),
            ),
            SizedBox(
              width: 15,
              // child: GestureDetector(
              //   child: Row(
              //     mainAxisAlignment: MainAxisAlignment.end,
              //     crossAxisAlignment: CrossAxisAlignment.center,
              //     children: [
              //       Container(
              //         padding:
              //         EdgeInsets.only(left: 0, top: 0, right: 0, bottom: 10),
              //         child: Image.asset(
              //           'images/sort_icon.png',
              //           width: 20,
              //           height: 20,
              //         ),
              //       )
              //     ],
              //   ),
              //   onTap: () {
              //     _filterShowModalBottomSheetStep();
              //   },
              // ),
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
                  SizedBox(height: getUiSize(9),),
                  Expanded(
                      child: SingleChildScrollView (
                        controller: controller.scrollController,
                        physics: AlwaysScrollableScrollPhysics (),
                        child: Container (
                          child: Column (
                            children: [
                              Container(
                                  child: Row(
                                    children: [
                                      SizedBox(width: getUiSize(15),),
                                      GestureDetector(
                                        onTap: (){
                                          controller.searchFeeds(controller.checkTest1.value ? '두통' : null);
                                          controller.checkTest2.value = true ;
                                          controller.checkTest3.value = true ;
                                          controller.checkTest1.value = !controller.checkTest1.value ;
                                        },
                                        child: Column(
                                          children: [
                                            Obx((){
                                              return ClipRRect(
                                                borderRadius: BorderRadius.circular(10.0),
                                                child: Image.asset('images/feed_test1.png', height: getUiSize(30),width: getUiSize(30),
                                                  color: controller.checkTest1.value ? null : Colors.red,),
                                              );
                                            }),
                                            SizedBox(height: getUiSize(4),),
                                            Text('두통',style: TextStyle(fontSize: getUiSize(8),fontWeight: FontWeight.bold))
                                          ],
                                        ),
                                      ),
                                      SizedBox(width: getUiSize(15),),
                                      GestureDetector(
                                        onTap: (){
                                          controller.searchFeeds(controller.checkTest2.value ? '고혈압' : null);
                                          controller.checkTest1.value = true ;
                                          controller.checkTest3.value = true ;
                                          controller.checkTest2.value = !controller.checkTest2.value ;
                                        },
                                        child: Column(
                                          children: [
                                            Obx((){
                                              return ClipRRect(
                                                borderRadius: BorderRadius.circular(10.0),
                                                child: Image.asset('images/feed_test2.png', height: getUiSize(30),width: getUiSize(30),
                                                  color: controller.checkTest2.value ? null : Colors.red,),
                                              );
                                            }),
                                            SizedBox(height: getUiSize(4),),
                                            Text('고혈압',style: TextStyle(fontSize: getUiSize(8),fontWeight: FontWeight.bold))
                                          ],
                                        ),
                                      ),
                                      SizedBox(width: getUiSize(15),),
                                      GestureDetector(
                                        onTap: (){
                                          controller.searchFeeds(controller.checkTest3.value ? '코로나' : null);
                                          controller.checkTest1.value = true ;
                                          controller.checkTest2.value = true ;
                                          controller.checkTest3.value = !controller.checkTest3.value ;
                                        },
                                        child: Column(
                                          children: [
                                            Obx((){
                                              return ClipRRect(
                                                borderRadius: BorderRadius.circular(10.0),
                                                child: Image.asset('images/feed_test3.png', height: getUiSize(30),width: getUiSize(30),
                                                  color: controller.checkTest3.value ? null : Colors.red,),
                                              );
                                            }),
                                            SizedBox(height: getUiSize(4),),
                                            Text('코로나',style: TextStyle(fontSize: getUiSize(8),fontWeight: FontWeight.bold))
                                          ],
                                        ),
                                      ),
                                    ],
                                  )
                              ),
                              SizedBox(height: getUiSize(5.8),),
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
      floatingActionButton : GetBuilder<FeedController>(
          builder: (controller) {
            controller.snsCheckSync();
            return Builder(
              builder: (context) => FabCircularMenu(
                key: fabKey,
                // Cannot be `Alignment.center`
                alignment: Alignment.bottomRight,
                ringColor: Colors.transparent,
                // ringColor: Color(0xFF192A56),
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
                fabCloseIcon: Icon(Icons.close, color: primaryColor),
                // fabCloseIcon: SvgPicture.asset(AppIcons.ic_search, width: getUiSize(11.8),color: primaryColor),
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
                  RawMaterialButton(
                    onPressed: () {
                      controller.snsCheckedSetting2(4);
                      fabKey.currentState?.close();
                    },
                    shape: CircleBorder(),
                    padding: const EdgeInsets.all(24.0),
                    child: Text('A',style: TextStyle(fontSize: getUiSize(23),fontWeight: FontWeight.bold))
                  ),
                  SizedBox(
                    width: 30,
                    height: 30,
                  ),
                  RawMaterialButton(
                    onPressed: () {
                      controller.snsCheckedSetting2(0);
                      fabKey.currentState?.close();
                    },
                    shape: CircleBorder(),
                    padding: const EdgeInsets.all(24.0),
                    child: Image.asset('images/sns_instar_icon.png', height: getUiSize(30),width: getUiSize(30),color: Color(0xFF192A56),),
                  ),
                  SizedBox(
                    width: 30,
                    height: 30,
                  ),
                  RawMaterialButton(
                    onPressed: () {
                      controller.snsCheckedSetting2(1);
                      fabKey.currentState?.close();
                    },
                    shape: CircleBorder(),
                    padding: const EdgeInsets.all(24.0),
                    child: Image.asset('images/sns_youtube_icon.png', height: getUiSize(30),width: getUiSize(30),color: Color(0xFF192A56),),
                  ),
                  SizedBox(
                    width: 30,
                    height: 30,
                  ),
                  RawMaterialButton(
                    onPressed: () {
                      controller.snsCheckedSetting2(2);
                      fabKey.currentState?.close();
                    },
                    shape: CircleBorder(),
                    padding: const EdgeInsets.all(24.0),
                    child: Image.asset('images/sns_blog_icon.png', height: getUiSize(30),width: getUiSize(30),color: Color(0xFF192A56),),
                  ),
                  SizedBox(
                    width: 30,
                    height: 30,
                  ),
                  RawMaterialButton(
                    onPressed: () {
                      controller.snsCheckedSetting2(3);
                      fabKey.currentState?.close();
                    },
                    shape: CircleBorder(),
                    padding: const EdgeInsets.all(24.0),
                    child: Image.asset('images/sns_google_icon.png', height: getUiSize(30),width: getUiSize(30),color: Color(0xFF192A56),),
                  ),
                  SizedBox(
                    width: 10,
                    height: 10,
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
  Widget _feedGridView (FeedController controller) {
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
          // padding: EdgeInsets.symmetric(horizontal: Constants.feed_tab_horizontal_padding),
          padding: EdgeInsets.symmetric(horizontal: getUiSize(5)),
          crossAxisCount: Get.find<DashboardController>(tag:'mainTag').crossCount.value, //isTabletSize() ?  6 : 4 ,
          itemCount: controller.list.length,
          itemBuilder: (BuildContext context, int index){
            if(controller.list[index].media_id == controller.keywordItemIndex){
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
            }else if(controller.list[index].media_id == controller.admItemIndex){
              return ClipRRect(
                borderRadius: BorderRadius.circular(10.0),
                child: Container(
                  width: 400,
                  height: 200,
                  color: Colors.white,
                  child: const NativeContainer(type: 'small', color: Colors.white),
                ),
              );
              // return const NativeContainer(type: 'small', color: Colors.indigo);
            }
            return FeedItemView (
              dto: controller.list[index], index: index,
              onTap: () {
                controller.detailPageGo(index);
                // print('>>>>>>>>>${controller.list[index].title}');
                //   var returndata = Get.toNamed(AppRoutes.FeedDetailPage, arguments: controller.list[index])!.then((value){
                //     print('다시와!!!');
                //     print('다시와!!!${value}');
                //   }); /** 상세페이지로!! */
                // print('다시와!!!${returndata}');
                // }
              },
            );
          },
          staggeredTileBuilder: (int index) => controller.list[index].media_id == controller.keywordItemIndex ?  new StaggeredTile.fit(8) :  new StaggeredTile.fit(2),
          mainAxisSpacing: getUiSize(5.2),
          crossAxisSpacing: getUiSize(5.2),
        );
      });
    }
  }


  List<Widget> getKeyword(FeedController controller,int index){
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
                        if(controller.list[i].media_id == controller.keywordItemIndex){
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
                        if(controller.list[i].media_id == controller.keywordItemIndex){
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
        GetBuilder<FeedController>(
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