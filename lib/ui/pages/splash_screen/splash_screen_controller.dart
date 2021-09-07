import 'dart:async';
import 'dart:io';
import 'package:bloodpressure_keeper_app/model/users_dto.dart';
import 'package:bloodpressure_keeper_app/ui/pages/dashboard/dashboard_page.dart';
import 'package:bloodpressure_keeper_app/ui/pages/feed/DioClient.dart';
import 'package:bloodpressure_keeper_app/ui/pages/feed/FeedsClient.dart';
import 'package:bloodpressure_keeper_app/ui/pages/feed/feed_dtos/AuthErrorDto.dart';
import 'package:bloodpressure_keeper_app/ui/pages/feed/feed_dtos/AuthRequestBody.dart';
import 'package:bloodpressure_keeper_app/ui/pages/feed/feed_dtos/AuthTokenDto.dart';
import 'package:bloodpressure_keeper_app/ui/pages/login/sns_login/login_page.dart';
import 'package:bloodpressure_keeper_app/utils/shared_preferences_info/login_info.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:bloodpressure_keeper_app/ui/routes/app_routes.dart';
import 'package:flutter/cupertino.dart';
import 'package:bloodpressure_keeper_app/utils/shared_preferences_info/get_client_credentials_grant.dart';
import 'package:bloodpressure_keeper_app/retrofit/blood_pressure_server.dart';
import 'package:bloodpressure_keeper_app/model/client_credentials_grant_dto.dart';
import 'package:bloodpressure_keeper_app/utils/shared_preferences_info/get_client_credentials_grant.dart';
import 'package:bloodpressure_keeper_app/retrofit/tdi_servers.dart';
import 'package:bloodpressure_keeper_app/ui/utils/msg_alert_dialog/onebutton_alert.dart';

class SplashScreenController extends GetxController {
  final String title = '스플';
  bool check1 = false ;
  bool check2 = false ;
  @override
  void onInit() {
    super.onInit();
    clinetCredentialsGrant();
    feedAuthToken (); /// -- KEVIN 추가
  }

  /**
   * countTimer 시간동안 화면을 기둘해준다.
   */
  startSplash(BuildContext context)async{
    int countTimer = 2;
    int exitCountTimer = 10;
    bool onesCheck = false ;
    const oneSec = const Duration(seconds: 1);
    Timer.periodic(oneSec, (timer) async{
      print('작동됨????????????????${countTimer}');
      exitCountTimer -- ;
      if (countTimer != 0) {
        countTimer--;
      } else {
        if(!onesCheck){
          onesCheck = true ;
          if(check1 == true && check2 == true){
            timer.cancel();
            UsersDto usersDto = await getUserInfo();
            print('>>>>>>>>>>>>>>>>로그인정보>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>${usersDto.nickname}');
            // Get.offAll(((usersDto.nickname == null || usersDto.nickname == "") ? LoginPage() : DashboardPage()),transition: Transition.rightToLeft);
            Get.offAllNamed((usersDto.nickname == null || usersDto.nickname == "" ? AppRoutes.LOGIN : AppRoutes.DASHBOARD));
            // Get.to(AppRoutes.LOGIN,transition: )
          }
        }else{
          if(check1 == true && check2 == true){
            onesCheck = false ;
          }else if(exitCountTimer == 0){
            oneButtonAlert(
                context,
                "에러",
                "서버와 통신이 원활하지 않습니다.",
                "종", () {
              Navigator.pop(context);
              exit(0);
            });
          }
        }
      }
    });
  }

  /**
   * TDI 서버에서 키발급
   */
  clinetCredentialsGrant() {
    TdiServers(bloodPressureServer: (BloodPressureServer bps) async {
      SetClientCredentialsGrantDto task = SetClientCredentialsGrantDto();
      task.grant_type = "client_credentials";
      task.client_id = "92f46b2d-f9cf-4457-b861-65a54bbfa59d";
      task.client_secret = "l8fdn0eKZ0R6u2smAU4aGiDCCrqjTje92U6eLqad";
      task.scope = "";
      final resp = await bps.clientCredentialsGrant(task);
      setClientCredentiaksGrant(resp.access_token, () {
        check1 = true ;
        print('저장된값!!>>>>>>>>>>>>>>>>>>>>>>>>>${resp.access_token}');
      });
    });
  }

  /**
   * KEVIN 추가분 ------------------------------------------------------------------------------------
   */
  //데이타 로드
  Future<void> feedAuthToken () async {
    final client = FeedsClient(DioClient.dio);
    await client.postToken(AuthRequestBody()).then((result) {
      AuthTokenDto data = result;
      // SharedPrefUtil.setString(SharedPrefKey.CURATOR9_TOKEN, data.getToken());
      setFeedCredentiaksGrant(data.access_token, () {
        print('저장된값!!>>>>>>>>>>>>>>>>>>>>>>>>>${data.access_token}');
        check2 = true ;
      });

    }).catchError((Object obj) async {
      // non-200 error goes here.
      switch (obj.runtimeType) {
        case DioError:
          final res = (obj as DioError).response;

          AuthErrorDto errorDto = AuthErrorDto.fromJson(res?.data);
          // customLogger.e ("error --> ${errorDto.message}");
          //에러 핸들링 해야합니다.

          break;
        default:
      }
    });
  }
///----------------------------------------------------------------------------------------------------
}
