import 'dart:collection';

import 'package:bloodpressure_keeper_app/model/bloodpressure_dto.dart';
import 'package:bloodpressure_keeper_app/model/bp_standard_model.dart';
import 'package:bloodpressure_keeper_app/model/day_weather_info_dto.dart';
import 'package:bloodpressure_keeper_app/model/users_dto.dart';
import 'package:bloodpressure_keeper_app/retrofit/blood_pressure_server.dart';
import 'package:bloodpressure_keeper_app/retrofit/tdi_servers.dart';
import 'package:bloodpressure_keeper_app/retrofit/tdi_weather.dart';
import 'package:bloodpressure_keeper_app/retrofit/weather_server.dart';
import 'package:bloodpressure_keeper_app/ui/utils/msg_alert_dialog/onebutton_alert.dart';
import 'package:bloodpressure_keeper_app/utils/day_util.dart';
import 'package:bloodpressure_keeper_app/utils/shared_preferences_info/get_client_credentials_grant.dart';
import 'package:bloodpressure_keeper_app/utils/shared_preferences_info/last_weather_info.dart';
import 'package:bloodpressure_keeper_app/utils/shared_preferences_info/login_info.dart';
import 'package:bloodpressure_keeper_app/utils/weather_util.dart';
import 'package:dio/dio.dart';
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
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'main_header_text.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
  int todayIndex = 0 ;
  String strTitleMsg = "" ;
  String strChartTitle = "?????? ????????? ????????????" ;
  late String appKey = '';
  //List<BloodPressureDto>? bloodPressureList = [];

  HashMap<String,bool> searchMonthCheck = HashMap(); //????????? ?????? ?????????
  HashMap<String,List<BloodPressureDto>> searchBpList = HashMap(); //????????? ????????? ?????????
  HashMap<String,List<BloodPressureDto>> searchBpAvgList = HashMap(); //????????? ????????? ?????????
  BloodPressureDto searchBpLastData = BloodPressureDto(); //????????? ????????? ????????? ?????????

  /////////////////////////////

  @override
  void onInit() {
    // super.onInit();
    dataInit();
    permissionChecked();
    initLoginCheck();
  }
  initLoginCheck()async{
    try{
      String appKey = await getUserAccessToken();
      print('>>>>>>>>>>>>>>${appKey}');
      if(appKey == null || appKey == ''){
        Fluttertoast.showToast(
            msg: "??????????????? ???????????????.",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Color(0xff454f63),
            textColor: Colors.white,
            fontSize: 16.0
        );
        setWeather("", "", "","");
        setUserClaer(() {
          Get.offAllNamed(AppRoutes.LOGIN)!.then((value) {
          });
        });
      }else{
        //??? ??????????????? ?????? ?????????
        getServerBpList(false);
      }
    }catch(e){
      print('22222222>>>>>>>>>>>>>>');
      Fluttertoast.showToast(
          msg: "??????????????? ???????????????.",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Color(0xff454f63),
          textColor: Colors.white,
          fontSize: 16.0
      );
      setUserClaer(() {
        Get.offAllNamed(AppRoutes.LOGIN)!.then((value) {
        });
      });
    }
  }
  /**
   * ?????????????????? ????????? ????????? ????????????
   */
  dataInit(){
    searchMonthCheck = HashMap();
    pageControllers = PageController() ;
    selectedDay = DateTime.now();
    todayIndex = selectDayIndex(selectedDay);
    focusedDay = DateTime.now();
    bpDataPageController = PageController();
    weatherImg  = "" ;
    weatherStr  = "" ;
    weatherTemp = "" ;
    weatherImgCheck = false ;
    // selectDayInfo();  //???????????? ?????? ?????? ???????????? ??????????????? ??????. 2
    // titleSetting();   //???????????? ?????? ?????? ???????????? ??????????????? ??????. 3
    // chartRefresh(true);   //???????????? ?????? ?????? ???????????? ??????????????? ??????. 1

  }

  /**
   * ???????????? ??????????????? ????????????
   * ???????????? ????????? ?????????
   * ??????/ ??????????????? ??????
   */
  getServerBpList(bool freepass)async{
    print('>>>>>>>>>>>>>>>>>>??????');
    //?????? ????????? ???????????? ???????????? ?????????.??? ???????????? ???????????? ?????? ????????? ??????????????? ?????? ??????
    String yyyymm = typeChangeStryyyymm(selectedDay);
    if(searchMonthCheck[yyyymm] == null || freepass == true){
      searchMonthCheck[yyyymm] = true ;
      if(appKey == ""){
        appKey = await getUserAccessToken();
      }
      TdiServers(bloodPressureServer: (BloodPressureServer bps) async {
        String CheckDay = '${yyyymm}-01';
        String startDay = '${getAgeMonth(CheckDay)}-01';
        String endDay = getLastMonthDay(CheckDay) ;
        await bps.getBloodPressureList(appKey, startDay, endDay).then((value){
          EasyLoading.dismiss();
          List<BloodPressureDto>? bpList  = value.data ;
          bpList!.sort((a,b) => a.date!.compareTo(b.date!));
          searchBpLastData = bpList.last ;
          String keyDay = "";
          List<BloodPressureDto>? daylist = [] ;
          int sys = 0 ;
          int dia = 0 ;
          int pul = 0 ;
          BloodPressureDto avgDto = BloodPressureDto();
          for(int i = 0 ; i < bpList.length ; i++){
            //?????? ?????? ???????????? ???????????? ?????????!!!!!!!!!!!!!!!!!!!!!!!!!
            if(keyDay == "" || getStringDay(bpList[i].date!) != keyDay){
              if(daylist!.length > 0){
                /////////////////////////////
                searchBpList[keyDay]!.addAll(daylist);
                /////////////////////////////
                avgDto.date = keyDay ;
                avgDto.systolic = (sys / daylist.length).toInt();
                avgDto.diastolic = (dia / daylist.length).toInt();
                avgDto.heart = (pul / daylist.length).toInt();
                searchBpAvgList[keyDay]!.add(avgDto);
              }
              ///////////////////
              keyDay = getStringDay(bpList[i].date!);
              ///////////////////
              searchBpList[keyDay] = [] ;
              daylist = [] ;
              ///////////////////
              sys = 0 ;
              dia = 0 ;
              pul = 0 ;
              avgDto = BloodPressureDto();
              searchBpAvgList[keyDay] = [] ;
              ///////////////////
            }
            //???????????? ????????????.
            daylist!.add(bpList[i]);
            ///////////////
            sys = sys + bpList[i].systolic! ;
            dia = dia + bpList[i].diastolic! ;
            pul = pul + bpList[i].heart! ;
            if(i == (bpList.length-1)){
              /////////////////////////////
              searchBpList[keyDay]!.addAll(daylist);
              /////////////////////////////
              avgDto.date = keyDay ;
              avgDto.systolic = (sys / daylist.length).toInt();
              avgDto.diastolic = (dia / daylist.length).toInt();
              avgDto.heart = (pul / daylist.length).toInt();
              searchBpAvgList[keyDay]!.add(avgDto);
            }
          }
          selectDayInfo();  //???????????? ?????? ?????? ???????????? ??????????????? ??????. 2
          titleSetting();   //???????????? ?????? ?????? ???????????? ??????????????? ??????. 3
          chartRefresh();   //???????????? ?????? ?????? ???????????? ??????????????? ??????. 1

        }).catchError((Object obj) async {
          print('????????????>>>>>>>>>>>>>>>>>>>>>>>>>${obj}');
          EasyLoading.dismiss();
          selectDayInfo();  //???????????? ?????? ?????? ???????????? ??????????????? ??????. 2
          titleSetting();   //???????????? ?????? ?????? ???????????? ??????????????? ??????. 3
          chartRefresh();   //???????????? ?????? ?????? ???????????? ??????????????? ??????. 1
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

  /**
   * ????????? ???????????? ????????????
   * ???????????? ????????????.
   * ???????????? ????????????
   * ????????? ???????????? 7???????????????
   * ?????? ???????????? ?????? ??????
   */
  titleSetting()async{
    //???????????? ?????? ??????
    if(searchBpLastData == null || searchBpLastData.date == null){
      strTitleMsg = await getHeaderText(null,0);
    }
    //???????????? ?????? ??????
    else{
      int intDayDifference = dateDifference(typeChangeDateTime(searchBpLastData.date!)) ;
      //7??? ??????
      if(intDayDifference < 7){
        //?????? ???????????? ?????? ??????
        if(intDayDifference == 0 ){
          strTitleMsg = await getHeaderText(searchBpLastData,3);
        }
        //?????? ???????????? ?????? ??????
        else{
          strTitleMsg = await getHeaderText(searchBpLastData,2);
        }
      }
      //7??? ??????
      else{
        strTitleMsg = await getHeaderText(null,1);
      }
    }
    update();
  }
  //?????? ?????????
  void changeSelectedDay(DateTime sDay,DateTime fDay){
    print('>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>.?????????');
    selectedDay = sDay ;
    focusedDay = fDay ;
    update();
    getServerBpList(false);
  }

  //?????? ?????????
  void changeFocusedDay(DateTime fDay){
    print('$selectedDay?????? ???????$fDay');
    focusedDay = fDay ;
    int difference = int.parse(focusedDay.difference(selectedDay).inDays.toString());
    print('>>>>>???????????? ???>>>>>>>>>>>>>>>>>>>>>>>>>>>>>.${difference}');
    if(!(difference > 0 && difference <=6)){
      selectedDay = fDay ;
    }
    update();
    getServerBpList(false);
  }

  //?????? ????????????
  void selfBpInput(Function refresh)async{
    final saveData = await Get.toNamed(AppRoutes.SELFINFUT,arguments: {"date":selectedDay,"todayIndex":todayIndex})!;
    print('???????????? ??? ?????????>>>>>>${saveData}');
    selectedDay = saveData['date'];
    focusedDay = getFocusedDay(todayIndex,selectedDay);
    update();
    refresh();
  }

  var firstTime = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day - (DateTime.now().weekday - 1));
  var lastTime = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day + (7 - DateTime.now().weekday));

  //????????????
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
    //????????? ????????? -7??? ???????????? ????????? ??????.
    List<BloodPressureDto> bpList = await selectServenDaysAvg();
    for(int i = 0 ;  i< bpList.length; i++ ){
      String rday = DateFormat('MM-dd').format(DateTime.parse(bpList[i].date!));
      print('!!!!!!!!!!!!!!!!!>>>>>>>>>>>>>>>>${rday}');
      systolicData.add(BloodPressureChartDto(position : i, checkData: rday, checkFullData: bpList[i].date, systolic: bpList[i].systolic));
      diastoleData.add(BloodPressureChartDto(position : i, checkData: rday, checkFullData: bpList[i].date, diastole: bpList[i].diastolic));
      pulseData.add(BloodPressureChartDto(position : i, checkData: rday, checkFullData: bpList[i].date, pulse: bpList[i].heart));
      if(bpList[i].systolic! > 0){
        bpDataCheck = false ;
      }
    }
    systolicData.toList()..sort((a,b) => a.position!.compareTo(b.position!));
    diastoleData.toList()..sort((a,b) => a.position!.compareTo(b.position!));
    pulseData.toList()..sort((a,b) => a.position!.compareTo(b.position!));
    await Future.delayed(Duration (milliseconds: 200));
    chartDataCheck = true ;
    update();

    //?????? ????????? ?????? ( ??????????????? ??????????????? ?????? )
    // strChartTitle = dateDifference(focusedDay) == 0 ? "?????? ????????? ????????????" : "????????? ????????????" ;
    // update();
  }

  List<BloodPressureDto> selectDayBPDataList = [];
  PageController pageController = PageController();
  // bool bpDataCheck = true ;
  int position = 0 ;
  void selectDayInfo()async{
    position = 0 ;
    selectDayBPDataList.clear();
    selectDayBPDataList = await selectDays(typeChangeString(selectedDay));
    print('???>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>${selectDayBPDataList.length}');
    // bpDataCheck = (selectDayBPDataList[0].systolic! > 0 ? false : true) ;
    position = (selectDayBPDataList.length-1);
    //????????? ?????? ??????
    // beforeBtnImg = position == 0 ? "images/arrow_le_off.png" : "images/arrow_le_on.png" ;
    // afterBtnImg = position == (position) ?"images/arrow_ri_off.png" : "images/arrow_r.png" ;
    beforeBtnImg = position == 0 ? "images/arrow_le_on.png" : "images/arrow_le_on.png" ;
    afterBtnImg = position == (position) ?"images/arrow_r.png" : "images/arrow_r.png" ;
    bpRiskLevel.getStandardData(selectDayBPDataList[position].systolic!, selectDayBPDataList[position].diastolic!);
    update();
  }

  //????????? ?????? ??????
  // String beforeBtnImg = "images/arrow_le_off.png" ;
  // String afterBtnImg = "images/arrow_ri_off.png";
  String beforeBtnImg = "images/arrow_le_on.png" ;
  String afterBtnImg = "images/arrow_r.png";
  void selectDayBpInfoBtn(String btn, int lastIndex){
    print('>>>>>>>>????????? ${position}>>>>>>>>>>>>>>>????????? ????????? ${lastIndex}');
    bool refreshCheck = false ;
    String strBtnMsg = '??????';
    if(btn == "B"){
      strBtnMsg = '??????';
      if(position > 0){
        position -- ;
        refreshCheck = true ;
      }
    }else{
      strBtnMsg = '??????';
      if(lastIndex > position){
        position ++ ;
        refreshCheck = true ;
      }
    }
    if(refreshCheck){
      //????????? ?????? ??????
      // beforeBtnImg = position == 0 ? "images/arrow_le_off.png" : "images/arrow_le_on.png" ;
      // afterBtnImg = position == (lastIndex) ?"images/arrow_ri_off.png" : "images/arrow_r.png" ;
      beforeBtnImg = position == 0 ? "images/arrow_le_on.png" : "images/arrow_le_on.png" ;
      afterBtnImg = position == (lastIndex) ?"images/arrow_r.png" : "images/arrow_r.png" ;
      print('@@@@@@@@@>>>>>>>>>>>@@@@@@<<<<<<<<<<<<<<<<<!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!');
      bpRiskLevel.getStandardData(selectDayBPDataList[position].systolic!, selectDayBPDataList[position].diastolic!);
      update();
    }else{
      if(btn != 'B' && DateFormat('yyyy-MM-dd').format(DateTime.now()) == DateFormat('yyyy-MM-dd').format(selectedDay)){
        Fluttertoast.showToast(
            msg: "?????? ????????? ????????? ????????? ????????? ?????????.",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Color(0xff454f63),
            textColor: Colors.white,
            fontSize: 16.0
        );
      }else{
        DateTime nowSelectDay = dateShift(selectedDay,btn == 'B' ? -1 : 1) ;
        changeSelectedDay(
            nowSelectDay, getFocusedDay(todayIndex,nowSelectDay));
        selectDayInfo();
      }
      // Fluttertoast.showToast(
      //     msg: "${strBtnMsg} ???????????? ????????????.",
      //     toastLength: Toast.LENGTH_SHORT,
      //     gravity: ToastGravity.BOTTOM,
      //     timeInSecForIosWeb: 1,
      //     backgroundColor: Color(0xff454f63),
      //     textColor: Colors.red,
      //     fontSize: 16.0
      // );
    }
  }
  chartCheck(String data){
    DateTime dateType = typeChangeDateTime(data);
    changeSelectedDay(
        dateType, getFocusedDay(todayIndex,dateType));
    selectDayInfo();
  }
  detailPageGo(BloodPressureDto data,Function refresh)async{
    final saveData = await Get.toNamed(AppRoutes.BpDetailInfo,arguments: data)!;
    print('???????????? ??? ?????????>>>>>>${saveData}');
    selectedDay = saveData['date'];
    focusedDay = getFocusedDay(todayIndex,selectedDay);
    update();
    refresh();
  }

  //????????????
  BPStandardModel bpRiskLevel =  BPStandardModel();

  //???????????? ??????
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
    String street1 = arrStreet.length > 2 ? arrStreet[1] : "" ; //?????????
    String street2 = arrStreet.length > 3 ? arrStreet[2] : "" ; //?????????
    String street3 = arrStreet.length > 4 ? arrStreet[3] : "" ; //???????????????
    getWeather(street1,street2,street3);
  }

  getWeather(String city, String gu, String dong){
    TdiWeather(weatherServer: (WeatherServer ws) async {
      final _weatherResult = await ws.getCurrentWeather(city,gu);
      print('>>>>>>>>>>>>>>>${_weatherResult.weatherInfo.sky}');
      print('>>>>>>>>>>>>>>>${_weatherResult.weatherInfo.pty}');
      print('>>>>>>>>>>>>>>>${_weatherResult.weatherInfo.lgt}');
      print('>>>>>>>>>>>>>>>${_weatherResult.weatherInfo.t1h}');
      weatherImg = WeatherUtil.getWeatherImage(_weatherResult.weatherInfo.sky, _weatherResult.weatherInfo.pty, _weatherResult.weatherInfo.lgt) ;
      weatherStr = WeatherUtil.getWeatherStr(_weatherResult.weatherInfo.sky, _weatherResult.weatherInfo.pty, _weatherResult.weatherInfo.lgt) ;
      // weatherTemp = "${_weatherResult.weatherInfo.t1h}??? " ;?????? ????????? ??????????????? ??? ??? ????????? ???????????????  ????????? ???????????? ????????? ????????? ??????
      weatherTemp = "${_weatherResult.weatherInfo.t1h}???" ;
      weatherImgCheck = true ;
      setCity(city, gu, dong);
      setWeather(weatherImg, "${_weatherResult.weatherInfo.t1h}", weatherStr,DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now()));
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
        weatherTemp = '${(await getWeatherTemp())!}???' ;
        update();
      }
    }
  }

  callPermissionChecked(BuildContext context) async {
    var status = await Permission.location.request();
    if(!status.isGranted){
      oneButtonAlert(
          context,
          '??????!',
          '??????????????? ????????? ????????? ????????? ???????????? ????????? \n??????????????? ??????????????????!',
          '??????', () {
        Navigator.pop(context);
        openAppSettings().then((value){
          print('>>>>>>?????????>>>>>>>>>>>>>>>>>>${value}');
          update();
        });

      });
    }else{
      print('>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>???....${gpsCheck}');
      if(!gpsCheck){
        permissionChecked();
      }
    }
  }

  selectDataPicker(BuildContext context)async{
    Future<DateTime?> future =  showDatePicker(
        locale: const Locale('ko', 'KO'),
        context: context,
        initialDate: selectedDay,
        firstDate: DateTime(2018),
        lastDate: DateTime.now());

    selectedDay = (await future)! ;
    print('????????????>>>>>>>>>>>>>>>>>>>>>>>>>>>>>${selectedDay}');
    focusedDay = getFocusedDay(todayIndex,selectedDay);
    update();
  }

  /**
   * ?????? ?????? ????????? 7?????? ???????????? ????????? ?????????????????? 0?????? ??????
   */
  Future<List<BloodPressureDto>> selectServenDaysAvg()async{
    List<BloodPressureDto> returnList = [] ;
    for(int i = 6 ; i > -1 ; i--){
      String days = typeChangeString(focusedDay.subtract(Duration(days: i))) ;
      List<BloodPressureDto> dayList = [] ;
      if(searchBpAvgList[days] != null){
        dayList.addAll(await searchBpAvgList[days]!) ;
      }else{
        BloodPressureDto data = BloodPressureDto();
        data.systolic = 0 ;
        data.diastolic = 0 ;
        data.heart = 0 ;
        data.date = days ;
        dayList.add(data);
      }
      returnList.addAll(dayList);
    }
    return returnList ;
  }

  /**
   * ???????????? ????????? ????????? ??????
   */
  Future<List<BloodPressureDto>> selectDays(String selectDay)async{
    //List<BloodPressureDto> list = await bloodPressureList!.where((element) => getStringDay(element.date!) == selectDay).toList() ;
    List<BloodPressureDto> list = [] ;
    if(searchBpList[selectDay] != null){
      list.addAll(await searchBpList[selectDay]!);
    }else{
      BloodPressureDto data = BloodPressureDto();
      data.id = 0 ;
      data.systolic = 0 ;
      data.diastolic = 0 ;
      data.heart = 0 ;
      data.memo = '  ';
      data.date = selectDay ;
      data.created_at = '1111-11-11' ;
      data.weather = '??????' ;
      list.add(data);
    }
    print('????????????!!!!!!!>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>${list.length}');
    return list ;
  }
}