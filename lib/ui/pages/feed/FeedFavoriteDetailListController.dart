
import 'package:bloodpressure_keeper_app/model/users_dto.dart';
import 'package:bloodpressure_keeper_app/ui/pages/feed/utils/DioClient.dart';
import 'package:bloodpressure_keeper_app/ui/routes/app_routes.dart';
import 'package:bloodpressure_keeper_app/utils/shared_preferences_info/login_info.dart';
import 'package:dio/dio.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/bindings_interface.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'ListTypeFeedsDetailController.dart';
import 'apis/FeedsClient.dart';
import 'common/BaseScaffoldController.dart';
import 'dtos/FeedsItemDto.dart';
import 'package:bloodpressure_keeper_app/ui/pages/feed/utils/SharedPrefUtil.dart';

import 'dtos/FeedsListDto.dart';

class FeedFavoriteDetailListController extends GetxController{

  final refreshKey = GlobalKey<RefreshIndicatorState>();
  UsersDto usersInfo = UsersDto();
  FavoriteListDto? data;
  final List<FavoriteItemDto> list = <FavoriteItemDto>[].obs;
  int clickPosition = 0;
  int page = 0;
  int per_page = 50;
  bool listEnd = false;
  bool isLoading = false;

  RxBool snsInstar = true.obs, snsYoutube = true.obs, snsNaver = true.obs ;

  ScrollController scrollController = ScrollController();

  final RxBool nestedScrollable = false.obs;

  String group_id = "" ;
  var title = "소식".obs;
  @override
  void onInit() {
    group_id = Get.arguments["group_id"];
    title.value = Get.arguments["title"];
    list.clear();
    getInfo();
    page = 1;
    listEnd = false;
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
  void detailPageGo(int index)async{
    Get.put(ListTypeFeedsDetailController(),tag:'${list[index].article?.id!}');
    clickPosition = index;
    list[index].article!.is_like = list[index].is_like ;
    Get.toNamed('${AppRoutes.ListTypeFeedDetailPage}/value?page=FavoritePage', arguments: list[index].article,preventDuplicates : false)!.then((value){
      if(value){
        refreshFeeds(false);
      }
    }); /** 상세페이지로!! */
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

  void getInfo() async {
    usersInfo = await getUserInfo();
    getFeeds ();
  }

  Future<void> getFeeds () async {

    isLoading = true;
    final client = FeedsClient(DioClient.dio);
    await client.getFavoritesGroupDetailList(
        SharedPrefKey.C9_KEY, page, per_page,group_id,'y',1,'${usersInfo.id}'
    ).then((result) {
      data = result;
      // strDataZeroMsg.value = (data == null || data!.data!.favorites!.length == 0) ? '등록된 즐겨찾기가 없습니다.' : '' ;

      list.addAllIf(data!.data!.favorites!.length > 0, data!.data!.favorites!);

      if (data!.data!.favorites!.length < per_page) {
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
}
class FeedFavoriteDetailListBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FeedFavoriteDetailListController>(() => FeedFavoriteDetailListController());
  }
}
