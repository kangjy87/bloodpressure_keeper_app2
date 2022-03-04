
import 'dart:math';
import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:bloodpressure_keeper_app/ui/pages/feed/config/config.dart';
import 'package:bloodpressure_keeper_app/ui/pages/feed/config/enums.dart';
import 'package:bloodpressure_keeper_app/ui/pages/feed/common/BaseScaffoldController.dart';
import 'package:bloodpressure_keeper_app/ui/pages/feed/FeedsDetailController.dart';
import 'package:bloodpressure_keeper_app/ui/pages/feed/dtos/FeedsItemDto.dart';
import 'package:bloodpressure_keeper_app/ui/pages/feed/common/BaseScaffold.dart';
import 'package:bloodpressure_keeper_app/ui/pages/feed/common/TopperIconMenuAsset.dart';
import 'package:bloodpressure_keeper_app/ui/pages/feed/utils/FormatUtil.dart';
import 'package:bloodpressure_keeper_app/ui/pages/feed/utils/GeneralUtils.dart';
import 'package:bloodpressure_keeper_app/ui/pages/feed/utils/logger_utils.dart';
import 'package:bloodpressure_keeper_app/ui/pages/feed/items/MediaItemView.dart';
import 'package:bloodpressure_keeper_app/ui/pages/feed/common/common_ui.dart';
import 'package:bloodpressure_keeper_app/ui/pages/feed/config/AppTranslations.dart';
// import 'package:flutter_statusbar_manager/flutter_statusbar_manager.dart';


class PageFeedsDetail extends GetView<FeedsDetailController> {



  /** TODO : 나중에 반드시 설정파일 등으로 옮겨야 한다... */
  final TextStyle _labelStyle = TextStyle (color: Color (0xff2a2a2a), fontFamily: Font.NotoSansCJKkrRegular, fontSize: getUiSize (10));
  final TextStyle _titleStyleForStep2 = TextStyle(color: Color (0xff2a2a2a), fontFamily: Font.NotoSansCJKkrBold, fontSize: getUiSize(11));
  final TextStyle _descrStyleForStep2 = TextStyle(color: Color (0xff2a2a2a), fontFamily: Font.NotoSansCJKkrRegular, fontSize: getUiSize(6.5));
  final TextStyle _descrStyleForStep3 = TextStyle(color: Color (0xff2a2a2a), fontFamily: Font.NotoSansCJKkrRegular, fontSize: getUiSize(9.5));
  final Radius _labelRadius = Radius.circular(getUiSize(10));


  @override
  Widget build(BuildContext context) {

    // GeneralUtils.setStatusBar(StatusBarStyle.DARK_CONTENT, true);

    Color _bgColor = Get.mediaQuery.orientation == Orientation.portrait ? Colors.white : Colors.black;
    bool _top = false;
    bool _left = Get.mediaQuery.orientation == Orientation.landscape;
    bool _right = Get.mediaQuery.orientation == Orientation.landscape;
    bool _bottom = Get.mediaQuery.orientation != Orientation.landscape;

    /*String _fucked = "content type --> ${controller.data!.type}\n";
    for (ArticleMediaItemDto item in controller.data!.article_medias!) {
      _fucked += "${item.type}\n${item.url}\n${item.storage_url}\n";
      _fucked += "#####################################################\n";
    }

    customLogger.d(_fucked);*/


    return WillPopScope (
        onWillPop:() {
          Get.back(result: controller.reSearch);
          return Future(() => false);
        },
        child: BaseScaffold (
          appBar: _appBarView(context),
          backgroundColor: _bgColor,
          body: OrientationBuilder (
            builder: (context, orientation) {

              customLogger.d("orientation --> $orientation");
              controller.orientation.value = orientation; //--> go update go~

              return SafeArea (
                top: _top,
                left: _left,
                right: _right,
                bottom: _bottom,
                child: _detailContentView (orientation),
              );

            },
          ),
        ),
    );
  }

  //맵바 설정
  AppBar? _appBarView (BuildContext context) {
    AppBar? _appBar;

    if (Get.mediaQuery.orientation == Orientation.portrait) {
      _appBar = AppBar (
        leading: IconButton(
          onPressed: () {
            Get.back(result: controller.reSearch);
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
                    if(controller.data == null || controller.data.title == null){
                      return Text ('소식',
                        overflow: TextOverflow.ellipsis,
                        textAlign : TextAlign.center,
                        style: TextStyle(
                            fontFamily: 'NanumRoundB',
                            fontSize: (isSmallSize() ? getUiSize(15) : getUiSize(12)),
                            color: Color(0xff454f63)),);
                    }else{
                      return Text ((controller.data.title!.isEmpty ? '소식' : ( controller.data.title!.length >20 ?  '${controller.data.title!.substring(0,19)}...' :  controller.data.title))!,
                        overflow: TextOverflow.ellipsis,
                        textAlign : TextAlign.center,
                        style: TextStyle(
                            fontFamily: 'NanumRoundB',
                            fontSize: ((isSmallSize() && controller.data.title!.length < 15) ? getUiSize(15) : getUiSize(12)),
                            color: Color(0xff454f63)),);
                    }
                  }),
                ],
              ),
            ),
            SizedBox(width: getUiSize (42),),
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
  Widget _userThumbnailView () {
    String? userThumbnailURL ;
    if(controller.data != null && controller.data.article_owner != null){
      userThumbnailURL = controller.data.article_owner!.thumbnail_url;
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
                      if(controller.data.article_owner != null)
                        Text (
                          controller.data.article_owner!.name!.length > 10 ?
                          '${controller.data.article_owner!.name!.substring(0,7)}...'
                              :controller.data.article_owner!.name!,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          style: TextStyle (
                            color: Color (0xFF2a2a2a),
                            fontFamily: Font.NotoSansCJKkrRegular,
                            fontSize: getUiSize(11),
                          ),
                        ),
                      if(controller.data.date != null)
                        Text (
                          FormatUtil.printDateTime(controller.data.date!, format: "yyyy.MM.dd"),
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
                controller.shareMe();
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
                  return Image.asset(Get.find<FeedsDetailController>().isFavorite == false ? AppIcons.book_makr_off : AppIcons.book_makr_on, width: getUiSize(10),);
                }),

              ),
              onTap: () {
                controller.setFavorites();
              },
            ),

            SizedBox(width: getUiSize(18),)

          ],
        ),
      );
    });

  }

  Widget _detailContentView (Orientation orientation) {
    return SingleChildScrollView (
      child: Column (
        children: [
          Stack (
            children: [
              Column(
                children: [
                  MediaItemView(strControllerTag: '',),
                  // if (orientation == Orientation.portrait)
                    Container (height: getUiSize(32),)
                ],
              ),
              // if (orientation == Orientation.portrait)
                Positioned(
                    left: getUiSize(6),
                    bottom: 0,
                    child: _userThumbnailView ()
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
                                return Image.asset(Get.find<FeedsDetailController>().isLike == false ? AppIcons.ic_heart2 : AppIcons.ic_heart_on, height: getUiSize(10),);
                              }),
                            ),
                          onTap: () {
                            controller.setLikes();
                          },
                        ),
                        SizedBox (width: getUiSize(3.5),),
                        Obx((){
                          return Text (
                              FormatUtil.numberWithComma(Get.find<FeedsDetailController>().likeCount.value),
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
                      if(controller.data.title != null && controller.data.title!.length > 0){
                        return Text (
                          controller.data.title!,
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
                      return SizedBox (height: getUiSize(controller.data.title != null && controller.data.title!.length > 0 ?15 : 0),);
                    }),
                    // if(controller.data.title != null && controller.data.title!.length > 0)
                    Obx((){
                      return Text (
                          (controller.data.contents != null) ? controller.data.contents! : "",
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
                        canLaunch (controller.data.url!).then((value) {
                          launch(controller.data.url!);
                          // Get.toNamed(RouteNames.WEBVIEW, arguments: controller.data!.url!);
                        });
                      },
                    ),
                  ],
                )
            )
        ],
      ),
    );
  }


  /** 공유 신고 및 하여간 모달 옵션 */
  void _showModalBottomSheet () {

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
                              controller.shareMe();
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
        GetBuilder<FeedsDetailController>(
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
        GetBuilder<FeedsDetailController>(
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

}