import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:bloodpressure_keeper_app/ui/pages/feed/config/config.dart';
import 'package:bloodpressure_keeper_app/ui/pages/feed/FeedsDetailController.dart';
import 'package:bloodpressure_keeper_app/ui/pages/feed/utils/GeneralUtils.dart';
import 'package:bloodpressure_keeper_app/ui/pages/feed/utils/logger_utils.dart';
import 'package:video_player/video_player.dart';

class TdiVidePlayer extends StatefulWidget {

  String? videoUrl;

  TdiVidePlayer ({
    this.videoUrl
  });

  @override
  _TdiVideoPlayerState createState () => _TdiVideoPlayerState ();
}


class _TdiVideoPlayerState extends State<TdiVidePlayer> {


  late VideoPlayerController _controller;
  double _progress = 0;


  @override
  void initState () {
    super.initState();

    _controller = VideoPlayerController.network(widget.videoUrl!)
      ..initialize().then((_) {
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
        setState(() {
          customLogger.d ("준비완료!!");
          _controller.play();
        });
      })..setLooping(true)..addListener(() {
        setState(() {
          _progress = (_controller.value.position.inMilliseconds.toDouble() / _controller.value.duration.inMilliseconds.toDouble()) * Get.width;
        });
      });
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {

    FeedsDetailController controller = Get.find<FeedsDetailController>();

    return InkWell(
      child: Stack(
        children: [

          Center(
            child: AspectRatio(
              aspectRatio: _controller.value.aspectRatio,
              child: VideoPlayer(_controller),
            ),
          ),

          if (controller.orientation.value == Orientation.portrait || !_controller.value.isPlaying)
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
                    Container (
                      width: _progress,
                      height: getUiSize (2),
                      color: Colors.red,
                    )
                  ],
                ),
              ),
            ),

          !_controller.value.isPlaying
              ? Center (
            child: Image.asset(AppIcons.ic_video_play),
          )
              : Center ()

        ],
      ),
      onTap: () {
        if (_controller.value.isPlaying) {
          _controller.pause();
        } else {
          _controller.play();
        }
      },
    );
  }

}