import 'package:bloodpressure_keeper_app/model/feed_favorite_groups_add_dto.dart';
import 'package:bloodpressure_keeper_app/model/get_favorite_groups_dto.dart';
import 'package:bloodpressure_keeper_app/model/set_add_favorite_groups.dart';
import 'package:bloodpressure_keeper_app/model/users_dto.dart';
import 'package:bloodpressure_keeper_app/ui/pages/feed/utils/DioClient.dart';
import 'package:bloodpressure_keeper_app/utils/shared_preferences_info/login_info.dart';
import 'package:dio/dio.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/bindings_interface.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:bloodpressure_keeper_app/ui/pages/feed/utils/SharedPrefUtil.dart';
import 'apis/FeedsClient.dart';
import 'package:flutter/material.dart';

class FeedFavoriteController extends GetxController{
  UsersDto usersInfo = UsersDto();
  List<FavoriteGroups>? favoriteGroups  = <FavoriteGroups>[].obs ;
  final favoriteAddController = TextEditingController();
  @override
  void onInit() {
    getfavoriteGroups();
  }
  getfavoriteGroups()async{
    usersInfo = await getUserInfo();
    final client = FeedsClient(DioClient.dio);
    await client.getFavoriteGroups(SharedPrefKey.C9_KEY, 1, '${usersInfo.id}', 1, 10, "").then((value){
      GetFavoriteGroup list  = value ;
      favoriteGroups?.clear();
      if(list != null && list.data != null && list.data!.favoriteGroups != null){
        favoriteGroups!.addAll(list.data!.favoriteGroups!);
      }
    });
  }
  addFavoriteGroups(String strGroup,Function result)async{
    usersInfo = await getUserInfo();
    final client = FeedsClient(DioClient.dio);
    SetAddFavoriteGroups data = SetAddFavoriteGroups();
    data.media_id = 1 ;
    data.user_id = '${usersInfo.id!}' ;
    data.group = strGroup ;
    await client.addFavoriteGroups(SharedPrefKey.C9_KEY,data).then((value){
      FeedFavoriteGroupsAddDto list  = value ;
      result(list.statusCode);
    }).catchError((Object obj) async {
      // non-200 error goes here.
      switch (obj.runtimeType) {
        case DioError:
          final res = (obj as DioError).response;
          result(res?.statusCode);
          update();
          break;
        default:
        //nothing yet;
      }
    });
  }
}
class FeedFavoriteBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FeedFavoriteController>(() => FeedFavoriteController());
  }
}
