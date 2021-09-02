import 'package:bloodpressure_keeper_app/model/feeds/FeedsItemDto.dart';
import 'package:carousel_slider/carousel_controller.dart';
import 'package:flutter_vlc_player/flutter_vlc_player.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';


class FeedsDetailController extends GetxController {

  FeedsItemDto? data;
  YoutubePlayerController? _youtubePlayerController;
  VlcPlayerController? _vlcPlayerController;
  VideoPlayerController? _videoPlayerController;

  CarouselController? mediaCarouselController;
  final RxInt mediaCarouselCurrent = 0.obs;


  //현재 미디어 반환
  ArticleMediaItemDto get currentMedia => data!.article_medias![mediaCarouselCurrent.value];


  @override
  void onInit () {
    super.onInit();

    mediaCarouselController = CarouselController();
    data = Get.arguments as FeedsItemDto;
  }

  //유튜브 플레이어 초기화 및 컨트롤러 반환
  YoutubePlayerController getYoutubePlayerController ({String? videoId}) {
    if (_youtubePlayerController == null) _youtubePlayerController = YoutubePlayerController(
      initialVideoId: videoId!,
      flags: YoutubePlayerFlags(
        autoPlay: true,
        mute: true,
      ),
    );

    return _youtubePlayerController!;
  }

  //vlc 플레이어 콘트롤러 초기화 및 컨트롤러 반환
  VlcPlayerController getVlcVideoPlayerController ({String? videoURL}) {


    if (_vlcPlayerController == null) {
      // customLogger.d("재생해 --> $videoURL");
      _vlcPlayerController = VlcPlayerController.network(
        videoURL!,
        hwAcc: HwAcc.FULL,
        autoPlay: true,
        options: VlcPlayerOptions(),
        autoInitialize: true
      );
    }

    return _vlcPlayerController!;

  }


  //플루터 비디오 플레이어 컨트롤러 초기화 및 반환
  VideoPlayerController getVideoPlayerController ({String? videoURL}) {

    if (_videoPlayerController == null) {
      _videoPlayerController = VideoPlayerController.network(
        videoURL!,
        videoPlayerOptions: VideoPlayerOptions(mixWithOthers: true),
      );

      _videoPlayerController!.addListener(() {
        update();
      });
      _videoPlayerController!.setLooping(true);
      _videoPlayerController!.initialize().then((_) => () {
        update();
      });
      _videoPlayerController!.play();
    }

    return _videoPlayerController!;

  }
}