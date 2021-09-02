import 'package:bloodpressure_keeper_app/ui/pages/feed_detail/FeedsDetailController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'feed_controller.dart';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:flutter/cupertino.dart';
import 'package:video_player/video_player.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_vlc_player/flutter_vlc_player.dart';
import 'package:bloodpressure_keeper_app/model/feeds/FeedsItemDto.dart';
import 'enums.dart';
import 'MediaItemView.dart';
import 'config.dart';
//import 'package:prj_musical_flt/config/AppTranslations.dart';

class PageFeedsDetail extends GetView<FeedsDetailController> {
  /** 아이콘 나눠 보아요 */
  IconData _iconBack = Platform.isIOS ? Icons.arrow_back_ios : Icons.arrow_back;

  //맵바 설정
  AppBar? _appBarView (BuildContext context) {

    String? _title = controller.data!.title!.isEmpty ? '피드' : controller.data!.title;

    AppBar? _appBar;

    if (Get.mediaQuery.orientation == Orientation.portrait) {
      _appBar = AppBar (
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Image.asset(
            'images/appbar_back.png',
            // fit: BoxFit.fill,
            height: 30,
            width: 30,
          ),
        ),
        title: Text (_title!,
          textAlign : TextAlign.center,
          style: TextStyle(
              fontFamily: 'NanumRoundB',
              fontSize: 20,
              color: Color(0xff454f63)),),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      );
    }

    return _appBar;
  }

  @override
  Widget build(BuildContext context) {

    Color _bgColor = Get.mediaQuery.orientation == Orientation.portrait ? Colors.white : Colors.black;
    bool _top = false;
    bool _left = Get.mediaQuery.orientation == Orientation.landscape;
    bool _right = Get.mediaQuery.orientation == Orientation.landscape;
    bool _bottom = Get.mediaQuery.orientation != Orientation.landscape;

    return Scaffold(
        appBar: _appBarView(context),
        backgroundColor: _bgColor,
        body: SafeArea (
          top: _top,
          left: _left,
          right: _right,
          bottom: _bottom,
          child: SingleChildScrollView (
            child: Column (
              children: [
                MediaItemView(),
                Container(
                    padding: EdgeInsets.all(15),
                    child: Column (
                      children: [
                        Text (
                            controller.data!.contents!
                        )
                      ],
                    )
                )
              ],
            ),
          ),
        )
    );
  }

}