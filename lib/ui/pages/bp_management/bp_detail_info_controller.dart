import 'package:bloodpressure_keeper_app/model/blood_pressure_item.dart';
import 'package:bloodpressure_keeper_app/model/bloodpressure_dto.dart';
import 'package:bloodpressure_keeper_app/model/users_dto.dart';
import 'package:bloodpressure_keeper_app/retrofit/blood_pressure_server.dart';
import 'package:bloodpressure_keeper_app/retrofit/tdi_servers.dart';
import 'package:bloodpressure_keeper_app/utils/blood_pressure_local_db.dart';
import 'package:bloodpressure_keeper_app/utils/shared_preferences_info/get_client_credentials_grant.dart';
import 'package:bloodpressure_keeper_app/utils/shared_preferences_info/login_info.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:bloodpressure_keeper_app/utils/weather_util.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class BpDetailInfoController extends GetxController {
  TextEditingController resultSys = TextEditingController() ;
  TextEditingController resultDia = TextEditingController() ;
  FocusNode focusDia = FocusNode();
  TextEditingController resultPul = TextEditingController() ;
  FocusNode focusPul = FocusNode();
  TextEditingController resultMemo = TextEditingController();
  FocusNode focusMemo = FocusNode();
  BloodPressureDto data = BloodPressureDto();
  String weatherImg = "" ;
  late String appKey = '';

  @override
  void onInit() {
    super.onInit();
     resultSys = TextEditingController() ;
     resultDia = TextEditingController() ;
     focusDia = FocusNode();
     resultPul = TextEditingController() ;
     focusPul = FocusNode();
     resultMemo = TextEditingController();
     focusMemo = FocusNode();
     data = BloodPressureDto();
    dataSetting();
  }

  dataSetting(){
    data = Get.arguments;
    print('!!1231231231231231231231231!!!!!!!!!!!!${data.id}!!!>>>>>>>>>>>>>>${data.memo}');
    resultSys.text = "${data.systolic}" ;
    resultDia.text = "${data.diastolic}";
    resultPul.text = "${data.heart}";
    resultMemo.text = data.memo == null ? "" : "${data.memo}" ;
    if(data.weather != null && data.weather != null){
      weatherImg = WeatherUtil.getWeatherImageFromWeatherStr(data.weather!);
    }
    update();
  }

  bool saveCheck(){
    if(resultSys.text == ''){
      Fluttertoast.showToast(
          msg: "수축기 혈압을 입력해주세요.",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Color(0xff454f63),
          textColor: Colors.white,
          fontSize: 16.0
      );
      return false ;
    }
    if(resultDia.text == ""){
      Fluttertoast.showToast(
          msg: "이완기 혈압을 입력해주세요.",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Color(0xff454f63),
          textColor: Colors.white,
          fontSize: 16.0
      );
      return false ;
    }
    if(resultPul.text == ""){
      Fluttertoast.showToast(
          msg: "심박수을 입력해주세요.",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Color(0xff454f63),
          textColor: Colors.white,
          fontSize: 16.0
      );
      return false ;
    }
    if(int.parse(resultSys.text) > 250){
      Fluttertoast.showToast(
          msg: "수축기 혈압이 비정상적 입니다.",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Color(0xff454f63),
          textColor: Colors.white,
          fontSize: 16.0
      );
      return false ;
    }
    if(int.parse(resultDia.text) > 250){
      Fluttertoast.showToast(
          msg: "이완기 혈압이 비정상적 입니다.",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Color(0xff454f63),
          textColor: Colors.white,
          fontSize: 16.0
      );
      return false ;
    }
    if(int.parse(resultPul.text) > 250){
      Fluttertoast.showToast(
          msg: "심박수가 비정상적 입니다.",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Color(0xff454f63),
          textColor: Colors.white,
          fontSize: 16.0
      );
      return false ;
    }
    return true ;
  }

  Future<void> localDbInsert(Function saved)async {
    if(saveCheck()){
      data.systolic = int.parse(resultSys.text) ;
      data.diastolic = int.parse(resultDia.text);
      data.heart = int.parse(resultPul.text);
      data.memo = resultMemo.text ;
      update();

      // BloodPressureLocalDB db = BloodPressureLocalDB();
      // db.database ;
      // await db.selectMemoUpset(data).then((value){
      //   saved.call();
      // });
    }
  }

  Future<void> serverDbInsert(Function saved, Function err)async {
    appKey = await getUserAccessToken();
    if(saveCheck()){
      // BloodPressureDto savedata = BloodPressureDto();
      data.systolic = int.parse(resultSys.text) ;
      data.diastolic = int.parse(resultDia.text);
      data.heart = int.parse(resultPul.text);
      data.memo = resultMemo.text ;
      TdiServers(bloodPressureServer: (BloodPressureServer bps) async {
        await bps.BloodPressureUpdate(appKey, '${data.id}',data).then((value){
        // await bps.BloodPressureUpdate(appKey, '${data.id}',data.systolic!, data.diastolic!,data.heart!,data.memo!).then((value){
          EasyLoading.dismiss();
          print('저장된값>>>>>>>>>>>>>>>>>>>>>>>>>${value.result}');
          print('저장된값>>>>>>>>>>>>>>>>>>>>>>>>>${value.data!.user_id}');
          // if(resp.user_id != null){
          saved.call();
          // }
        }).catchError((Object obj) async {
          print('에러된값>>>>>>>>>>>>>>>>>>>>>>>>>${obj}');
          EasyLoading.dismiss();
          err();
          switch (obj.runtimeType) {
            case DioError:
              final res = (obj as DioError).response;
              update();
              break;
            default:
            //nothing yet;
          }
        });
      });

    }
  }
}