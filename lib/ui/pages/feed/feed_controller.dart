import 'dart:ffi';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:bloodpressure_keeper_app/ui/pages/feed/apis/FeedsClient.dart';
import 'package:bloodpressure_keeper_app/ui/pages/feed/config/config.dart';
import 'package:bloodpressure_keeper_app/ui/pages/feed/dtos/CommonDto.dart';
import 'package:bloodpressure_keeper_app/ui/pages/feed/dtos/FeedsItemDto.dart';
import 'package:bloodpressure_keeper_app/ui/pages/feed/dtos/FeedsListDto.dart';
import 'package:bloodpressure_keeper_app/ui/pages/feed/utils/DioClient.dart';
import 'package:bloodpressure_keeper_app/ui/pages/feed/utils/GeneralUtils.dart';
import 'package:bloodpressure_keeper_app/ui/pages/feed/utils/SharedPrefUtil.dart';
import 'package:bloodpressure_keeper_app/ui/pages/feed/utils/logger_utils.dart';
import 'package:bloodpressure_keeper_app/ui/pages/feed/common/BaseScaffoldController.dart';

class FeedController extends GetxController {

  FeedsListDto? data;
  final List<FeedsItemDto> list = <FeedsItemDto>[].obs;

  int page = 0;
  int per_page = 50;
  bool listEnd = false;
  bool isLoading = false;

  ScrollController scrollController = ScrollController();

  final RxBool nestedScrollable = false.obs;

  /** 검색어 및 플랫폼 선택을 위해 */
  final FocusNode searchFocusNode = FocusNode ();
  final TextEditingController searchController = TextEditingController();
  String? platform;
  String? keyword;

  final refreshKey = GlobalKey<RefreshIndicatorState>();

  @override
  void onInit () {
    super.onInit();

    list.clear();
    page = 1;
    listEnd = false;

    scrollController.addListener(() {

      try {
        double _remainDistance = scrollController.position.maxScrollExtent - scrollController.offset;
        if (_remainDistance <= Get.height * 3 &&

            ///--> 스크린 크기의 몇배의 스크롤 높이가 남으면 로드할거냐????
            !scrollController.position.outOfRange) {
          //다음페이지 로드
          if (!listEnd && !isLoading) {
            page += 1;
            getFeeds();
          }
        }

      } catch (error) {
        //nothing yet;
      }
    });

    //데이타 로드
    getFeeds ();
  }



  Future<void> getFeeds () async {

    isLoading = true;
    final client = FeedsClient(DioClient.dio);
    await client.getFeeds(
        1 /** 1 ~ 3 */, page, per_page,SharedPrefUtil.getString(SharedPrefKey.CURATOR9_TOKEN)
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

  //새로 고침
  Future<void> refreshFeeds (bool withIndicator) async {
    if (withIndicator) refreshKey.currentState!.show (atTop: true);
    else Get.find<BaseScaffoldController>().isLoading = true;
    list.clear();
    page = 1;
    listEnd = false;
    await getFeeds ();
    Get.find<BaseScaffoldController>().isLoading = false;
  }

  /** 검색어 리스트 로드 */
  Future<void> getSearchKeywords () async {
    // contents_client.getSearchKeywords ().then((SearchKeywordsResponseDto result) {
    //
    //   keywords.addAll (result.data!);
    //   List<String> tmp = result.message!.split("#");
    //   for (String itm in tmp) {
    //     if (itm.isNotEmpty) tagItems!.add(TagItemDto(word: itm));
    //   }
    //
    // }).onError((DioError error, stackTrace) {
    //   //nothing yet;
    // });
  }

  /** 검색 */
  void searchFeeds (String? keyword) {
    this.keyword = keyword != null ? "#$keyword" : null;
    searchController.text = keyword ?? "";
    refreshFeeds(false);
  }

  /** 맨위로 올라가세요!! */
  void scrollToTop () {
    scrollController.animateTo(0, duration: Duration (milliseconds: 500), curve: Curves.easeOut);
  }
}