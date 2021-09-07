import 'package:bloodpressure_keeper_app/utils/shared_preferences_info/last_weather_info.dart';
import 'package:get/get.dart';
import 'package:bloodpressure_keeper_app/ui/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:bloodpressure_keeper_app/utils/blood_pressure_local_db.dart';
import 'package:bloodpressure_keeper_app/model/blood_pressure_item.dart';
import 'package:intl/intl.dart';
import 'package:fluttertoast/fluttertoast.dart';

class SelfBpInputController extends GetxController {
  final String title = '혈압입력';
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
    update();
  }

  TextEditingController resultSys = TextEditingController() ;
  TextEditingController resultDia = TextEditingController() ;
  TextEditingController resultPul = TextEditingController() ;
  TextEditingController resultMemo = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    beforeBloodPressure();
  }

  void beforeBloodPressure()async{
    // BloodPressureLocalDB db = BloodPressureLocalDB();
    // db.database ;
    // BloodPressureItem? data = await db.getLastBPData();
    // resultSys.text = data!.systolic == null ? '' : data!.systolic.toString() ;
    // resultDia.text = data!.diastole == null ? '' : data!.diastole.toString() ;
    // resultPul.text = data!.pulse == null ? '' : data!.pulse.toString() ;
    // update();
  }

  bool saveCheck(){
    if(resultSys.text == ''){
      Fluttertoast.showToast(
          msg: "수축기 혈압을 입력해주세요.",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Color(0xff454f63),
          textColor: Colors.red,
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
          textColor: Colors.red,
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
          textColor: Colors.red,
          fontSize: 16.0
      );
      return false ;
    }
    if(int.parse(resultSys.text) > 200){
      Fluttertoast.showToast(
          msg: "수축기 혈압이 비정상적 입니다.",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Color(0xff454f63),
          textColor: Colors.red,
          fontSize: 16.0
      );
      return false ;
    }
    if(int.parse(resultDia.text) > 200){
      Fluttertoast.showToast(
          msg: "이완기 혈압이 비정상적 입니다.",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Color(0xff454f63),
          textColor: Colors.red,
          fontSize: 16.0
      );
      return false ;
    }
    if(int.parse(resultPul.text) > 200){
      Fluttertoast.showToast(
          msg: "심박수가 비정상적 입니다.",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Color(0xff454f63),
          textColor: Colors.red,
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
          weatherInfo: weatherInfo
      );
      await db.insertAssetPortfolio(data).then((value){
        saved.call();
      });
    }
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