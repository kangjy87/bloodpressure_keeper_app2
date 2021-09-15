import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:bloodpressure_keeper_app/ui/pages/feed/config/config.dart';
import 'package:bloodpressure_keeper_app/ui/pages/feed/FeedsDetailController.dart';
import 'package:bloodpressure_keeper_app/ui/pages/feed/utils/GeneralUtils.dart';
import 'package:bloodpressure_keeper_app/ui/pages/feed/utils/logger_utils.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class TdiYouTubePlayer extends StatefulWidget {

  String? videoId;

  TdiYouTubePlayer ({
    this.videoId
  });

  @override
  _TdiYouTubePlayerState createState() => _TdiYouTubePlayerState();
}

class _TdiYouTubePlayerState extends State<TdiYouTubePlayer> {

  /// for youtube ---------------------------------------------------------------
  late YoutubePlayerController _youtubePlayerController;

  late PlayerState _playerState;
  late YoutubeMetaData _videoMetaData;
  double _volume = 100;
  bool _muted = false;
  bool _isPlayerReady = false;
  ///----------------------------------------------------------------------------


  @override
  void initState () {
    super.initState();

    _youtubePlayerController = YoutubePlayerController (
      initialVideoId: widget.videoId!,
      flags: YoutubePlayerFlags(
        autoPlay: true,
        mute: false,
        enableCaption: false,
        disableDragSeek : true,
        loop: true,
        hideControls: true,
        hideThumbnail: true,
      ),
    )..addListener(() {
      setState(() {
        _playerState = _youtubePlayerController.value.playerState;
        _videoMetaData = _youtubePlayerController.metadata;
        _isPlayerReady = true;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    _youtubePlayerController.dispose();
  }

  ///-------------------------------------------------------------------
  Widget get _space => const SizedBox(height: 10);
  Widget _text(String title, String value) {
    return RichText(
      text: TextSpan(
        text: '$title : ',
        style: const TextStyle(
          color: Colors.blueAccent,
          fontWeight: FontWeight.bold,
        ),
        children: [
          TextSpan(
            text: value,
            style: const TextStyle(
              color: Colors.blueAccent,
              fontWeight: FontWeight.w300,
            ),
          ),
        ],
      ),
    );
  }
  ///-------------------------------------------------------------------

  @override
  Widget build(BuildContext context) {

    FeedsDetailController controller = Get.find<FeedsDetailController>();
    double _progress = _isPlayerReady ? (_youtubePlayerController.value.position.inMilliseconds / _videoMetaData.duration.inMilliseconds) * Get.width : 0.0;

    return InkWell(
      child: Stack (
        children: [

          YoutubePlayer (
            controller: _youtubePlayerController,
            width: Get.width,
            showVideoProgressIndicator: true,
            aspectRatio: controller.orientation.value == Orientation.portrait ? 1 / 1 : Get.width / Get.height,
            progressColors: ProgressBarColors (
              playedColor: Colors.red,
              handleColor: Colors.redAccent,
            ),
            onEnded: (YoutubeMetaData metaData) {
              setState(() {
                //noting yet;
              });
            },
          ),


          if (controller.orientation.value == Orientation.portrait || (_isPlayerReady && _playerState == PlayerState.paused))
            Positioned(
              bottom: 0,
              child: Container(
                child: Stack(
                  children: [
                    Container (
                      width: Get.width,
                      height: getUiSize (2),
                      color: Colors.grey,
                    ),

                    if (_isPlayerReady && _progress > 0)
                      Container (
                        width: _progress,
                        height: getUiSize (2),
                        color: Colors.red,
                      )
                  ],
                ),
              ),
            ),

          _isPlayerReady && _playerState == PlayerState.paused
              ? Center (
            child: Image.asset(AppIcons.ic_video_play),
          )
              : Center ()

        ],
      ),
      onTap: () {
        setState(() {
          if (_youtubePlayerController.value.isPlaying) {
            _youtubePlayerController.pause();
          } else {
            _youtubePlayerController.play();
          }
        });
      },
    );
  }

}