import 'dart:io';
import 'dart:math';

import 'package:bloodpressure_keeper_app/transition/MyTransitions.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_vlc_player/flutter_vlc_player.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

import 'FeedsDetailController.dart';
import 'items/MediaItemView.dart';

class PageFeedsDetail extends GetView<FeedsDetailController> {




  //맵바 설정
  AppBar? _appBarView () {

    String? _title = controller.data!.title!.isEmpty ? "!!!!!!!!!!!!!!!!" : controller.data!.title;

    AppBar? _appBar;

    if (Get.mediaQuery.orientation == Orientation.portrait) {
      _appBar = AppBar (
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Get.back(),
        ),
        title: Text (_title!),
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
      appBar: _appBarView(),
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