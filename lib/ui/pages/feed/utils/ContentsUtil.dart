import 'package:get/get.dart';
import 'package:bloodpressure_keeper_app/ui/pages/feed/config/config.dart';
import 'package:bloodpressure_keeper_app/ui/pages/feed/config/enums.dart';
import 'package:bloodpressure_keeper_app/ui/pages/feed/dtos/FeedsItemDto.dart';
import 'package:bloodpressure_keeper_app/ui/pages/feed/dtos/MediaInfo.dart';
import 'package:bloodpressure_keeper_app/ui/pages/feed/utils/logger_utils.dart';

class ContentsUtil {


  /** 표시될 이미지 주소 파싱 */
  static MediaInfo getFeedsThumbNailInfo (FeedsItemDto targetItem) {
    MediaInfo _mediaInfo = MediaInfo();


    _mediaInfo.width = (Get.width - (Constants.feed_tab_horizontal_padding * 2)) * 0.5;
    _mediaInfo.height = _mediaInfo.width;

    ///무조건 storage_thumbnail_url 쓰기로 협의 됨.
    /* if (targetItem.storage_thumbnail_url != null && targetItem.storage_thumbnail_url!.isNotEmpty) {
      _mediaInfo.url = targetItem.storage_thumbnail_url!.startsWith('http') ? targetItem.storage_thumbnail_url : Constants.CDN_URL + targetItem.storage_thumbnail_url!;
      _mediaInfo.height = targetItem.thumbnail_height!.toDouble() * (_mediaInfo.width! / targetItem.thumbnail_width!.toDouble());
    } else if (targetItem.thumbnail_url != null && targetItem.thumbnail_url!.isNotEmpty) {
      _mediaInfo.url = targetItem.thumbnail_url;
      _mediaInfo.height = targetItem.thumbnail_height!.toDouble() * (_mediaInfo.width! / targetItem.thumbnail_width!.toDouble());
    } else if (targetItem.article_medias!.length > 0) {
      _mediaInfo.url = Constants.CDN_URL + targetItem.article_medias!.first.storage_url!;
      _mediaInfo.height = targetItem.article_medias!.first.height!.toDouble() * (_mediaInfo.width! / targetItem.article_medias!.first.width!.toDouble());
    } else {
      //TODO : 이미지 없음 주소 바꿀것....
      _mediaInfo.url = "https://usagi-post.com/wp-content/uploads/2020/05/no-image-found-360x250-1.png";
    }*/

    _mediaInfo.url = targetItem.storage_thumbnail_url != null && targetItem.storage_thumbnail_url!.isNotEmpty
        ? Constants.CDN_URL + targetItem.storage_thumbnail_url!
        : "";
    if (targetItem.thumbnail_width == null || targetItem.thumbnail_height == null) {

      switch (enumFromString(PlatformType.values, targetItem.platform!)) {

        case PlatformType.instagram :
          _mediaInfo.height = _mediaInfo.height = _mediaInfo.width;
          break;
        case PlatformType.googlenews :
          _mediaInfo.height = _mediaInfo.height = _mediaInfo.width;
          break;
        case PlatformType.youtube :
        ///유튜브는 별도로 가로세로 비율을 고정해달라는 요청
          _mediaInfo.height = _mediaInfo.width! * (3/4);
          break;

        default :
          _mediaInfo.height = _mediaInfo.width! * 1.414;

      }
    } else {
      _mediaInfo.height = _mediaInfo.height = targetItem.thumbnail_height!.toDouble() * (_mediaInfo.width! / targetItem.thumbnail_width!.toDouble());
    }

    _mediaInfo.type = MediaPlayType.image_show;

    return _mediaInfo;
  }


  /** 상세화면에 표시될 미디어 정보 */
  static MediaInfo getFeedDetailMediaInfo (ArticleMediaItemDto targetItem, PlatformType platform) {
    MediaInfo _mediaInfo = MediaInfo();
    MediaType mType = enumFromString(MediaType.values, targetItem.type!);

    if (mType == MediaType.image) {

      _mediaInfo.url =  targetItem.storage_url != null && targetItem.storage_url!.isNotEmpty
          ? Constants.CDN_URL + targetItem.storage_url!
          : "";
      _mediaInfo.type = MediaPlayType.image_show;

    } else if (mType == MediaType.video && targetItem.url!.contains("youtu")) { //--> video youtube

      _mediaInfo.url = (targetItem.url!.startsWith("https://youtu.be")) ? targetItem.url!.split("/")[3] : targetItem.url!.split('=')[1];
      _mediaInfo.type = MediaPlayType.video_youtube;

    } else if (mType == MediaType.video) { //--> video mp4

      _mediaInfo.url = (targetItem.url!.startsWith("http")) ? targetItem.url : (targetItem.url!.isNotEmpty) ? Constants.CDN_URL + targetItem.url! :
      (targetItem.storage_url!.startsWith("http")) ? targetItem.storage_url : Constants.CDN_URL + targetItem.storage_url!;
      _mediaInfo.type = MediaPlayType.video_mp4;

    }  else {
      //not yet;
    }
    //가로, 세로 NULL들어올거에 대한 처리
    if(targetItem.width != null){
      _mediaInfo.width = targetItem.width!.toDouble();
    }else{
      _mediaInfo.width = 1080;
    }
    if(targetItem.height != null){
      _mediaInfo.height = targetItem.height!.toDouble();
    }else{
      _mediaInfo.height = 1080;
    }

    return _mediaInfo;
  }

}