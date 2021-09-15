import 'package:carousel_slider/carousel_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:bloodpressure_keeper_app/ui/pages/feed/config/config.dart';
import 'package:bloodpressure_keeper_app/ui/pages/feed/config/enums.dart';
import 'package:bloodpressure_keeper_app/ui/pages/feed/common/BaseScaffoldController.dart';
import 'package:bloodpressure_keeper_app/ui/pages/feed/dtos/FeedsItemDto.dart';
// import 'package:bloodpressure_keeper_app/ui/pages/feed/utils/FirebaseUtil.dart';
import 'package:bloodpressure_keeper_app/ui/pages/feed/utils/logger_utils.dart';
import 'package:share_plus/share_plus.dart';

class FeedsDetailController extends GetxController {

  FeedsItemDto? data;

  CarouselController? mediaCarouselController;
  final RxInt mediaCarouselCurrent = 0.obs;

  final orientation = Orientation.portrait.obs;


  //현재 미디어 반환
  ArticleMediaItemDto get currentMedia => data!.article_medias![mediaCarouselCurrent.value];


  /** 게시중단 요청 사유 관련 .. */
  final _stopPostingReason = StopPostingReason.none.obs;
  set stopPostingReason (StopPostingReason value) => _stopPostingReason.value = value;
  StopPostingReason get stopPostingReason => _stopPostingReason.value;



  @override
  void onInit () {
    super.onInit();

    mediaCarouselController = CarouselController();
    data = Get.arguments as FeedsItemDto;
  }

  /** for share */
  Future<void> shareMe ()async {

    Get.find<BaseScaffoldController>().isLoading = true;

    String? _itemImageURL = (data!.storage_thumbnail_url == null || data!.storage_thumbnail_url!.isEmpty)
        ? ""
        : data!.storage_thumbnail_url!.startsWith("http") ? data!.storage_thumbnail_url
        : Constants.CDN_URL + data!.storage_thumbnail_url!;

    // Uri url = await FirebaseUtil.createDynamicLink(
    //     true, RouteNames.FEEDS_DETAIL, data!.id.toString(),
    //     _itemImageURL!,
    //     data!.title!,
    //     data!.contents!
    // );
    // customLogger.d ("dynamic link : ${url.toString()}");
    //
    // Share.share(url.toString());

    Get.find<BaseScaffoldController>().isLoading = false;
  }
}