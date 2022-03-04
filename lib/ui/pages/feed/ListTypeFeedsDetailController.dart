import 'package:bloodpressure_keeper_app/model/users_dto.dart';
import 'package:bloodpressure_keeper_app/ui/pages/feed/dtos/LikesDto.dart';
import 'package:bloodpressure_keeper_app/ui/pages/feed/utils/ContentsUtil.dart';
import 'package:bloodpressure_keeper_app/ui/pages/feed/utils/DioClient.dart';
import 'package:bloodpressure_keeper_app/ui/routes/app_routes.dart';
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
import 'package:bloodpressure_keeper_app/ui/pages/feed/utils/logger_utils.dart';
import 'package:share_plus/share_plus.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'ListTypeFeedsDetail.dart';
import 'apis/FeedsClient.dart';
import 'common/videos/TdiOrientationController.dart';
import 'dtos/FeedsDetailDto.dart';
import 'dtos/FeedsListDto.dart';
import 'dtos/MediaInfo.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:bloodpressure_keeper_app/ui/pages/feed/utils/SharedPrefUtil.dart';
import 'package:bloodpressure_keeper_app/ui/pages/feed/dtos/FavoritesDto.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'feed_controller.dart';
import 'feed_main_controller.dart';
import 'items/MediaItemView.dart';

class ListTypeFeedsDetailController extends TdiOrientationController {
  late MediaItemView mediaItemView ;
  final FeedsClient feedsClient = FeedsClient(DioClient.dio);

  final _data = FeedsItemDto ().obs;
  FeedsItemDto get data => _data.value;
  set data (FeedsItemDto t) => _data.value = t;
  CarouselController? mediaCarouselController;
  final RxInt mediaCarouselCurrent = 0.obs;
  var strNaverBlogUrl = "".obs ;

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
  //////피드 리스트
  final List<FeedsItemDto> list = <FeedsItemDto>[].obs;
  int clickPosition = 0;

  int page = 0;
  int per_page = 50;
  bool listEnd = false;
  bool isLoading = false;
  FeedsListDto? feedData;
  ScrollController scrollController = ScrollController();
  String keyword = "" ;

  RxBool onBackCheck = false.obs;
  var platform = ''.obs ;
  // var webViewHeight = double.infinity.obs ;
  var webViewHeight = Get.height.obs ;
  @override
  void onInit () async {
    print('힛 여기루 탐 ㅋㅋ!!!!!!!!!!!!!!!!${Get.height}!!!!!!!!!!!!!!!!!!!!sssssss!');
    super.onInit();
    ////////유저 아이디 받아오기
    usersInfo = await getUserInfo();
    reSearch = false ;
    //어디서 넘어온 화면인지 출처 확인
    // if(Get.parameters['page'] != null){
    //   feedPageCheck = Get.parameters['page'] == 'FeedPage' ? true : false ;
    // }
    mediaCarouselController = CarouselController();
    if(Get.parameters['page'] != null && Get.parameters['page'] == 'FeedDetailPage'){
      print('걸려듬????????????????????????');
      FeedsItemDto getData = Get.arguments as FeedsItemDto;
      platform.value = getData.platform! ;
      if(getData.platform == 'naver-blog'){
        strNaverBlogUrl.value = getData.url! ;
      }
      data = await getFeedDetail ('${getData.id}');
      feedPageCheck = true ;
    }
    else if(Get.parameters['page'] != null && Get.parameters['page'] == 'FavoritePage'){
      FeedsItemDto getData = Get.arguments as FeedsItemDto;
      platform.value = getData.platform! ;
      if(getData.platform == 'naver-blog'){
        strNaverBlogUrl.value = getData.url! ;
      }
      data = await getFeedDetail ('${getData.id}');
      feedPageCheck = false;
    }
    else if (Get.arguments.runtimeType == FeedsItemDto) {
      FeedsItemDto getData = Get.arguments as FeedsItemDto;
      platform.value = getData.platform! ;
      if(getData.platform == 'naver-blog'){
        strNaverBlogUrl.value = getData.url! ;
      }
      data = await getFeedDetail ('${getData.id}');
    } else if (Get.arguments.runtimeType == String) {
      data = await getFeedDetail (Get.arguments);
    }
    //////////////////////////////////////////////////////
    //즐겨찾기가 널일경우 무조건 트루로(마이페이지> 즐겨찾기 리스트에서 널로 나온다)
    if(data.is_favorite == null){
      data.is_favorite = true ;
    }
    isFavorite.value = data.is_favorite! ;
    isLike.value = data.is_like! ;
    likeCount.value = data.article_detail == null ? 0 : data.article_detail!.like!;

    //피드리스트
    list.clear();
    page = 1;
    listEnd = false;
    getFeeds();
    scrollController.addListener(() {
      try {
        double _remainDistance = scrollController.position.maxScrollExtent - scrollController.offset;
        if (_remainDistance <= Get.height * 3 &&

            ///--> 스크린 크기의 몇배의 스크롤 높이가 남으면 로드할거냐????
            !scrollController.position.outOfRange) {
          //다음페이지 로드
          if (!listEnd && !isLoading) {
            page += 1;
            getFeeds();
          }
        }

      } catch (error) {
        //nothing yet;
      }
    });
  }

  @override
  void onClose () {
    super.onClose();
    if(EasyLoading != null){
      EasyLoading.dismiss();
    }
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
  Future<FeedsItemDto> getFeedDetail (String articleId) async {
    FeedsItemDto _result = FeedsItemDto();
    if(EasyLoading != null){
      EasyLoading.show();
    }
    // await Future.delayed(Duration (milliseconds: 2000)); //--> 객체 생성 까지 0.5초 대기
    await feedsClient.getFeedDetail (articleId,usersInfo.id, SharedPrefKey.C9_KEY).then((FeedsDetailDto result) {
      if(EasyLoading != null){
        EasyLoading.dismiss();
      }
      _result = result.data as FeedsItemDto;
      platform.value = _result.platform! ;
      if(_result.platform == 'naver-blog'){
        strNaverBlogUrl.value = _result.url! ;
      };
      print('?!@#!@#!@#!@#!@#!@#!@#!@#!@#!!!!!!!!!!!!!!!!');
      update();
    }).onError((DioError error, stackTrace) {
      if(EasyLoading != null){
        EasyLoading.dismiss();
      }
      print('?!@#!@#!@#!@#!@#!@#!@#!@#!@#ㅎㅎㅎㅎㅎㅎㅎㅎㅎㅎㅎㅎㅎㅎㅎ');
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
  void setFavorites(bool group_id_check, int group_id,Function fucresult) async {
    reSearch = false ;
    if(usersInfo.id == null){
      await getUserInfo();
    }
    FavoritesDto favorites = FavoritesDto();
    favorites.media_id = 1 ;
    favorites.user_id =  '${usersInfo.id}' ;
    favorites.article_id = data.id ;
    if(group_id_check){
      favorites.group_id = group_id ;
    }
    final client = FeedsClient(DioClient.dio);
    await client.setFavorite(SharedPrefKey.C9_KEY,favorites
    ).then((result) {
      isFavorite.value = !data.is_favorite! ;
      data.is_favorite =  isFavorite.value ;
      //피드면 리스트에서 즐겨찾기 상태값을 리스트로 보내고 즐겨찾기는 걍 재조회를 시켜버린다.
      if(feedPageCheck){
        FeedController listController = Get.find<FeedController>();
        listController.list[listController.clickPosition] = data ;
      }else{
        reSearch = true ;
      }
      update ();
      fucresult();

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
/**
 * 피드 리스트
 */
  Future<void> getFeeds () async {

    isLoading = true;
    final client = FeedsClient(DioClient.dio);
    await client.getFeeds(
        1 /** 1 ~ 3 */, page, per_page, SharedPrefKey.C9_KEY,'','',usersInfo.id
    ).then((result) {
      feedData = result;
      //가라 데이타 ---------------------------------------------------------
      // list.add(fakeMe);
      //가라 데이타 ---------------------------------------------------------
      list.addAllIf(feedData!.data!.articles!.length > 0, feedData!.data!.articles!);
      print('>>>>>>>>>>>피피피피드드드드리리리리스스스스트트ㅡ틑ㅌ>>>>>>>${list.length}');
      if (feedData!.data!.articles!.length < per_page) {
        listEnd = true;
      }

      isLoading = false;

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
      isLoading = false;
    });

  }
  void detailPageGo(int index)async{
    clickPosition = index;
    if(Get.find<FeedController>().youtubePlayerController!= null){
      Get.find<FeedController>().youtubePlayerController!.pause();
      print('>>>>>>>xkxkxk??????');
      // mediaItemView.youTubePlayerStop();
    }
    Get.put(ListTypeFeedsDetailController(),tag:'${list[index].id}');
    Get.toNamed('${AppRoutes.ListTypeFeedDetailPage}/value?page=FeedDetailPage', arguments: list[index],preventDuplicates: false)!.then((value){
    }); /** 상세페이지로!! */
  }
}
class ListTypeFeedsDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ListTypeFeedsDetailController>(() => ListTypeFeedsDetailController());
  }
}
