
import 'package:bloodpressure_keeper_app/ui/pages/feed_detail/FeedsDetailController.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vlc_player/flutter_vlc_player.dart';
import 'package:get/get.dart';
import 'package:bloodpressure_keeper_app/model/feeds/FeedsItemDto.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'enums.dart';
import 'config.dart';
// import 'package:prj_musical_flt/utils/logger_utils.dart';

class MediaItemView extends StatelessWidget {

  Widget _commonError = Container (
      color: Colors.grey,
      child: Image.asset(Images.img_placeholder, fit: BoxFit.cover,)
  );

  Widget _getMediaItemView (ArticleMediaItemDto item, String flatform) {

    switch (enumFromString(MediaType.values, item.type!)) {
      case MediaType.image :

        String? _mediaUrl = (item.storage_url!.startsWith("http")) ? item.storage_url : Constants.CDN_URL + item.storage_url!;

        return Container(
          width: Get.width,
          constraints: BoxConstraints (
              minHeight: 300
          ),
          child: CachedNetworkImage(
            imageUrl: _mediaUrl!,
            errorWidget: (context, url, error) => Icon(Icons.error, color: Colors.black26),
            fit: BoxFit.cover,
            cacheKey: _mediaUrl,
          ),
        );

      case MediaType.video :

        if (enumFromString(SnsType.values, flatform) == SnsType.youtube || item.url!.contains("youtu")) {

          String videoId = (item.url!.startsWith("https://youtu.be")) ? item.url!.split("/")[3] : item.url!.split('=')[1];

          return YoutubePlayer (
            controller: Get.find<FeedsDetailController>().getYoutubePlayerController (videoId : videoId),
            showVideoProgressIndicator: true,
            progressColors: ProgressBarColors (
              playedColor: Colors.blue,
              handleColor: Colors.blueAccent,
            ),
            // onReady () {
            //   _controller.addListener(listener);
            // },
          );

        } else if (item.storage_url == null || item.storage_url!.isEmpty) { //주소가 없는건 거르자...
          return _commonError;
        } else {

          String? _mediaUrl = (item.storage_url!.startsWith("http")) ? item.storage_url : Constants.CDN_URL + item.storage_url!;

          //vlc 비디오 플레이어
          return Container (
            child: VlcPlayer(
              controller: Get.find<FeedsDetailController>().getVlcVideoPlayerController(videoURL : _mediaUrl),
              aspectRatio: 16 / 9,
              placeholder: Center(child: CircularProgressIndicator()),
            ),
            color: Colors.black,
          );


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

    // customLogger.d("비율 --> $_asp ------> ${controller.currentMedia.height} / ${controller.currentMedia.width}");
    return _asp;
  }

  @override
  Widget build(BuildContext context) {

    return GetBuilder<FeedsDetailController> (
      init: FeedsDetailController (),
      builder:(controller) =>
      controller.data!.article_medias!.length > 1 ?
      Obx (() {
        return Container (
            child: Column (
                children: [
                  CarouselSlider(
                    options: CarouselOptions(
                        aspectRatio: 1 / _getContentProp(controller),
                        viewportFraction : 1,
                        onPageChanged: (index, reason) {
                          controller.mediaCarouselCurrent.value = index;
                        }
                    ),
                    carouselController: controller.mediaCarouselController,
                    items: controller.data!.article_medias!.map((item) => Container(
                      width: Get.width,
                      child: _getMediaItemView (item as ArticleMediaItemDto, controller.data!.platform!),
                    )).toList(),
                  ),

                  Container (
                    width: Get.width,
                    alignment: Alignment.center,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: controller.data!.article_medias!.asMap().entries.map((entry) {
                        return GestureDetector(
                          onTap: () => controller.mediaCarouselController!.animateToPage(entry.key),
                          child: Container(
                            width: 10.0,
                            height: 2.0,
                            margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
                            decoration: BoxDecoration(
                                shape: BoxShape.rectangle,
                                borderRadius: BorderRadius.all(Radius.circular(1)),
                                color: Colors.black.withOpacity(controller.mediaCarouselCurrent.value == entry.key ? 1.0 : 0.2)),
                          ),
                        );
                      }).toList(),
                    ),
                  )
                ])
        );
      })
          : controller.data!.article_medias!.length == 0 ?
      Container (

      )
          :
      Container (
        child: _getMediaItemView(controller.currentMedia as ArticleMediaItemDto, controller.data!.platform!),
      )

      ,
    );
  }

}