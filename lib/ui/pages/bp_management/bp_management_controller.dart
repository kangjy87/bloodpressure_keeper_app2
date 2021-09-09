import 'package:bloodpressure_keeper_app/model/bp_standard_model.dart';
import 'package:bloodpressure_keeper_app/model/day_weather_info_dto.dart';
import 'package:bloodpressure_keeper_app/retrofit/tdi_weather.dart';
import 'package:bloodpressure_keeper_app/retrofit/weather_server.dart';
import 'package:bloodpressure_keeper_app/ui/utils/msg_alert_dialog/onebutton_alert.dart';
import 'package:bloodpressure_keeper_app/utils/day_util.dart';
import 'package:bloodpressure_keeper_app/utils/shared_preferences_info/last_weather_info.dart';
import 'package:bloodpressure_keeper_app/utils/weather_util.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:bloodpressure_keeper_app/utils/blood_pressure_local_db.dart';
import 'package:bloodpressure_keeper_app/model/blood_pressure_item.dart';
import 'package:bloodpressure_keeper_app/ui/routes/app_routes.dart';
import 'package:bloodpressure_keeper_app/model/blood_pressure_chart_dto.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:permission_handler/permission_handler.dart';

class BpManagementController extends GetxController {
  PageController pageControllers = PageController() ;
  DateTime selectedDay = DateTime.now();
  DateTime focusedDay = DateTime.now();
  PageController bpDataPageController = PageController();
  String weatherImg  = "" ;
  String weatherStr  = "" ;
  String weatherTemp = "" ;
  bool weatherImgCheck = false ;
  bool gpsCheck = true ;

  @override
  void onInit() {
    super.onInit();
    pageControllers = PageController() ;
    selectedDay = DateTime.now();
    focusedDay = DateTime.now();
    bpDataPageController = PageController();
    weatherImg  = "" ;
    weatherStr  = "" ;
    weatherTemp = "" ;
    weatherImgCheck = false ;
    chartRefresh();
    selectDayInfo();
    permissionChecked();
  }
  //날짜 선택시
  void changeSelectedDay(DateTime sDay,DateTime fDay){
    selectedDay = sDay ;
    // focusedDay = fDay ;
    update();
  }

  //요일 바꿀시
  void changeFocusedDay(DateTime fDay){
    print('날짜 바뀜?$fDay');
    selectedDay = fDay ;
    focusedDay = fDay ;
    update();
  }


  //셀프 혈압등록
  void selfBpInput(Function refresh) {
    Get.toNamed(AppRoutes.SELFINFUT)!.then((value){
      refresh();
    });
  }

  var firstTime = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day - (DateTime.now().weekday - 1));
  var lastTime = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day + (7 - DateTime.now().weekday));

  //혈압차트
  bool bpDataCheck = true ;
  List<BloodPressureChartDto> systolicData = [];
  List<BloodPressureChartDto> diastoleData = [];
  List<BloodPressureChartDto> pulseData = [];
  bool chartDataCheck = false ;
  void chartRefresh()async{
    chartDataCheck = false ;
    bpDataCheck = true ;
    update();
    systolicData.clear();
    diastoleData.clear();
    pulseData.clear();
    BloodPressureLocalDB db = BloodPressureLocalDB();
    db.database ;
    List<BloodPressureItem> bpList = await db.getSelectDayAgeServenDaysBPDataList(DateFormat('yyyy-MM-dd').format(focusedDay));
    for(int i = 0 ;  i< bpList.length; i++ ){
      print('>>>>>>>>>>>>>>>>>>>>>${bpList[i].rData}>>>>>>>>>>>>>>>>${bpList[i].diastole}');
      String rday = DateFormat('MM-dd').format(DateTime.parse(bpList[i].rData!));
      systolicData.add(BloodPressureChartDto(position : i, checkData: rday, systolic: bpList[i].systolic));
      diastoleData.add(BloodPressureChartDto(position : i, checkData: rday, diastole: bpList[i].diastole));
      pulseData.add(BloodPressureChartDto(position : i, checkData: rday, pulse: bpList[i].pulse));
      if(bpList[i].systolic! > 0){
        bpDataCheck = false ;
      }
    }
    systolicData.toList()..sort((a,b) => a.position!.compareTo(b.position!));
    diastoleData.toList()..sort((a,b) => a.position!.compareTo(b.position!));
    pulseData.toList()..sort((a,b) => a.position!.compareTo(b.position!));
    chartDataCheck = true ;
    update();
  }

  List<BloodPressureItem> selectDayBPDataList = [];
  PageController pageController = PageController();
  // bool bpDataCheck = true ;
  int position = 0 ;
  void selectDayInfo()async{
    position = 0 ;
    selectDayBPDataList.clear();
    BloodPressureLocalDB db = BloodPressureLocalDB();
    db.database ;
    selectDayBPDataList = await db.getSelectDayBPDataList(DateFormat('yyyy-MM-dd').format(selectedDay));
    // bpDataCheck = (selectDayBPDataList[0].systolic! > 0 ? false : true) ;
    position = (selectDayBPDataList.length-1);
    beforeBtnImg = position == 0 ? "images/arrow_le_off.png" : "images/arrow_le_on.png" ;
    afterBtnImg = position == (position) ?"images/arrow_ri_off.png" : "images/arrow_r.png" ;
    bpRiskLevel.getStandardData(selectDayBPDataList[position].systolic!, selectDayBPDataList[position].diastole!);
    update();
  }

  String beforeBtnImg = "images/arrow_le_off.png" ;
  String afterBtnImg = "images/arrow_ri_off.png";
  void selectDayBpInfoBtn(String btn, int lastIndex){
    print('>>>>>>>>포지션 ${position}>>>>>>>>>>>>>>>라스트 포지션 ${lastIndex}');
    bool refreshCheck = false ;
    String strBtnMsg = '이전';
    if(btn == "B"){
      strBtnMsg = '이전';
      if(position > 0){
        position -- ;
        refreshCheck = true ;
      }
    }else{
      strBtnMsg = '다음';
      if(lastIndex > position){
        position ++ ;
        refreshCheck = true ;
      }
    }
    if(refreshCheck){
      beforeBtnImg = position == 0 ? "images/arrow_le_off.png" : "images/arrow_le_on.png" ;
      afterBtnImg = position == (lastIndex) ?"images/arrow_ri_off.png" : "images/arrow_r.png" ;
      print('@@@@@@@@@>>>>>>>>>>>@@@@@@<<<<<<<<<<<<<<<<<!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!');
      bpRiskLevel.getStandardData(selectDayBPDataList[position].systolic!, selectDayBPDataList[position].diastole!);
      update();
    }else{
      Fluttertoast.showToast(
          msg: "${strBtnMsg} 데이터가 없습니다.",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Color(0xff454f63),
          textColor: Colors.red,
          fontSize: 16.0
      );
    }
  }

  detailPageGo(BloodPressureItem data,Function refresh){
    Get.toNamed(AppRoutes.BpDetailInfo,arguments: data)!.then((value){
      refresh();
    });
  }

  //위험수치
  BPStandardModel bpRiskLevel =  BPStandardModel();

  //위치정보 받기
  Future<void> getPosition() async {
    // var currentPosition = await Geolocator
    //     .getCurrentPosition(desiredAccuracy: LocationAccuracy.low);
    // var lastPosition = await Geolocator
    // .getLastKnownPosition(desiredAccuracy: LocationAccuracy.low);
    //     // .getLastKnownPosition(desiredAccuracy: LocationAccuracy.low);
    // print(currentPosition);
    // print(lastPosition);
  }

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition();
  }

  getGeolocation()async{
    // Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    // Position? position2 = await Geolocator.getLastKnownPosition();
    Position position = await _determinePosition();
    List<Placemark> placemarks = await placemarkFromCoordinates(position.latitude, position.longitude);
    String? strStreet = placemarks[0].street ;
    var arrStreet  = strStreet!.split(' ');
    // print('!!!!!!!!>>>>>>위치>>>>>>>>${arrStreet[0]}');
    // print('!!!!!!!!>>>>>>위치>>>>>>>>${arrStreet[1]}');
    // print('!!!!!!!!>>>>>>위치>>>>>>>>${arrStreet[2]}');
    getWeather(arrStreet[1],arrStreet[2]);
  }

  getWeather(String city, String gu){
    TdiWeather(weatherServer: (WeatherServer ws) async {
      final _weatherResult = await ws.getCurrentWeather(city,gu);
      print('>>>>>>>>>>>>>>>${_weatherResult.weatherInfo.sky}');
      print('>>>>>>>>>>>>>>>${_weatherResult.weatherInfo.pty}');
      print('>>>>>>>>>>>>>>>${_weatherResult.weatherInfo.lgt}');
      print('>>>>>>>>>>>>>>>${_weatherResult.weatherInfo.t1h}');
      weatherImg = WeatherUtil.getWeatherImage(_weatherResult.weatherInfo.sky, _weatherResult.weatherInfo.pty, _weatherResult.weatherInfo.lgt) ;
      weatherStr = WeatherUtil.getWeatherStr(_weatherResult.weatherInfo.sky, _weatherResult.weatherInfo.pty, _weatherResult.weatherInfo.lgt) ;
      weatherTemp = "${_weatherResult.weatherInfo.t1h}℃ " ;
      weatherImgCheck = true ;
      setWeather(weatherImg, weatherTemp, weatherStr,DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now()));
      update();
    });
  }

  permissionChecked() async {
    var status = await Permission.location.request();
    if(!status.isGranted){
      gpsCheck = false ;
      update();
    }else{
      gpsCheck = true ;
      bool searchCheck = await getWeatherSearchCheck();
      if(searchCheck){
        getGeolocation();
      }else{
        weatherImgCheck = true ;
        weatherImg  = (await getWeatherImg())! ;
        weatherStr  = (await getWeatherInfo())! ;
        weatherTemp = (await getWeatherTemp())! ;
        update();
      }
    }
  }

  callPermissionChecked(BuildContext context) async {
    var status = await Permission.location.request();
    if(!status.isGranted){
      oneButtonAlert(
          context,
          '알림!',
          '혈압데이터 저장시 그날의 날씨를 확인하고 싶으면 위치권한을 허용해주세요!',
          '설정', () {
        Navigator.pop(context);
        openAppSettings().then((value){
          print('>>>>>>결과값>>>>>>>>>>>>>>>>>>${value}');
          update();
        });

      });
    }else{
      if(!gpsCheck){
        permissionChecked();
      }
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