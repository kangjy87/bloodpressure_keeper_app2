
import 'dart:collection';

import 'package:bloodpressure_keeper_app/model/users_dto.dart';
import 'package:bloodpressure_keeper_app/ui/pages/feed/dtos/LikesDto.dart';
import 'package:bloodpressure_keeper_app/ui/pages/feed/utils/ContentsUtil.dart';
import 'package:bloodpressure_keeper_app/ui/pages/feed/utils/DioClient.dart';
import 'package:bloodpressure_keeper_app/utils/shared_preferences_info/login_info.dart';
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
import 'package:bloodpressure_keeper_app/ui/pages/feed/utils/SharedPrefUtil.dart';
import 'package:bloodpressure_keeper_app/ui/pages/feed/dtos/FavoritesDto.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'favorite_controller.dart';
import 'feed_controller.dart';

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


  UsersDto usersInfo = UsersDto();
  RxBool isFavorite = false.obs;
  RxBool isLike = false.obs;
  RxInt likeCount  = 0.obs ;
  bool feedPageCheck = true ; //피드페이지먼 true 마이즐겨찾기페이지면 false

  bool reSearch = false ;
  @override
  void onInit () async {
    super.onInit();
    getInfo();
    reSearch = false ;
    if(Get.parameters['page'] != null){
      feedPageCheck = Get.parameters['page'] == 'FeedPage' ? true : false ;
    }
    print('>>>>>>>>>>>>>>>>>오제발${Get.parameters['page']}');
    mediaCarouselController = CarouselController();

    customLogger.d("또 갈까? --> ${Get.arguments}");

    if (Get.arguments.runtimeType == FeedsItemDto) {
      data = Get.arguments as FeedsItemDto;
    } else if (Get.arguments.runtimeType == String) {
      data = await getFeedDetail ();
    }
    print('>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>${data.title}');
    print('>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>${data.contents}');
    //즐겨찾기가 널일경우 무조건 트루로(마이페이지> 즐겨찾기 리스트에서 널로 나온다)
    if(data.is_favorite == null){
      data.is_favorite = true ;
    }
    isFavorite.value = data.is_favorite! ;
    isLike.value = data.is_like! ;
    likeCount.value = data.article_detail == null ? 0 : data.article_detail!.like!;
  }

  @override
  void onClose () {
    super.onClose();
  }

  void getInfo() async {
    usersInfo = await getUserInfo();
  }

  /** for share */
  Future<void> shareMe ()async {

    // Get.find<BaseScaffoldController>().isLoading = true;
    print ("미리보기 이미지 : ");
    MediaInfo _mediaInfo = ContentsUtil.getFeedsThumbNailInfo(data);
    print ("미리보기 이미지 : ${_mediaInfo.url!}");
    print ("id : ${data.id}");

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
    if(EasyLoading != null){
      EasyLoading.show();
    }
    // await Future.delayed(Duration (milliseconds: 2000)); //--> 객체 생성 까지 0.5초 대기
    await feedsClient.getFeedDetail (Get.arguments,usersInfo.id, SharedPrefKey.C9_KEY).then((FeedsDetailDto result) {
      if(EasyLoading != null){
        EasyLoading.dismiss();
      }
      _result = result.data as FeedsItemDto;
      update();
    }).onError((DioError error, stackTrace) {
      // EasyLoading.dismiss();
    });

    return _result;
  }


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

  //즐겨찾기
  void setFavorites() async {
    reSearch = false ;
    FavoritesDto favorites = FavoritesDto();
    favorites.media_id = 1 ;
    favorites.user_id =  '${usersInfo.id}' ;
    favorites.article_id = data.id ;
    final client = FeedsClient(DioClient.dio);
    await client.setFavorite(
        SharedPrefUtil.getString(SharedPrefKey.CURATOR9_TOKEN), SharedPrefKey.C9_KEY,favorites
    ).then((result) {
      isFavorite.value = !data.is_favorite! ;
      data.is_favorite =  isFavorite.value ;
      if(feedPageCheck){
        FeedController listController = Get.find<FeedController>();
        listController.list[listController.clickPosition] = data ;
      }else{
        reSearch = true ;
      }

      Fluttertoast.showToast(
          msg: isFavorite.value ? '즐겨찾기가 추가되었습니다.':'즐겨찾기가 해제되었습니다.',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Color(0xff454f63),
          textColor: Colors.white,
          fontSize: 16.0
      );
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
    });

  }

  //좋아요
  Future<void> setLikes () async {
    LikesDto likes = LikesDto();
    likes.media_id = 1 ;
    likes.user_id = '${usersInfo.id}' ;
    likes.article_id = data.id ;
    likes.behavior_type = data.is_like == false ? 'like' : 'like' ;
    final client = FeedsClient(DioClient.dio);
    var returnServerData = await client.setLike(
        '${data.id}',
        likes.behavior_type!,
        SharedPrefUtil.getString(SharedPrefKey.CURATOR9_TOKEN),
        SharedPrefKey.C9_KEY,
        likes
    ).then((result) {
      data.is_like = !data.is_like! ;
      isLike.value = data.is_like! ;
      LikesResultDto returnData = result ;
      int intlikeCount = returnData.data!.like! ;
      likeCount.value = intlikeCount ;
      if(data.article_detail == null){
        data.article_detail = ArticleDetail();
      }
      data.article_detail!.like =  intlikeCount ;
      update ();
      if(feedPageCheck){
        FeedController listController = Get.find<FeedController>();
        listController.list[listController.clickPosition] = data ;
      }else{
        reSearch = true ;
        // FavoriteController listController = Get.find<FavoriteController>();
        // listController.list[listController.clickPosition].article = data ;
      }
    }).catchError((Object obj) async {
      // non-200 error goes here.
      switch (obj.runtimeType) {
        case DioError:
          print('>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>.에러잔슴');
          final res = (obj as DioError).response;
          update();
          break;
        default:
        //nothing yet;
      }
    });
  }
}