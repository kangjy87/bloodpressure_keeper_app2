import 'package:bloodpressure_keeper_app/model/users_dto.dart';
import 'package:bloodpressure_keeper_app/ui/pages/feed/utils/DioClient.dart';
import 'package:bloodpressure_keeper_app/ui/pages/feed/utils/SharedPrefUtil.dart';
import 'package:bloodpressure_keeper_app/utils/shared_preferences_info/login_info.dart';
import 'package:dio/dio.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:flutter/material.dart';
import 'FeedListPage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'ListTypeFeedsDetail.dart';
import 'ListTypeFeedsDetailController.dart';
import 'apis/FeedsClient.dart';
import 'dtos/FeedsItemDto.dart';
import 'dtos/FeedsListDto.dart';

class FeedMainController extends GetxController {
  ///////////////////////////////////////////////////////
  bool mainCheck = false ;
  final detailCheckInfo = RxList<FeedsItemDto>([]).obs ;
  final pageList = RxList<Widget>([]).obs ;
  PageController pageController = PageController(
    initialPage: 0,
  );
  ///////////////////////////////////////////////////////
  final refreshKey = GlobalKey<RefreshIndicatorState>();
  final RxBool snsInstar = true.obs, snsYoutube = true.obs, snsNaver = true.obs ;
  set snsInstarCheck (bool value) => snsInstar.value = value;
  bool get snsInstarCheck => snsInstar.value;

  set snsYoutubeCheck (bool value) => snsYoutube.value = value;
  bool get snsYoutubeCheck => snsYoutube.value;

  set snsNaverCheck (bool value) => snsNaver.value = value;
  bool get snsNaverCheck => snsNaver.value;
  String? platform;
  String? keyword;
  final List<FeedsItemDto> mainFeedlist = <FeedsItemDto>[].obs;
  int clickPosition = 0;
  int mainFeedPage = 0;
  int per_page = 50;
  bool mainFeedlistEnd = false;
  bool mainFeedIsLoading = false;
  ScrollController mainFeedScrollController = ScrollController();
  final FocusNode searchFocusNode = FocusNode ();
  final TextEditingController searchController = TextEditingController();
  FeedsListDto? mainFeeddata;
  UsersDto usersInfo = UsersDto();
  ///////////////////////////////////////////////////////
  @override
  void onInit() {
    super.onInit();
    Get.lazyPut(()=>ListTypeFeedsDetailController());
    pageList.value.add(FeedListPage());
  }
  onback(){
    pageList.value.removeLast();
    pageController.animateToPage((pageList.value.length-1), duration: Duration(milliseconds: 300), curve: Curves.ease);
  }
  //////////////////////////////////////////////////////피드리스트
  snsCheckSync()async{
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    snsInstarCheck  = (_prefs.getBool('snsInstar') == null ? true  : _prefs.getBool('snsInstar'))! ;
    snsYoutubeCheck = (_prefs.getBool('snsYoutube') == null ? true  : _prefs.getBool('snsYoutube'))! ;
    snsNaverCheck = (_prefs.getBool('snsNaver') == null ? true  : _prefs.getBool('snsNaver'))! ;
  }
  snsCheckedSetting()async{
    platform = "" ;
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    _prefs.setBool('snsInstar', snsInstarCheck ? true : false) ;
    _prefs.setBool('snsYoutube', snsYoutubeCheck ? true : false) ;
    _prefs.setBool('snsNaver', snsNaverCheck ? true : false) ;
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
    platform = strPlatform.toString();
    refreshFeeds(false);
    Get.back();
  }

  //새로 고침
  Future<void> refreshFeeds (bool withIndicator) async {
    if (withIndicator) refreshKey.currentState!.show (atTop: true);
    // else Get.find<BaseScaffoldController>().isLoading = true;
    mainFeedlist.clear();
    mainFeedPage = 1;
    mainFeedlistEnd = false;
    await getFeeds ();
    // Get.find<BaseScaffoldController>().isLoading = false;
  }
  /** 검색 */
  void searchFeeds (String? keyword) {
    this.keyword = keyword != null ? "#$keyword" : null;
    searchController.text = keyword ?? "";
    refreshFeeds(false);
  }
  void detailPageGo(int index)async{
    mainCheck = true ;
    pageList.value.add(ListTypeFeedsDetail());
    pageController.animateToPage((pageList.value.length-1), duration: Duration(milliseconds: 300), curve: Curves.ease);
    clickPosition = index;
    /** 상세페이지로!! */
    // Get.toNamed('${AppRoutes.ListTypeFeedDetailPage}/value?page=FeedPage', arguments: list[index])!.then((value){
    //
    // });
  }
  void mainFeedinitList()async{
    mainCheck = false ;
    detailCheckInfo.value.clear();
      //SNS 필터
      if(platform == null || platform == ''){
        SharedPreferences _prefs = await SharedPreferences.getInstance();
        snsInstarCheck  = (_prefs.getBool('snsInstar') == null ? true  : _prefs.getBool('snsInstar'))! ;
        snsYoutubeCheck = (_prefs.getBool('snsYoutube') == null ? true  : _prefs.getBool('snsYoutube'))! ;
        snsNaverCheck = (_prefs.getBool('snsNaver') == null ? true  : _prefs.getBool('snsNaver'))! ;
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
        platform = strPlatform.toString();
      }
      //로그인 계정
      usersInfo = await getUserInfo();
      mainFeedlist.clear();
      mainFeedPage = 1;
      mainFeedlistEnd = false;
      getFeeds();
      mainFeedScrollController.addListener(() {
        try {
          double _remainDistance = mainFeedScrollController.position.maxScrollExtent - mainFeedScrollController.offset;
          if (_remainDistance <= Get.height * 3 &&
              ///--> 스크린 크기의 몇배의 스크롤 높이가 남으면 로드할거냐????
              !mainFeedScrollController.position.outOfRange) {
            //다음페이지 로드
            if (!mainFeedlistEnd && !mainFeedIsLoading) {
              mainFeedPage += 1;
              getFeeds();
            }
          }

        } catch (error) {
          //nothing yet;
        }
      });
  }

  Future<void> getFeeds () async {
    mainFeedIsLoading = true;
    final client = FeedsClient(DioClient.dio);
    await client.getFeeds(
        1 /** 1 ~ 3 */, mainFeedPage, per_page, SharedPrefKey.C9_KEY,platform,keyword,usersInfo.id
    ).then((result) {
      mainFeeddata = result;
      mainFeedlist.addAllIf(mainFeeddata!.data!.articles!.length > 0, mainFeeddata!.data!.articles!);

      if (mainFeeddata!.data!.articles!.length < per_page) {
        mainFeedlistEnd = true;
      }
      mainFeedIsLoading = false;
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
      mainFeedIsLoading = false;
    });

  }
}