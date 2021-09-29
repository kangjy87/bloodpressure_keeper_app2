import 'package:bloodpressure_keeper_app/ui/pages/feed/utils/ContentsUtil.dart';
import 'package:bloodpressure_keeper_app/ui/pages/feed/utils/DioClient.dart';
import 'package:carousel_slider/carousel_controller.dart';
import 'package:dio/dio.dart';
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

import 'apis/FeedsClient.dart';
import 'common/videos/TdiOrientationController.dart';
import 'dtos/FeedsDetailDto.dart';
import 'dtos/MediaInfo.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';

class FeedsDetailController extends TdiOrientationController {

  final FeedsClient feedsClient = FeedsClient(DioClient.dio);

  final _data = FeedsItemDto ().obs;
  FeedsItemDto get data => _data.value;
  set data (FeedsItemDto t) => _data.value = t;

  CarouselController? mediaCarouselController;
  final RxInt mediaCarouselCurrent = 0.obs;


  //현재 미디어 반환
  ArticleMediaItemDto get currentMedia => data.article_medias![mediaCarouselCurrent.value];


  /** 게시중단 요청 사유 관련 .. */
  final _stopPostingReason = StopPostingReason.none.obs;
  set stopPostingReason (StopPostingReason value) => _stopPostingReason.value = value;
  StopPostingReason get stopPostingReason => _stopPostingReason.value;



  @override
  void onInit () async {
    super.onInit();

    mediaCarouselController = CarouselController();

    customLogger.d("또 갈까? --> ${Get.arguments}");

    if (Get.arguments.runtimeType == FeedsItemDto) {
      data = Get.arguments as FeedsItemDto;
    } else if (Get.arguments.runtimeType == String) {
      data = await getFeedDetail ();
    }
  }

  @override
  void onClose () {
    super.onClose();
  }


  /** for share */
  Future<void> shareMe ()async {

    Get.find<BaseScaffoldController>().isLoading = true;

    MediaInfo _mediaInfo = ContentsUtil.getFeedsThumbNailInfo(data);

    Uri url = await createDynamicLink(
        true, RouteNames.FEEDS_DETAIL, data.id.toString(),
        _mediaInfo.url!,
        data.title!,
        data.contents!
    );


    customLogger.d ("미리보기 이미지 : ${_mediaInfo.url!}");
    customLogger.d ("dynamic link : ${url.toString()}");
    customLogger.d ("id : ${data.id}");

    Share.share(url.toString());

    Get.find<BaseScaffoldController>().isLoading = false;
  }

  /** 상세데이타가 없다면 로드할것!! */
  Future<FeedsItemDto> getFeedDetail () async {

    FeedsItemDto _result = FeedsItemDto();

    await Future.delayed(Duration (milliseconds: 500)); //--> 객체 생성 까지 0.5초 대기
    Get.find<BaseScaffoldController>().isLoading = true;
    await feedsClient.getFeedDetail (Get.arguments).then((FeedsDetailDto result) {
      Get.find<BaseScaffoldController>().isLoading = false;
      _result = result.data as FeedsItemDto;
    }).onError((DioError error, stackTrace) {
      Get.find<BaseScaffoldController>().isLoading = false;
    });

    return _result;
  }


  int get like => data.article_detail == null ? 0 : data.article_detail!.like!;


  /** 딥링크 생성 */
  static Future<Uri> createDynamicLink(bool short, String route, String params, String imageURL, String title, String description) async {

    final DynamicLinkParameters parameters = DynamicLinkParameters(
        uriPrefix: Constants.deeplink_prefix_domain,
        link: Uri.parse('${Constants.deeplink_prefix_domain}$route/$params'),
        androidParameters: AndroidParameters(
          packageName: Constants.androidApplicationId,
          minimumVersion: 1,
        ),
        dynamicLinkParametersOptions: DynamicLinkParametersOptions(
          shortDynamicLinkPathLength: ShortDynamicLinkPathLength.short,
        ),
        iosParameters: IosParameters(
          bundleId: Constants.appleBundleId,
          minimumVersion: '1.0.0',
        ),
        socialMetaTagParameters: SocialMetaTagParameters (
            imageUrl: Uri.parse (imageURL),
            title: title,
            description: description
        )
    );

    Uri url;
    if (short) {
      final ShortDynamicLink shortLink = await parameters.buildShortLink();
      url = shortLink.shortUrl;
    } else {
      url = await parameters.buildUrl();
    }

    return url;

  }
}