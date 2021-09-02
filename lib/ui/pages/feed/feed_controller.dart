import 'dart:ffi';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:bloodpressure_keeper_app/model/feeds/FeedsItemDto.dart';
import 'package:bloodpressure_keeper_app/model/feeds/FeedsListDto.dart';
import 'FeedsClient.dart';
import 'DioClient.dart';
// import 'package:prj_musical_flt/apis/AuthClient.dart';
// import 'package:prj_musical_flt/config/config.dart';
// import 'package:prj_musical_flt/controllers/HomeController.dart';
// import 'package:prj_musical_flt/dtos/CommonDto.dart';
// import 'package:prj_musical_flt/utils/SharedPrefUtil.dart';
// import 'package:prj_musical_flt/utils/logger_utils.dart';

class FeedController extends GetxController {

  FeedsListDto? data;
  final List<FeedsItemDto> list = <FeedsItemDto>[].obs;

  int page = 0;
  int per_page = 50;
  bool listEnd = false;
  bool isLoading = false;

  ScrollController scrollController = ScrollController();

  @override
  void onInit () {
    super.onInit();

    list.clear();
    page = 1;
    listEnd = false;

    scrollController.addListener(() {

      double _remainDistance = scrollController.position.maxScrollExtent - scrollController.offset;


      if (_remainDistance <= Get.height * 3 && ///--> 스크린 크기의 몇배의 스크롤 높이가 남으면 로드할거냐????
          !scrollController.position.outOfRange) {

        //다음페이지 로드
        if (!listEnd && !isLoading) {
          page += 1;
          getFeeds();
        }

      }
    });

    //데이타 로드
    getFeeds ();
  }

  Future<void> getFeeds () async {


    isLoading = true;
    final client = FeedsClient(DioClient.dio);
    await client.getFeeds(
        1 /** 1000 ~ 1002 */, page, per_page
    ).then((result) {

      data = result;

      //가라 데이타 ---------------------------------------------------------
      // list.add(fakeMe);
      //가라 데이타 ---------------------------------------------------------


      list.addAllIf(data!.data!.articles!.length > 0, data!.data!.articles!);

      if (data!.data!.articles!.length < per_page) {
        listEnd = true;
      }

      isLoading = false;

      update ();

    }).catchError((Object obj) async {
      // non-200 error goes here.
      switch (obj.runtimeType) {
        case DioError:
          final res = (obj as DioError).response;
          update();
          break;
        default:
        //nothing yet;
      }
      isLoading = false;
    });

  }
}