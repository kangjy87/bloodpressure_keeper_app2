import 'package:bloodpressure_keeper_app/model/bloodpressure_dto.dart';
import 'package:bloodpressure_keeper_app/model/client_credentials_grant_dto.dart';
import 'package:bloodpressure_keeper_app/retrofit/blood_pressure_server.dart';
import 'package:bloodpressure_keeper_app/retrofit/tdi_servers.dart';
import 'package:bloodpressure_keeper_app/utils/day_util.dart';
import 'package:bloodpressure_keeper_app/utils/shared_preferences_info/get_client_credentials_grant.dart';
import 'package:bloodpressure_keeper_app/utils/shared_preferences_info/last_weather_info.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:bloodpressure_keeper_app/ui/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:bloodpressure_keeper_app/utils/blood_pressure_local_db.dart';
import 'package:bloodpressure_keeper_app/model/blood_pressure_item.dart';
import 'package:intl/intl.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class SelfBpInputController extends GetxController {
  final String title = '혈압입력';
  late String appKey = '';
  void loginPage(){
    Get.toNamed(AppRoutes.LOGIN);
  }
  late  PageController pageControllers = PageController() ;
  DateTime selectedDay = DateTime.now();
  DateTime focusedDay = DateTime.now();


  //날짜 선택시
  void changeSelectedDay(DateTime sDay,DateTime fDay){
    selectedDay = sDay ;
    focusedDay = fDay ;
    update();
  }

  //요일 바꿀시
  void changeFocusedDay(DateTime fDay){
    focusedDay = fDay ;
    int difference = int.parse(focusedDay.difference(selectedDay).inDays.toString());
    print('>>>>>두날짜간 차>>>>>>>>>>>>>>>>>>>>>>>>>>>>>.${difference}');
    if(!(difference > 0 && difference <=6)){
      selectedDay = fDay ;
    }
    update();
  }

  TextEditingController resultSys = TextEditingController() ;
  TextEditingController resultDia = TextEditingController() ;
  FocusNode focusDia = FocusNode();
  TextEditingController resultPul = TextEditingController() ;
  FocusNode focusPul = FocusNode();
  TextEditingController resultMemo = TextEditingController();
  FocusNode focusMemo = FocusNode();

  @override
  void onInit() {
    super.onInit();
    beforeBloodPressure();
  }

  void beforeBloodPressure()async{
    GetClientCredentialsGrantDto gcDto = await getClientCredentiaksGrant();
    appKey = "Bearer ${gcDto.access_token}" ;
    //혈압관리에서선택한 날짜 화면 표시
    selectedDay = Get.arguments['date'];
    int todayIndex = Get.arguments['todayIndex'];
    focusedDay = getFocusedDay(todayIndex,selectedDay);

    // focusedDay = Get.arguments['date'];
    // BloodPressureLocalDB db = BloodPressureLocalDB();
    // db.database ;
    // BloodPressureItem? data = await db.getLastBPData();
    // resultSys.text = data!.systolic == null ? '' : dacvta!.systolic.toString() ;
    // resultDia.text = data!.diastole == null ? '' : data!.diastole.toString() ;
    // resultPul.text = data!.pulse == null ? '' : data!.pulse.toString() ;
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
      String? weatherImg ;
      String? weatherTemp ;
      String? weatherInfo ;
      print('${DateFormat('yyyy-MM-dd').format(DateTime.now())}>>>>>>>>>>${DateFormat('yyyy-MM-dd').format(selectedDay)}>>>>>>>>>>>>날짜 비교 >>>>>>>${DateFormat('yyyy-MM-dd').format(DateTime.now()) == DateFormat('yyyy-MM-dd').format(selectedDay)}');
      if(DateFormat('yyyy-MM-dd').format(DateTime.now()) == DateFormat('yyyy-MM-dd').format(selectedDay)){
        weatherImg = await getWeatherImg();
        weatherTemp = await getWeatherTemp();
        weatherInfo = await getWeatherInfo();
      }else{
        weatherImg = "";
        weatherTemp = "";
        weatherInfo = "";
      }
      BloodPressureLocalDB db = BloodPressureLocalDB();
      db.database ;
      BloodPressureItem data =
      BloodPressureItem(
          dayOfTheWeek: DateFormat('EEEE').format(selectedDay),
          rData: DateFormat('yyyy-MM-dd').format(selectedDay),
          saveData: DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now()),
          registeredType: 1,
          systolic: int.parse(resultSys.text),
          diastole: int.parse(resultDia.text),
          pulse: int.parse(resultPul.text),
          memo: resultMemo.text,
          weatherImg: weatherImg,
          weatherTemp: weatherTemp,
          weatherInfo: weatherInfo,
          sendServerYM: 0 // 0 서버 비전송상태, 1 서버 전송상태
      );
      await db.insertAssetPortfolio(data).then((value){
        saved.call();
      });
    }
  }
  //서버에 데이터 저장시키기
  Future<void> serverDBInsert(Function saved)async{
    EasyLoading.show();
    TdiServers(bloodPressureServer: (BloodPressureServer bps) async {
      BloodPressureDto task = BloodPressureDto();
      await bps.BloodPressureInsert(appKey, task).then((value){
        // print('저장된값>>>>>>>>>>>>>>>>>>>>>>>>>${value.user_id}');
        // if(resp.user_id != null){
          saved.call();
        // }
      }).catchError((Object obj) async {
        // non-200 error goes here.
        EasyLoading.dismiss();
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
  selectDataPicker(BuildContext context)async{
    Future<DateTime?> future =  showDatePicker(
        locale: const Locale('ko', 'KO'),
        context: context,
        initialDate: focusedDay,
        firstDate: DateTime(2018),
        lastDate: DateTime.now());

    focusedDay = (await future)! ;
    selectedDay = (await future)! ;
    update();
  }
}