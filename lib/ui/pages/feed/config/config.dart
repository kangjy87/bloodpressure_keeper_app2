import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:bloodpressure_keeper_app/ui/pages/feed/utils/GeneralUtils.dart';
import 'package:bloodpressure_keeper_app/ui/pages/feed/dtos/FeedsItemDto.dart';

class RouteNames {

  static const String SPLASH = "/splash";
  static const String LOGIN = "/account/login";
  static const String USER_AGREEMENTS = "/account/user_agreement";
  static const String JOIN_FORM = "/account/join_form";
  static const String HOME = "/home";
  static const String FEEDS_DETAIL = "/feeds/detail";
  static const String WEBVIEW = "/utils/webview";

}

class Font {
  static const TmonMonsori = "TmonMonsori";
  static const NotoSansCJKkrBold = "NotoSansCJKkrBold";
  static const NotoSansCJKkrRegular = "NotoSansCJKkrRegular";
}


class AppIcons {
  static const ICON_PATH = "images/";
  static const ic_insta = ICON_PATH + "045-instagram.svg";
  static const ic_music = ICON_PATH + "057-music.svg";
  static const ic_weather = ICON_PATH + "006-weather.svg";
  static const ic_market = ICON_PATH + "023-market.svg";

  static const logo_apple = ICON_PATH + "logo_apple.svg";
  static const logo_google = ICON_PATH + "logo_google.svg";
  static const logo_kakao = ICON_PATH + "logo_kakao.svg";

  static const ic_logo= ICON_PATH + "logo_icon.png";
  static const ic_video_play = ICON_PATH + "play_icon_1.png";
  static const ic_heart = ICON_PATH + "heart_icon_1.png";
  static const ic_heart_on = ICON_PATH + "heart_icon_1_on.png";
  static const ic_heart2 = ICON_PATH + "ic_heart2.png";
  static const book_makr_off = ICON_PATH + "book_makr_off.png";
  static const book_makr_on = ICON_PATH + "book_makr_on.png";
  static const share_icon = ICON_PATH + "share_icon.png";

  /** for tabs **/
  static const ic_tab_home = ICON_PATH + "home_icon.svg";
  static const ic_tab_ticketing = ICON_PATH + "ticketing_icon.svg";
  static const ic_tab_feed = ICON_PATH + "feed_icon.svg";
  static const ic_tab_clip = ICON_PATH + "clip_icon.svg";

  /** for topper icons */
  static const ic_event = ICON_PATH + "event_icon.svg";
  static const ic_event_white = ICON_PATH + "event_icon_white.svg";
  static const ic_mypage = ICON_PATH + "mypage_icon.svg";
  static const ic_mypage_white = ICON_PATH + "mypage_icon_white.svg";
  static const ic_notice = ICON_PATH + "notice_icon.svg";
  static const ic_notice_white = ICON_PATH + "notice_icon_white.svg";

  /** for common things */
  static final IconData icondata_back = Platform.isIOS ? Icons.arrow_back_ios : Icons.arrow_back;
  static const ic_back = ICON_PATH + "back_btn.svg";
  static const ic_feed_popup_btn = ICON_PATH + "feed_popup_btn.svg";
  static final ic_selected = ICON_PATH + "select_icon.svg";
  static final ic_checked = ICON_PATH + "check_icon.svg";

  static final ic_search = ICON_PATH + "search_icon.svg";
  static final ic_x = ICON_PATH + "x_btn.svg";
}


//이미지 객체
class ImageDto {

  String? url;
  int? width;
  int? height;

  ImageDto ({
    this.url,
    this.width,
    this.height
  });

}

//테스트용 가라데이타 ----------------------------------------------------------
FeedsItemDto skeletonData = FeedsItemDto(
  id: 333,
  media_id: 999,
  platform: " ",
  type: " ",
  keyword: " ",
  channel: null,
  article_owner_id: " ",
  url : " ",
  title : " ",
  contents : " ",
  storage_thumbnail_url : Images.SampleImages[0].url,
  thumbnail_url : Images.SampleImages[0].url,
  thumbnail_width : Images.SampleImages[0].width,
  thumbnail_height : Images.SampleImages[0].height,
  hashtag : "",
  state : 1,
  date : DateTime.now(),
  article_owner: ArticleOwnerDto (
      name: " ",
      storage_thumbnail_url : null,
      thumbnail_url: null

  ),
);
FeedsItemDto fakeMe = FeedsItemDto(
    id: 333,
    media_id: 999,
    platform: "instagram",
    type: "keyword",
    keyword: "골프",
    channel: null,
    article_owner_id: "3226487621",
    url : "https://www.instagram.com/p/CR5z8iuNz_U",
    title : " ",
    contents : " ",
    storage_thumbnail_url : Images.SampleImages[0].url,
    thumbnail_url : Images.SampleImages[0].url,
    thumbnail_width : Images.SampleImages[0].width,
    thumbnail_height : 800,
    // thumbnail_height : Images.SampleImages[0].height,
    hashtag : "",
    state : 1,
    date : DateTime.now(),
    article_owner: ArticleOwnerDto (
        name: " ",
        storage_thumbnail_url : null,
        thumbnail_url: null

    ),
    article_medias : [
      ArticleMediaItemDto(
          id : 0,
          article_id : 34876,
          type: "image",
          storage_url: Images.SampleImages[0].url,
          url: "",
          width: Images.SampleImages[0].width,
          height : Images.SampleImages[0].height
      ),
      ArticleMediaItemDto(
          id : 0,
          article_id : 34877,
          type: "image",
          storage_url: Images.SampleImages[1].url,
          url: "",
          width: Images.SampleImages[1].width,
          height : Images.SampleImages[1].height
      ),
      ArticleMediaItemDto(
          id : 0,
          article_id : 34879,
          type: "image",
          storage_url: Images.SampleImages[2].url,
          url: "",
          width: Images.SampleImages[2].width,
          height : Images.SampleImages[2].height
      ),
      ArticleMediaItemDto(
          id : 0,
          article_id : 34880,
          type: "image",
          storage_url: Images.SampleImages[3].url,
          url: "",
          width: Images.SampleImages[3].width,
          height : Images.SampleImages[3].height
      ),
      ArticleMediaItemDto(
          id : 100023,
          article_id : 543535435435,
          type: "video",
          storage_url: null,
          url: "https://www.youtube.com/watch?v=PgCVzcF-Exk",
          width: 1920,
          height : 1080
      ),
      ArticleMediaItemDto(
          id : 0,
          article_id : 34877,
          type: "image",
          storage_url: Images.SampleImages[4].url,
          url: "",
          width: Images.SampleImages[4].width,
          height : Images.SampleImages[4].height
      ),
      ArticleMediaItemDto(
          id : 0,
          article_id : 34881,
          type: "image",
          storage_url: Images.SampleImages[5].url,
          url: "",
          width: Images.SampleImages[5].width,
          height : Images.SampleImages[5].height
      ),
      ArticleMediaItemDto(
          id : 0,
          article_id : 34882,
          type: "video",
          storage_url: null,
          url: "https://thumbs.gfycat.com/FoolhardyMiserlyAsiantrumpetfish-mobile.mp4",
          width: 1920,
          height : 1080
      ),
      ArticleMediaItemDto(
          id : 0,
          article_id : 34883,
          type: "image",
          storage_url: Images.SampleImages[6].url,
          url: "",
          width: Images.SampleImages[6].width,
          height : Images.SampleImages[6].height
      ),
      ArticleMediaItemDto(
          id : 0,
          article_id : 34894,
          type: "video",
          storage_url: "",
          url: "https://youtu.be/cxYjZE4EtdE",
          width: 1920,
          height : 1080
      ),
      ArticleMediaItemDto(
          id : 1111111111111,
          article_id : 348829989,
          type: "video",
          storage_url: null,
          url: "https://va.media.tumblr.com/tumblr_o600t8hzf51qcbnq0_480.mp4",
          width: 1920,
          height : 1080
      )
    ]
);

class Images {
  static const IMG_PATH = "images/";
  static const img_placeholder = IMG_PATH + "placeholder.png";

  static const img_ic_band = IMG_PATH + "band.png";
  static const img_ic_fbook = IMG_PATH + "fbook.png";
  static const img_ic_google = IMG_PATH + "google.png";
  static const img_ic_insta = IMG_PATH + "insta.png";
  static const img_ic_kstory = IMG_PATH + "kstory.png";
  static const img_ic_nband = IMG_PATH + "nband.png";
  static const img_ic_nblog = IMG_PATH + "nblog.png";
  static const img_ic_tstory = IMG_PATH + "tstory.png";
  static const img_ic_tweeter = IMG_PATH + "tweeter.png";
  static const img_ic_youtube = IMG_PATH + "youtube.png";
  static const img_no_profile = IMG_PATH + "no_profile.png";
  static const img_no_thumbnail = IMG_PATH + "no_thumbnail.png";

  /** 아래는 깨진 이미지들 때문에 사용한 임시 이미지들... 삭제예정 */
  static List<ImageDto> SampleImages = [

    ImageDto(
        url: "https://images-na.ssl-images-amazon.com/images/S/pv-target-images/c24f81b95634562bfa6380091887e738f7bdb211af8761e73afaf463a0015d15._RI_V_TTW_.jpg",
        width: 1200,
        height: 1600
    ),
    ImageDto(
        url: "https://fever.imgix.net/plan/photo/7bba64dc-5552-11e9-b555-064931504376.jpg?w=550&h=550&auto=format&fm=jpg",
        width: 550,
        height: 550
    ),
    ImageDto(
        url: "http://tkfile.yes24.com/upload2/PerfBlog/202104/20210401/20210401-38766.jpg",
        width: 430,
        height: 602
    ),
    ImageDto(
        url: "https://cdnticket.melon.co.kr/resource/image/upload/marketing/2021/07/202107050922497f93ecca-30dd-44f3-a207-31f95f830958.jpg",
        width: 420,
        height: 594
    ),
    ImageDto(
        url: "https://d28erbnojfkip4.cloudfront.net/content/uploads/2021/05/TLK-TWIO-3000x1418-NoButton-scaled.jpg",
        width: 2560,
        height: 1263
    ),
    ImageDto(
        url: "https://theprommusical.com/wp-content/uploads/2020/12/PROM-mobile-website-image-Coming-Soon.jpg",
        width: 640,
        height: 1045
    ),
    ImageDto(
        url: "https://file.themusical.co.kr/fileStorage/ThemusicalAdmin/Play/Image/201702011101001N8L2KP311I07112.jpg",
        width: 419,
        height: 600
    )

  ];


  static int rotateNum = 0;
  static ImageDto getSampleImagesForFeed () {
    rotateNum = (rotateNum < SampleImages.length - 1) ? rotateNum + 1 : 0;
    return SampleImages[rotateNum];
  }
}

class Constants {

  static const String androidApplicationId = "com.appkeeper.bloodpressure_keeper_app";
  static const String appleBundleId = "com.appkeeper.bloodpressure_keeper_app";
  static const String deeplink_prefix_domain = "https://bloodpressurekeeperapp.page.link";
  // static const String Q_API_BASE_URL = "https://dev.api.curator9.com";
  static const String Q_API_BASE_URL = "https://api.curator9.com";
  static const String API_BASE_URL = 'https://dev.tt.tdi9.com';
  // static const String CDN_URL = "https://chuncheon.blob.core.windows.net/chuncheon/";
  static const String CDN_URL = "https://c9bloodpressure.azureedge.net/";

  static final general_horizontal_padding = getUiSize(15);
  static final narrow_horizontal_padding = getUiSize(20);

  static final feed_tab_horizontal_padding = getUiSize(10.0);

  /** 이용약관 및 개인정보 처리 방침 URL */
  static const terms_of_use_url = "https://blog.evnet.kr/755";
  static const privacy_policy_url = "https://blog.evnet.kr/739";


}