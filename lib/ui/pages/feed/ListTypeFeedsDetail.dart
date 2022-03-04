import 'dart:async';
import 'dart:ui';

import 'package:bloodpressure_keeper_app/model/get_favorite_groups_dto.dart';
import 'package:bloodpressure_keeper_app/ui/pages/dashboard/dashboard_controller.dart';
import 'package:bloodpressure_keeper_app/ui/pages/dashboard/dashboard_page.dart';
import 'package:bloodpressure_keeper_app/ui/routes/app_routes.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:bloodpressure_keeper_app/ui/pages/feed/config/config.dart';
import 'package:bloodpressure_keeper_app/ui/pages/feed/config/enums.dart';
import 'package:bloodpressure_keeper_app/ui/pages/feed/common/BaseScaffoldController.dart';
import 'package:bloodpressure_keeper_app/ui/pages/feed/common/BaseScaffold.dart';
import 'package:bloodpressure_keeper_app/ui/pages/feed/utils/FormatUtil.dart';
import 'package:bloodpressure_keeper_app/ui/pages/feed/utils/GeneralUtils.dart';
import 'package:bloodpressure_keeper_app/ui/pages/feed/utils/logger_utils.dart';
import 'package:bloodpressure_keeper_app/ui/pages/feed/items/MediaItemView.dart';
import 'package:bloodpressure_keeper_app/ui/pages/feed/common/common_ui.dart';
import 'package:bloodpressure_keeper_app/ui/pages/feed/config/AppTranslations.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:skeleton_loader/skeleton_loader.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'FeedFavoriteController.dart';
import 'ListTypeFeedsDetailController.dart';
import 'dtos/FeedsItemDto.dart';
import 'feed_controller.dart';
import 'items/FeedItemView.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/foundation.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ListTypeFeedsDetail extends StatelessWidget{ //extends GetView<ListTypeFeedsDetailController>{
  /** TODO : 나중에 반드시 설정파일 등으로 옮겨야 한다... */
  final TextStyle _labelStyle = TextStyle (color: Color (0xff2a2a2a), fontFamily: Font.NotoSansCJKkrRegular, fontSize: getUiSize (10));
  final TextStyle _titleStyleForStep2 = TextStyle(color: Color (0xff2a2a2a), fontFamily: Font.NotoSansCJKkrBold, fontSize: getUiSize(11));
  final TextStyle _descrStyleForStep2 = TextStyle(color: Color (0xff2a2a2a), fontFamily: Font.NotoSansCJKkrRegular, fontSize: getUiSize(6.5));
  final TextStyle _descrStyleForStep3 = TextStyle(color: Color (0xff2a2a2a), fontFamily: Font.NotoSansCJKkrRegular, fontSize: getUiSize(9.5));
  final Radius _labelRadius = Radius.circular(getUiSize(10));
  final Completer<WebViewController> _WebveiwControllerComplete = Completer<WebViewController>();
  late WebViewController webveiwcontroller ;
  String _strFirstUrl = "";
  @override
  Widget build(BuildContext context) {
    Color _bgColor = Get.mediaQuery.orientation == Orientation.portrait ? Colors.white : Colors.black;
    bool _top = false;
    bool _left = Get.mediaQuery.orientation == Orientation.landscape;
    bool _right = Get.mediaQuery.orientation == Orientation.landscape;
    bool _bottom = Get.mediaQuery.orientation != Orientation.landscape;
    String strTagId = '${(Get.arguments as FeedsItemDto).id}';
    if(!Get.isRegistered<FeedController>()){
      Get.put(FeedController());
    }
    if(!Get.isRegistered<ListTypeFeedsDetailController>(tag: strTagId)){
      Get.put(ListTypeFeedsDetailController(),tag: strTagId);
    }
    /*String _fucked = "content type --> ${controller.data!.type}\n";
    for (ArticleMediaItemDto item in controller.data!.article_medias!) {
      _fucked += "${item.type}\n${item.url}\n${item.storage_url}\n";
      _fucked += "#####################################################\n";
    }

    customLogger.d(_fucked);*/

    return BaseScaffold (
      // floatingActionButton : _webViewBack(),
        appBar: _appBarView(context,strTagId),
        backgroundColor: _bgColor,
        body: OrientationBuilder (
          builder: (context, orientation) {

            customLogger.d("orientation --> $orientation");
            Get.find<ListTypeFeedsDetailController>(tag:strTagId).orientation.value = orientation; //--> go update go~

            return SafeArea (
              top: _top,
              left: _left,
              right: _right,
              bottom: _bottom,
              child: _detailContentView (orientation,strTagId,context),
            );

          },
        ),
        bottomNavigationBar : BottomAppBar(
          child: Container(
            width: double.infinity,
            //margin: EdgeInsets.only(left: 6.0, right: 6.0),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: Text(''),
                ),
                GestureDetector(
                  //update the bottom app bar view each time an item is clicked
                    onTap: () {
                      if(Get.find<FeedController>().youtubePlayerController!= null){
                        Get.find<FeedController>().youtubePlayerController!.pause();
                      }
                      Navigator.popUntil(context, ModalRoute.withName(AppRoutes.DASHBOARD));
                    },
                    child: Image.asset('images/menu_on_2.png',
                        height: getUiSize (40), width: getUiSize (80))
                ),
                Expanded(
                  flex: 1,
                  child: Text(''),
                ),
                GestureDetector(
                    onTap: () {
                      Get.find<DashboardController>(tag:'mainTag').changeTabIndex(1);
                      if(Get.find<FeedController>().youtubePlayerController!= null){
                        Get.find<FeedController>().youtubePlayerController!.pause();
                      }
                      Navigator.popUntil(context, ModalRoute.withName(AppRoutes.DASHBOARD));
                      // Navigator.of(context).pushAndRemoveUntil(
                      //     MaterialPageRoute(builder: (c) => DashboardPage()),
                      //         (route) => false);
                      // Get.offAllNamed(AppRoutes.DASHBOARD);
                      // Get.find<DashboardController>().changeTabIndex(1);
                    },
                    child: Image.asset('images/menu_off_1.png',
                        height: getUiSize (40), width: getUiSize (80))
                ),
                Expanded(
                  flex: 1,
                  child: Text(''),
                ),
                GestureDetector(
                    onTap: () {
                      Get.find<DashboardController>(tag:'mainTag').changeTabIndex(2);
                      if(Get.find<FeedController>().youtubePlayerController!= null){
                        Get.find<FeedController>().youtubePlayerController!.pause();
                      }
                      Navigator.popUntil(context, ModalRoute.withName(AppRoutes.DASHBOARD));
                    },
                    child: Image.asset('images/menu_off_3.png',
                        height: getUiSize (40), width: getUiSize (80))
                ),
                Expanded(
                  flex: 1,
                  child: Text(''),
                ),
              ],
            ),
          ),
          //to add a space between the FAB and BottomAppBar
          // shape: CircularNotchedRectangle(),
          //color of the BottomAppBar
          color: Colors.white,
        )
    );
  }

  //맵바 설정
  AppBar? _appBarView (BuildContext context,String strTagId) {
    AppBar? _appBar;

    if (Get.mediaQuery.orientation == Orientation.portrait) {
      _appBar = AppBar (
        leading: IconButton(
          onPressed: () {
            // Get.find<FeedMainController>().onback();
            Get.back(result: Get.find<ListTypeFeedsDetailController>(tag:strTagId).reSearch);
            // Navigator.of(context).pop();
          },
          icon: Image.asset(
            'images/appbar_back.png',
            // fit: BoxFit.fill,
            height: getUiSize (20),
            width: getUiSize (20),
          ),
        ),
        title: Row(
          children: [
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Obx((){
                    if(Get.find<ListTypeFeedsDetailController>(tag:strTagId).data == null || Get.find<ListTypeFeedsDetailController>(tag:strTagId).data.title == null){
                      return Text ('소식',
                        overflow: TextOverflow.ellipsis,
                        textAlign : TextAlign.center,
                        style: TextStyle(
                            fontFamily: 'NanumRoundB',
                            fontSize: (isSmallSize() ? getUiSize(15) : getUiSize(12)),
                            color: Color(0xff454f63)),);
                    }else{
                      return Text ((Get.find<ListTypeFeedsDetailController>(tag:strTagId).data.title!.isEmpty ? '소식' : ( Get.find<ListTypeFeedsDetailController>(tag:strTagId).data.title!.length >20 ?  '${Get.find<ListTypeFeedsDetailController>(tag:strTagId).data.title!.substring(0,19)}...' :  Get.find<ListTypeFeedsDetailController>(tag:strTagId).data.title))!,
                        overflow: TextOverflow.ellipsis,
                        textAlign : TextAlign.center,
                        style: TextStyle(
                            fontFamily: 'NanumRoundB',
                            fontSize: ((isSmallSize() && Get.find<ListTypeFeedsDetailController>(tag:strTagId).data.title!.length < 15) ? getUiSize(15) : getUiSize(12)),
                            color: Color(0xff454f63)),);
                    }
                  }),
                ],
              ),
            ),
            SizedBox(width: getUiSize (42),
            child: blogAppbar(context,strTagId),),
            // InkWell(
            //   child: Container (
            //     width: getUiSize(10.5),
            //     height: getUiSize(20),
            //     child: SvgPicture.asset(AppIcons.ic_feed_popup_btn, width: getUiSize(10.5),),
            //
            //   ),
            //   onTap: () {
            //     _showModalBottomSheet ();
            //   },
            // ),
          ],
        ),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      );
    }
    return _appBar;
  }
  Widget blogAppbar(BuildContext context, String strTagId){
    if(!Get.isRegistered<ListTypeFeedsDetailController>(tag: strTagId)){
      Get.put(ListTypeFeedsDetailController(),tag: strTagId);
    }
    if(Get.find<ListTypeFeedsDetailController>(tag:strTagId).platform.value == 'naver-blog'){
      return InkWell(
        child: Container (
          padding: EdgeInsets.all(getUiSize(3)),
          width: getUiSize(16.5),
          height: getUiSize(26),
          child: Obx((){
            return Image.asset(Get.find<ListTypeFeedsDetailController>(tag:strTagId).isFavorite == false ? AppIcons.book_makr_off : AppIcons.book_makr_on, width: getUiSize(10),);
          }),

        ),
        onTap: () {
          if(Get.find<ListTypeFeedsDetailController>(tag:strTagId).isFavorite.value ){
            Get.find<ListTypeFeedsDetailController>(tag:strTagId).setFavorites(false,-9,(){
              Fluttertoast.showToast(
                  msg: Get.find<ListTypeFeedsDetailController>(tag:strTagId).isFavorite.value ? '즐겨찾기가 추가되었습니다.':'즐겨찾기가 해제되었습니다.',
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.BOTTOM,
                  timeInSecForIosWeb: 1,
                  backgroundColor: Color(0xff454f63),
                  textColor: Colors.white,
                  fontSize: 16.0
              );
            });
          }else{
            _favoriteInfoShowModalBottomSheetStep(context,strTagId);
          }
        },
      );
    }
    return Text('');
  }
  //맵바 설정
  // AppBar? _appBarView () {
  //
  //   // String? _title = controller.data!.title!.isEmpty ? AppTranslation.lbl_no_title.tr : controller.data!.title;
  //
  //   AppBar? _appBar;
  //
  //   if (Get.mediaQuery.orientation == Orientation.portrait) {
  //     _appBar = AppBar (
  //       leading: IconButton(
  //         icon: SvgPicture.asset(AppIcons.ic_back, height: getUiSize(9),),
  //         onPressed: () => Get.back(),
  //       ),
  //       actions: [
  //         TopperIconMenuAsset(
  //           selected: TopperIconMenu.none, backgroundMode: TopperIconBacgroundMode.bright,
  //           onMyPageTap: () => Get.back(),
  //         ),
  //         SizedBox(width: getUiSize(10.5),)
  //       ],
  //     );
  //   }
  //
  //   return _appBar;
  // }


  /** 유저 프로필 이미지 */
  Widget _userThumbnailView (BuildContext context,String strTagId,) {
    String? userThumbnailURL ;
    if(Get.find<ListTypeFeedsDetailController>(tag:strTagId).data != null && Get.find<ListTypeFeedsDetailController>(tag:strTagId).data.article_owner != null){
      userThumbnailURL = Get.find<ListTypeFeedsDetailController>(tag:strTagId).data.article_owner!.thumbnail_url;
    }
    if (userThumbnailURL == null || userThumbnailURL.isEmpty) userThumbnailURL = "";


    return Obx((){
      return Container (
        width: Get.width - getUiSize (2.2),
        child: Row (
          children: [
            Stack (
              alignment: Alignment.center,
              children: [
                Container (
                  width: getUiSize(37),
                  height: getUiSize(37),
                  decoration: BoxDecoration (
                      shape: BoxShape.circle,
                      color: Colors.white
                  ),

                ),

                ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: CachedNetworkImage (
                    width: getUiSize(32.5),
                    height: getUiSize(32.5),
                    imageUrl: userThumbnailURL!,
                    placeholder: (context, url) => Container(
                      width: 20,
                      height: 20,
                      color: Colors.transparent,
                      child: Image.asset(Images.img_no_profile),
                    ),
                    errorWidget: (context, url, error) => Container(
                      width: 20,
                      height: 20,
                      color: Colors.transparent,
                      child: Image.asset(Images.img_no_profile),
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            ),
            SizedBox (width: 11,),
            Container (
              width: Get.width / 3,
              padding: EdgeInsets.only(top:getUiSize(7)),
              child: Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if(Get.find<ListTypeFeedsDetailController>(tag:strTagId).data.article_owner != null)
                        Text (
                          Get.find<ListTypeFeedsDetailController>(tag:strTagId).data.article_owner!.name!.length > 10 ?
                          '${Get.find<ListTypeFeedsDetailController>(tag:strTagId).data.article_owner!.name!.substring(0,7)}...'
                              :Get.find<ListTypeFeedsDetailController>(tag:strTagId).data.article_owner!.name!,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          style: TextStyle (
                            color: Color (0xFF2a2a2a),
                            fontFamily: Font.NotoSansCJKkrRegular,
                            fontSize: getUiSize(11),
                          ),
                        ),
                      if(Get.find<ListTypeFeedsDetailController>(tag:strTagId).data.date != null)
                        Text (
                          FormatUtil.printDateTime(Get.find<ListTypeFeedsDetailController>(tag:strTagId).data.date!, format: "yyyy.MM.dd"),
                          style: TextStyle (
                              color: Color (0xFF2a2a2a),
                              fontFamily: Font.NotoSansCJKkrRegular,
                              fontSize: getUiSize(7.5)
                          ),
                        )

                    ],
                  ),
                ],
              ),
            ),
            Spacer (flex: 7,),
            //공유하기
            InkWell(
              child: Container (
                  padding: EdgeInsets.all(getUiSize(3)),
                  width: getUiSize(16.5),
                  height: getUiSize(26),
                  child: Image.asset(AppIcons.share_icon, width: getUiSize(10),)

              ),
              onTap: () {
                Get.find<ListTypeFeedsDetailController>(tag:strTagId).shareMe();
              },
            ),
            Spacer (flex: 1,),
            //즐겨찾기
            InkWell(
              child: Container (
                padding: EdgeInsets.all(getUiSize(3)),
                width: getUiSize(16.5),
                height: getUiSize(26),
                child: Obx((){
                  return Image.asset(Get.find<ListTypeFeedsDetailController>(tag:strTagId).isFavorite == false ? AppIcons.book_makr_off : AppIcons.book_makr_on, width: getUiSize(10),);
                }),

              ),
              onTap: () {
                if(Get.find<ListTypeFeedsDetailController>(tag:strTagId).isFavorite.value ){
                  Get.find<ListTypeFeedsDetailController>(tag:strTagId).setFavorites(false,-9,(){
                    Fluttertoast.showToast(
                        msg: Get.find<ListTypeFeedsDetailController>(tag:strTagId).isFavorite.value ? '즐겨찾기가 추가되었습니다.':'즐겨찾기가 해제되었습니다.',
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.BOTTOM,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Color(0xff454f63),
                        textColor: Colors.white,
                        fontSize: 16.0
                    );
                  });
                }else{
                  _favoriteInfoShowModalBottomSheetStep(context,strTagId);
                }
              },
            ),

            SizedBox(width: getUiSize(18),)

          ],
        ),
      );
    });

  }

  Widget _detailContentView (Orientation orientation,strTagId,BuildContext context) {
    if(!Get.isRegistered<ListTypeFeedsDetailController>(tag: strTagId)){
      Get.put(ListTypeFeedsDetailController(),tag: strTagId);
    }
    if(!Get.isRegistered<DashboardController>(tag:'mainTag')){
      Get.put(DashboardController(),tag:'mainTag');
    }
    return SingleChildScrollView (
      controller: Get.find<ListTypeFeedsDetailController>(tag:strTagId).scrollController,
      physics: AlwaysScrollableScrollPhysics (),
      child: Column (
        children: [
          Obx((){
            if(Get.find<ListTypeFeedsDetailController>(tag:strTagId).strNaverBlogUrl.value == ''){
              return Column(
                children: [
                  Stack (
                    children: [
                      Column(
                        children: [
                          Get.find<ListTypeFeedsDetailController>(tag:strTagId).mediaItemView =  MediaItemView(strControllerTag: strTagId,),
                          // MediaItemView(strControllerTag: strTagId,),
                          // if (orientation == Orientation.portrait)
                          Container (height: getUiSize(32),)
                        ],
                      ),
                      // if (orientation == Orientation.portrait)
                      Positioned(
                          left: getUiSize(6),
                          bottom: 0,
                          child: _userThumbnailView (context,strTagId)
                      )
                    ],
                  ),

                  // if (orientation == Orientation.portrait)
                  Container(
                      padding: EdgeInsets.fromLTRB(getUiSize(21.8), getUiSize(5), getUiSize(21.8), getUiSize(21.8)),
                      child: Column (
                        children: [
                          /** 별점 */
                          Row (
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              InkWell(
                                child : Container (
                                  padding: EdgeInsets.all(getUiSize(3)),
                                  width: getUiSize(16.5),
                                  height: getUiSize(26),
                                  child: Obx((){
                                    return Image.asset(Get.find<ListTypeFeedsDetailController>(tag:strTagId).isLike == false ? AppIcons.ic_heart2 : AppIcons.ic_heart_on, height: getUiSize(10),);
                                  }),
                                ),
                                onTap: () {
                                  Get.find<ListTypeFeedsDetailController>(tag:strTagId).setLikes();
                                },
                              ),
                              SizedBox (width: getUiSize(3.5),),
                              Obx((){
                                return Text (
                                    FormatUtil.numberWithComma(Get.find<ListTypeFeedsDetailController>(tag:strTagId).likeCount.value),
                                    style: TextStyle (
                                        color: Color (0xff2a2a2a),
                                        //fontFamily: Font.NotoSansCJKkrRegular,
                                        fontSize: getUiSize(9)
                                    )
                                );
                              }),
                            ],
                          ),
                          SizedBox (height: getUiSize(1),),
                          Obx((){
                            if(Get.find<ListTypeFeedsDetailController>(tag:strTagId).data.title != null && Get.find<ListTypeFeedsDetailController>(tag:strTagId).data.title!.length > 0){
                              return Text (
                                Get.find<ListTypeFeedsDetailController>(tag:strTagId).data.title!,
                                style: TextStyle (
                                    color: Color (0xff2a2a2a),
                                    fontFamily: 'NanumRoundB',
                                    fontSize: getUiSize(12)
                                ),
                              );
                            }else{
                              return Text('');
                            }
                          }),
                          Obx((){
                            return SizedBox (height: getUiSize(Get.find<ListTypeFeedsDetailController>(tag:strTagId).data.title != null && Get.find<ListTypeFeedsDetailController>(tag:strTagId).data.title!.length > 0 ?15 : 0),);
                          }),
                          // if(controller.data.title != null && controller.data.title!.length > 0)
                          Obx((){
                            return Text (
                                (Get.find<ListTypeFeedsDetailController>(tag:strTagId).data.contents != null) ? Get.find<ListTypeFeedsDetailController>(tag:strTagId).data.contents! : "",
                                style: TextStyle (
                                    color: Color (0xff2a2a2a),
                                    fontFamily: Font.NotoSansCJKkrRegular,
                                    fontSize: getUiSize(9)
                                ),
                                textAlign : TextAlign.left
                            );
                          }),

                          SizedBox (height: getUiSize(20),),

                          // 방문하가 버튼
                          AppMaterialButton(
                            label: Text (
                              // AppTranslation.btn_label_visit.tr,
                              '방문하기',
                              style: TextStyle (fontFamily: Font.NotoSansCJKkrBold, color: Color (0xffeeeeee), fontSize: getUiSize(12)),
                            ),
                            color: Color (0xff0057fb),
                            height: getUiSize(40.5),
                            elevation: 0.0,
                            onPressed: () async {
                              canLaunch (Get.find<ListTypeFeedsDetailController>(tag:strTagId).data.url!).then((value) {
                                launch(Get.find<ListTypeFeedsDetailController>(tag:strTagId).data.url!);
                                // Get.toNamed(RouteNames.WEBVIEW, arguments: controller.data!.url!);
                              });
                            },
                          ),
                        ],
                      )
                  ),
                ],
              );
            }else{
              return Column(
                children: [
                  Obx((){
                    return Container(
                      width: double.infinity,
                      height: Get.find<ListTypeFeedsDetailController>(tag:strTagId).webViewHeight.value+100,
                      child: Stack(
                        children: [
                          WebView(
                            onWebViewCreated: (WebViewController webViewController) {
                              _WebveiwControllerComplete.complete(webViewController);
                              _WebveiwControllerComplete.future.then((value) => webveiwcontroller = value);
                            },
                            // gestureRecognizers: Set()
                            //   ..add(Factory<VerticalDragGestureRecognizer>(
                            //           () => VerticalDragGestureRecognizer())),
                            initialUrl: Get.find<ListTypeFeedsDetailController>(tag:strTagId).strNaverBlogUrl.value,
                            // initialUrl: Get.find<ListTypeFeedsDetailController>(tag:strTagId).data.url,
                            javascriptMode: JavascriptMode.unrestricted,
                            gestureNavigationEnabled: true,
                            onPageStarted: (String url) async {
                              if(url.contains('https://m.')){
                                if(_strFirstUrl == ""){
                                  _strFirstUrl = url ;
                                  Get.find<ListTypeFeedsDetailController>(tag:strTagId).onBackCheck.value = false ;
                                }else if(_strFirstUrl == url){
                                  Get.find<ListTypeFeedsDetailController>(tag:strTagId).onBackCheck.value = false ;
                                }else{
                                  Get.find<ListTypeFeedsDetailController>(tag:strTagId).onBackCheck.value = true ;
                                }
                              }
                              // Get.find<ListTypeFeedsDetailController>(tag:strTagId).onBackCheck.value = await webveiwcontroller.canGoBack();
                              print('111111111111111111111111111111111111111111$url');
                            },
                            onPageFinished: (String url) async {
                              print('222222222222222222222222222222222222$url');
                              Get.find<ListTypeFeedsDetailController>(tag:strTagId).webViewHeight.value = double.tryParse( await webveiwcontroller.evaluateJavascript("document.documentElement.scrollHeight;"))!;
                              print('>>>>>>>>>>>>>>>${Get.find<ListTypeFeedsDetailController>(tag:strTagId).webViewHeight.value}');
                              },
                            navigationDelegate: (NavigationRequest request) {
                              print('333333333333333333333333333${request.url}');
                              return NavigationDecision.navigate;
                            },
                          ),
                          _webViewBack(strTagId)
                        ],
                      ),
                      // Stack
                    );
                  }),
                  Container(
                    width: getUiSize(35),
                    height: getUiSize (3),
                    margin: EdgeInsets.only(top: getUiSize(9)),
                    decoration: BoxDecoration (
                        color: Color (0xffdbdbdb),
                        borderRadius: BorderRadius.all(Radius.circular (100))
                    ),
                  ),
                  SizedBox (height: getUiSize(10.5)),
                ],
              );
            }
          }),
          //피드 리스트
          // _feedGridView(controller),
          Obx((){
            return StaggeredGridView.countBuilder(
              shrinkWrap: true,
              // controller: controller.scrollController,
              physics: NeverScrollableScrollPhysics (),
              primary: false,
              key: PageStorageKey ("fuckedOne${Get.find<DashboardController>(tag:'mainTag').crossCount.value}"),
              // padding: EdgeInsets.symmetric(horizontal: Constants.feed_tab_horizontal_padding),
              padding: EdgeInsets.symmetric(horizontal: getUiSize(5)),
              crossAxisCount: Get.find<DashboardController>(tag:'mainTag').crossCount.value, //isTabletSize() ?  6 : 4 ,
              itemCount: Get.find<ListTypeFeedsDetailController>(tag:strTagId).list.length,
              itemBuilder: (BuildContext context, int index) => FeedItemView (
                dto: Get.find<ListTypeFeedsDetailController>(tag:strTagId).list[index], index: index,
                onTap: () async {
                  Get.find<ListTypeFeedsDetailController>(tag:strTagId).detailPageGo(index);
                },
              ),
              staggeredTileBuilder: (int index) => new StaggeredTile.fit(2),
              mainAxisSpacing: getUiSize(2.2),
              crossAxisSpacing: getUiSize(2.2),
            );
          })
        ],
      ),
    );
  }
  Widget _webViewBack(String strTagId){
    return Obx((){
      return Visibility(
        visible: Get.find<ListTypeFeedsDetailController>(tag:strTagId).onBackCheck.value,
        child: Align(
          alignment: Alignment(-0.85, 0.95),
          child: FloatingActionButton(
            backgroundColor: Colors.black87,
            child: Icon(Icons.navigate_before),
            onPressed: (){
              webveiwcontroller.goBack();
            },
          ),
        ),
      );
    });
  }
  /** 스태거드 그리드 뷰 */
  Widget _feedGridView (ListTypeFeedsDetailController controller) {

    //처음 서버타기전
    if (controller.feedData == null){ // || controller.list.length == 0) {
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
    else if(controller.feedData!.statusCode == 200 && controller.list.length == 0){
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
          ),
          staggeredTileBuilder: (int index) => new StaggeredTile.fit(2),
          mainAxisSpacing: getUiSize(2.2),
          crossAxisSpacing: getUiSize(2.2),
        );
      });
    }
  }
  /** 공유 신고 및 하여간 모달 옵션 */
  void _showModalBottomSheet (String strTagId) {

    Get.bottomSheet(
        SafeArea(
            child: Container (
              padding: EdgeInsets.all(getUiSize(11.2)),
              alignment: Alignment.bottomCenter,
              child: Column (
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container (
                    width: double.maxFinite,
                    // height: getUiSize(81.2),
                    constraints: BoxConstraints (
                        minHeight: getUiSize(20)
                    ),
                    child: Column (
                      children: [

                        //게시중단 버튼
                        InkWell(
                          child: Container (
                            height: getUiSize (40.5),
                            alignment: Alignment.center,
                            child: Text (AppTranslation.btn_label_stop_posting.tr, style: _labelStyle),
                          ),
                          onTap: () {
                            Get.back(); //닫기;
                            _showModalBottomSheetStep2 ();
                          },
                        ),
                        Partition(weight: getUiSize(0.2)),

                        //공유 버튼
                        InkWell(
                            child: Container (
                              height: getUiSize (40.5),
                              alignment: Alignment.center,
                              child: Text (AppTranslation.btn_label_share.tr, style: _labelStyle),
                            ),
                            onTap: () {
                              Get.back();
                              Get.find<ListTypeFeedsDetailController>(tag:strTagId).shareMe();
                            }
                        )

                      ],
                    ),
                    decoration: BoxDecoration (
                        color: Colors.white,
                        borderRadius: BorderRadius.all (_labelRadius),
                        border: Border.all(color: Color (0xffd2d2d2), width: getUiSize(0.2))
                    ),

                  ),
                  SizedBox (height: getUiSize(7.5)),

                  Container (
                    width: double.maxFinite,
                    // height: getUiSize(81.2),
                    constraints: BoxConstraints (
                        minHeight: getUiSize(20)
                    ),
                    child: Column (
                      children: [

                        //취소버튼
                        InkWell(
                          child: Container (
                            height: getUiSize (40.5),
                            alignment: Alignment.center,
                            child: Text (AppTranslation.btn_label_cancel.tr, style: _labelStyle.copyWith(color: Color (0xffff0085))),
                          ),
                          onTap: () {
                            Get.back(); //닫기;
                          },
                        ),

                      ],
                    ),
                    decoration: BoxDecoration (
                      color: Colors.white,
                      borderRadius: BorderRadius.all(_labelRadius),
                    ),

                  ),

                ],
              ),
            )
        )
    );

  }
  /** 게시 중단 요청 */
  void _showModalBottomSheetStep2 () {

    Get.bottomSheet(
        GetBuilder<ListTypeFeedsDetailController>(
          // tag: strTagId,
            builder: (controller) {
              controller.stopPostingReason = StopPostingReason.none;

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
                            Text (AppTranslation.title_request_stop_posting.tr, style: _titleStyleForStep2,),

                            SizedBox (height: getUiSize(6)),

                            Padding (
                              padding: EdgeInsets.symmetric(horizontal: getUiSize(20)),
                              child: Text (AppTranslation.description_request_stop_posting.tr, style: _descrStyleForStep2,),
                            ),

                            SizedBox(height: getUiSize(18.5),),

                            Partition(weight: getUiSize(0.5)),

                            //선정적이거나 폭력적인 게시물
                            InkWell(
                              child: Container (
                                width: double.maxFinite,
                                height: getUiSize(40.5),
                                child: Stack (
                                  alignment: Alignment.center,
                                  children: [
                                    Text (AppTranslation.btn_label_violant_or_sexual.tr, style: _labelStyle),
                                    Obx (() {
                                      if (controller.stopPostingReason == StopPostingReason.violant_and_sexual)
                                        return Positioned (
                                            left: getUiSize(41.5),
                                            child: SvgPicture.asset(AppIcons.ic_selected, width: getUiSize (17.2),)
                                        );
                                      else {
                                        return Container ();
                                      }
                                    })
                                  ],
                                ),
                              ),
                              onTap: () {
                                controller.stopPostingReason = StopPostingReason.violant_and_sexual;
                              },
                            ),

                            Partition(weight: getUiSize(0.5), color: Color (0xffd2d2d2)),

                            //저작권이 침해된 게시물
                            InkWell(
                              child: Container (
                                width: double.maxFinite,
                                height: getUiSize(40.5),
                                child: Stack (
                                  alignment: Alignment.center,
                                  children: [
                                    Text (AppTranslation.btn_label_invalid_copyright.tr, style: _labelStyle),
                                    Obx (() {
                                      if (controller.stopPostingReason == StopPostingReason.invalid_copyright)
                                        return Positioned (
                                            left: getUiSize(41.5),
                                            child: SvgPicture.asset(AppIcons.ic_selected, width: getUiSize (17.2),)
                                        );
                                      else {
                                        return Container ();
                                      }
                                    })
                                  ],
                                ),
                              ),
                              onTap: () {
                                controller.stopPostingReason = StopPostingReason.invalid_copyright;
                              },
                            ),

                            Partition(weight: getUiSize(0.5), color: Color (0xffd2d2d2)),

                            //기타
                            InkWell(
                              child: Container (
                                width: double.maxFinite,
                                height: getUiSize(40.5),
                                child: Stack (
                                  alignment: Alignment.center,
                                  children: [
                                    Text (AppTranslation.btn_label_etc.tr, style: _labelStyle),
                                    Obx (() {
                                      if (controller.stopPostingReason == StopPostingReason.etc)
                                        return Positioned (
                                            left: getUiSize(41.5),
                                            child: SvgPicture.asset(AppIcons.ic_selected, width: getUiSize (17.2),)
                                        );
                                      else {
                                        return Container ();
                                      }
                                    })
                                  ],
                                ),
                              ),
                              onTap: () {
                                controller.stopPostingReason = StopPostingReason.etc;
                              },
                            ),

                            Partition(weight: getUiSize(0.5), color: Color (0xffd2d2d2)),

                            SizedBox (height: getUiSize (6.2),),

                            //확인 버튼
                            Obx (() => Padding (
                              padding: EdgeInsets.symmetric(horizontal: getUiSize(10)),
                              child: AppMaterialButton(
                                label: Text (
                                  AppTranslation.btn_label_confirm.tr,
                                  style: TextStyle (fontFamily: Font.NotoSansCJKkrBold, color: Color (0xffeeeeee), fontSize: getUiSize(12)),
                                ),
                                color: Color (0xff434343),
                                height: getUiSize(40.5),
                                elevation: 0.0,
                                onPressed: controller.stopPostingReason == StopPostingReason.none
                                    ? null
                                    : () async {
                                  //TODO : 게시물 중단요청 신고
                                  Get.back ();
                                  Get.find<BaseScaffoldController>().isLoading = true;
                                  await Future.delayed(Duration (milliseconds: 1000));
                                  _showModalBottomSheetStep3 ();
                                  Get.find<BaseScaffoldController>().isLoading = false;
                                },
                              ),
                            )),

                          ],
                        ),
                      ),
                      decoration: BoxDecoration (
                        color: Colors.white,
                        borderRadius: BorderRadius.only(topLeft: _labelRadius, topRight: _labelRadius),
                      ),

                    ),

                  ],
                ),
              );
            }
        )
    );
  }



  /** 게시 중단 요청 결과 */
  void _showModalBottomSheetStep3 () {

    Get.bottomSheet(
        GetBuilder<ListTypeFeedsDetailController>(
            builder: (controller) {

              controller.stopPostingReason = StopPostingReason.none;

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

                            SizedBox (height: getUiSize(69)),

                            Text (AppTranslation.desc_request_success.tr, style: _descrStyleForStep3),

                            SizedBox (height: getUiSize(14),),

                            InkWell(
                              child: SvgPicture.asset(AppIcons.ic_checked, width: getUiSize(30),),
                              onTap: () {
                                Get.back();
                              },
                            ),

                            SizedBox (height: getUiSize(110),)

                          ],
                        ),
                      ),
                      decoration: BoxDecoration (
                        color: Colors.white,
                        borderRadius: BorderRadius.only(topLeft: _labelRadius, topRight: _labelRadius),
                      ),

                    ),

                  ],
                ),
              );
            }
        )
    );
  }

  _favoriteInfoShowModalBottomSheetStep(BuildContext buidContext,String strTagId){
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
                  SizedBox(height: 20,),
                  SizedBox(
                    width: double.infinity,
                    height: 300,
                    child: Obx(()=>ListView.separated(
                      itemCount: controller.favoriteGroups!.length,
                      itemBuilder: (context, index) {
                        print('>>>>>>>>>>>>${index}');
                        return listItem(controller.favoriteGroups![index],index,strTagId,buidContext);
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

  Widget listItem(FavoriteGroups data,int index,String strTagId,BuildContext context) {
    return ListTile(
      title: Text(data.group_name!),
      onTap: (){
        Get.find<ListTypeFeedsDetailController>(tag:strTagId).setFavorites(true,data.id!,(){
          Fluttertoast.showToast(
              msg: Get.find<ListTypeFeedsDetailController>(tag:strTagId).isFavorite.value ? '즐겨찾기가 추가되었습니다.':'즐겨찾기가 해제되었습니다.',
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Color(0xff454f63),
              textColor: Colors.white,
              fontSize: 16.0
          );
          Navigator.pop(context);
        });
      },
      // onTap: () => 'ddddd',
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
