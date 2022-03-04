
import 'package:bloodpressure_keeper_app/model/users_dto.dart';
import 'package:bloodpressure_keeper_app/ui/routes/app_routes.dart';
import 'package:bloodpressure_keeper_app/utils/shared_preferences_info/login_info.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:bloodpressure_keeper_app/ui/pages/feed/apis/FeedsClient.dart';
import 'package:bloodpressure_keeper_app/ui/pages/feed/dtos/FeedsItemDto.dart';
import 'package:bloodpressure_keeper_app/ui/pages/feed/dtos/FeedsListDto.dart';
import 'package:bloodpressure_keeper_app/ui/pages/feed/utils/DioClient.dart';
import 'package:bloodpressure_keeper_app/ui/pages/feed/utils/SharedPrefUtil.dart';
import 'package:bloodpressure_keeper_app/ui/pages/feed/common/BaseScaffoldController.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'ListTypeFeedsDetailController.dart';
import 'config/config.dart';
import 'dtos/FeedsKeywordsDto.dart';

class TestAFeedController extends GetxController {

  FeedsListDto? data;
  final List<FeedsItemDto> list = <FeedsItemDto>[].obs;
  // final Map<int,List<KeywordsDto>> getKeywordList = <int,List<KeywordsDto>>{}.obs;
  int clickPosition = 0;

  int page = 0;
  int per_page = 30;
  bool listEnd = false;
  bool isLoading = false;

  final RxBool snsInstar = true.obs, snsYoutube = true.obs, snsNaver = true.obs, snsGoogleNew = true.obs ;
  set snsInstarCheck (bool value) => snsInstar.value = value;
  bool get snsInstarCheck => snsInstar.value;

  set snsYoutubeCheck (bool value) => snsYoutube.value = value;
  bool get snsYoutubeCheck => snsYoutube.value;

  set snsNaverCheck (bool value) => snsNaver.value = value;
  bool get snsNaverCheck => snsNaver.value;

  set snsGoogleNewCheck (bool value) => snsGoogleNew.value = value;
  bool get snsGoogleNewCheck => snsGoogleNew.value;

  ScrollController scrollController = ScrollController();

  final RxBool nestedScrollable = false.obs;

  /** 검색어 및 플랫폼 선택을 위해 */
  final FocusNode searchFocusNode = FocusNode ();
  final TextEditingController searchController = TextEditingController();
  String? platform;
  String? keyword;

  final refreshKey = GlobalKey<RefreshIndicatorState>();

  UsersDto usersInfo = UsersDto();

  YoutubePlayerController? youtubePlayerController ;

  var checkTest1 = true.obs,checkTest2 = true.obs,checkTest3 = true.obs ;

  @override
  void onInit () {
    super.onInit();
    list.clear();
    getInfo();
    page = 1;
    listEnd = false;
    scrollController.addListener(() {
      try {
        double _remainDistance = scrollController.position.maxScrollExtent - scrollController.offset;
        print('>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>${_remainDistance}');
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

    //데이타 로드
    snsCheck();
  }
  keywordList()async{
    final client = FeedsClient(DioClient.dio);
    await client.getKeywordsList(SharedPrefKey.C9_KEY, 1,"random", page,4).then((value) async {
      // getKeywordList.clear();
      FeedsKeywordsListDto getData = value ;
      // print('왜뒤짐???????????>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>${getData.data!.keywords!}');
      // getKeywordList[(121212121212+page)]= getData.data!.keywords!;
      // print('왜뒤짐???????????>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>${getKeywordList[(121212121212+page)]}');
      list.add(FeedsItemDto(
          id: (121212121212+page),
          media_id: 121212121212,
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
          article_medias : await getKeyWord(getData.data!.keywords)));
    });
  }
  List<ArticleMediaItemDto>? getKeyWord(List<KeywordsDto>? keywords){
    List<ArticleMediaItemDto> returnData = [];
    for(int i = 0 ; i < keywords!.length; i++){
      returnData.add(ArticleMediaItemDto(
          id : 0,
          article_id : 34876,
          type: "image",
          storage_url: keywords[i].keyword,
          url: "",
          width: Images.SampleImages[0].width,
          height : Images.SampleImages[0].height
      ));
    }
    return returnData ;
  }
  void detailPageGo(int index)async{
    clickPosition = index;
    /** 상세페이지로!! */
    Get.put(ListTypeFeedsDetailController(),tag:'${list[index].id}');
    Get.toNamed('${AppRoutes.ListTypeFeedDetailPage}/value?page=FeedPage', arguments: list[index],preventDuplicates : false)!.then((value){

    });
  }
  void getInfo() async {
    usersInfo = await getUserInfo();
    print('!!!!!!!!!!!유저아이디>>>>>>>>>>>${usersInfo.id}');
  }
  snsCheckSync()async{
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    snsInstarCheck  = (_prefs.getBool('snsInstar') == null ? true  : _prefs.getBool('snsInstar'))! ;
    snsYoutubeCheck = (_prefs.getBool('snsYoutube') == null ? true  : _prefs.getBool('snsYoutube'))! ;
    snsNaverCheck = (_prefs.getBool('snsNaver') == null ? true  : _prefs.getBool('snsNaver'))! ;
    snsGoogleNewCheck = (_prefs.getBool('snsGoogleNews') == null ? true  : _prefs.getBool('snsGoogleNews'))! ;
  }
  snsCheck()async{
    if(platform == null || platform == ''){
      SharedPreferences _prefs = await SharedPreferences.getInstance();
      snsInstarCheck  = (_prefs.getBool('snsInstar') == null ? true  : _prefs.getBool('snsInstar'))! ;
      snsYoutubeCheck = (_prefs.getBool('snsYoutube') == null ? true  : _prefs.getBool('snsYoutube'))! ;
      snsNaverCheck = (_prefs.getBool('snsNaver') == null ? true  : _prefs.getBool('snsNaver'))! ;
      snsGoogleNewCheck = (_prefs.getBool('snsGoogleNews') == null ? true  : _prefs.getBool('snsGoogleNews'))! ;
      StringBuffer strPlatform = StringBuffer();
      if(snsInstarCheck){
        strPlatform.write('#instagram');
      }
      if(snsYoutubeCheck){
        strPlatform.write('#youtube');
      }
      if(snsNaverCheck){
        strPlatform.write('#naver-blog');
      }
      if(snsGoogleNewCheck){
        strPlatform.write('#google-news');
      }
      platform = strPlatform.toString();
    }
    getFeeds ();
  }


  snsCheckedSetting()async{
    platform = "" ;
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    _prefs.setBool('snsInstar', snsInstarCheck ? true : false) ;
    _prefs.setBool('snsYoutube', snsYoutubeCheck ? true : false) ;
    _prefs.setBool('snsNaver', snsNaverCheck ? true : false) ;
    _prefs.setBool('snsGoogleNews', snsGoogleNewCheck ? true : false) ;//'#google-news'
    StringBuffer strPlatform = StringBuffer();
    if(snsInstarCheck){
      strPlatform.write('#instagram');
    }
    if(snsYoutubeCheck){
      strPlatform.write('#youtube');
    }
    if(snsNaverCheck){
      strPlatform.write('#naver-blog');
    }
    if(snsGoogleNewCheck){
      strPlatform.write('#google-news');
    }
    platform = strPlatform.toString();
    refreshFeeds(false);
    Get.back();
  }

  snsCheckedSetting2(int intPlatfor)async{
    switch(intPlatfor){
      case 0 :
        platform = '#instagram' ;
        break ;
      case 1:
        platform = '#youtube' ;
        break ;
      case 2:
        platform = '#naver-blog' ;
        break ;
      case 3:
        platform = '#google-news' ;
        break ;
      case 4:
        platform = '' ;
        break ;
    }
    refreshFeeds(false);
    Get.back();
  }

  Future<void> getFeeds () async {
    isLoading = true;
    final client = FeedsClient(DioClient.dio);
    await client.getFeeds(
      // 1 /** 1 ~ 3 */, page, per_page, SharedPrefKey.C9_KEY,('#google-news'),keyword,usersInfo.id
        1 /** 1 ~ 3 */, page, per_page, SharedPrefKey.C9_KEY,(platform),keyword,usersInfo.id
    ).then((result) {
      data = result;
      //가라 데이타 ---------------------------------------------------------
      //  list.add(fakeMe);
      //가라 데이타 ---------------------------------------------------------
      print('먹겅>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>${data!.data!.articles!.length > 0}');
      list.addAllIf(data!.data!.articles!.length > 0, data!.data!.articles!);
      if(list.length > 1){
        keywordList();
      }
      if (data!.data!.articles!.length < per_page) {
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

  //새로 고침
  Future<void> refreshFeeds (bool withIndicator) async {
    if (withIndicator) refreshKey.currentState!.show (atTop: true);
    else Get.find<BaseScaffoldController>().isLoading = true;
    list.clear();
    page = 1;
    listEnd = false;
    await getFeeds ();
    Get.find<BaseScaffoldController>().isLoading = false;
  }

  /** 검색어 리스트 로드 */
  Future<void> getSearchKeywords () async {
    // contents_client.getSearchKeywords ().then((SearchKeywordsResponseDto result) {
    //
    //   keywords.addAll (result.data!);
    //   List<String> tmp = result.message!.split("#");
    //   for (String itm in tmp) {
    //     if (itm.isNotEmpty) tagItems!.add(TagItemDto(word: itm));
    //   }
    //
    // }).onError((DioError error, stackTrace) {
    //   //nothing yet;
    // });
  }

  /** 검색 */
  void searchFeeds (String? keyword) {
    this.keyword = keyword != null ? "#$keyword" : null;
    searchController.text = keyword ?? "";
    refreshFeeds(false);
  }

  /** 맨위로 올라가세요!! */
  void scrollToTop () {
    scrollController.animateTo(0, duration: Duration (milliseconds: 500), curve: Curves.easeOut);
  }
}