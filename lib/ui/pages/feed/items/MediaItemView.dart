import 'dart:io';

import 'package:bloodpressure_keeper_app/ui/pages/feed/dtos/MediaInfo.dart';
import 'package:bloodpressure_keeper_app/ui/pages/feed/utils/ContentsUtil.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:bloodpressure_keeper_app/ui/pages/feed/config/config.dart';
import 'package:bloodpressure_keeper_app/ui/pages/feed/config/enums.dart';
import 'package:bloodpressure_keeper_app/ui/pages/feed/FeedsDetailController.dart';
import 'package:bloodpressure_keeper_app/ui/pages/feed/dtos/FeedsItemDto.dart';
import 'package:bloodpressure_keeper_app/ui/pages/feed/common/videos/TdiVideoPlayer.dart';
import 'package:bloodpressure_keeper_app/ui/pages/feed/common/videos/TdiYoutubePlayer.dart';
import 'package:bloodpressure_keeper_app/ui/pages/feed/utils/GeneralUtils.dart';
import 'package:bloodpressure_keeper_app/ui/pages/feed/utils/logger_utils.dart';

class MediaItemView extends StatelessWidget {

  Widget _commonError = Container (
      color: Colors.grey,
      child: Image.asset(Images.img_placeholder, fit: BoxFit.cover,)
  );

  Widget _getMediaItemView (ArticleMediaItemDto item, PlatformType platform, String thumbnailURL) {

    MediaInfo _mediaInfo = ContentsUtil.getFeedDetailMediaInfo (item, platform);

    switch (enumFromString(MediaType.values, item.type!)) {
      case MediaType.image :

        String? _mediaUrl = (item.storage_url!.startsWith("http")) ? item.storage_url : Constants.CDN_URL + item.storage_url!;


        customLogger.d("_mediaUrl -- $_mediaUrl");

        return Container(
          width: Get.width,
          color: Colors.black,
          constraints: BoxConstraints (
              minHeight: 300
          ),
          child: CachedNetworkImage(
            imageUrl: _mediaUrl!,
            errorWidget: (context, url, error) => Icon(Icons.error, color: Colors.black26),
            fit: BoxFit.contain,
            cacheKey: _mediaUrl,
          ),
        );

      case MediaType.video :

        if (_mediaInfo.url == null || _mediaInfo.url!.isEmpty) { //주소가 없는건 거르자...
          return _commonError;
        } else if (_mediaInfo.type == MediaPlayType.video_youtube) {
          return TdiYouTubePlayer(videoId: _mediaInfo.url, mController: Get.find<FeedsDetailController>(),);
        } else if (_mediaInfo.type == MediaPlayType.video_mp4) {
          return TdiVidePlayer(videoUrl: _mediaInfo.url, mController: Get.find<FeedsDetailController>(),);
        } else {
          return _commonError;
        }

      default :
        return _commonError;
    }
  }

  double _getContentProp (FeedsDetailController controller) {
    double _asp = 0.0;
    if (controller.currentMedia.width == null || controller.currentMedia.width == 0
        || controller.currentMedia.height == null || controller.currentMedia.height == 0) {
      _asp = 300 / Get.width;
    } else {
      _asp = controller.currentMedia.height! / controller.currentMedia.width!;
    }

    customLogger.d("비율 --> $_asp ------> ${controller.currentMedia.height} / ${controller.currentMedia.width}");
    return _asp;
  }

  @override
  Widget build(BuildContext context) {

    return GetBuilder<FeedsDetailController> (
      init: FeedsDetailController (),
      builder:(controller) =>
      controller.data.article_medias!.length > 1 ?
      Obx (() {
        return Container (
            color: Colors.black,
            child: Stack (
                alignment: Alignment.center,
                children: [
                  CarouselSlider(
                    options: CarouselOptions(
                        aspectRatio: (controller.orientation.value == Orientation.portrait) ? 1 / 1 : Get.width / Get.height,
                        height: controller.orientation.value == Orientation.landscape ? Get.height : Get.width,
                        viewportFraction : 1,
                        onPageChanged: (index, reason) {
                          controller.mediaCarouselCurrent.value = index;
                        }
                    ),
                    carouselController: controller.mediaCarouselController,
                    items: controller.data.article_medias!.map((item) => Container(
                      width: Get.width,
                      alignment: Alignment.center,
                      child: _getMediaItemView (item, enumFromString(PlatformType.values, controller.data.platform!), controller.data.thumbnail_url!),
                    )).toList(),
                  ),

                  Positioned (
                      bottom: getUiSize (5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: controller.data.article_medias!.asMap().entries.map((entry) {
                          return GestureDetector(
                            onTap: () => controller.mediaCarouselController!.animateToPage(entry.key),
                            child: Container(
                              width: getUiSize(3),
                              height: getUiSize(3),
                              margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.white.withOpacity(controller.mediaCarouselCurrent.value == entry.key ? 1.0 : 0.5)),
                            ),
                          );
                        }).toList(),
                      )
                  )
                ])
        );
      })
          : controller.data.article_medias!.length == 0 ?
      Container (

      )
          :
      Container (
        width: Get.width,
        height: controller.orientation.value == Orientation.portrait ? Get.width : Get.height,
        color: Colors.black,
        alignment: Alignment.center,
        child:  _getMediaItemView(controller.currentMedia, enumFromString(PlatformType.values, controller.data.platform!), controller.data.thumbnail_url!),
      )

      ,
    );
  }

}