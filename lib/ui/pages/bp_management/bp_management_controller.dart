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
  String strChartTitle = "최근 일주일 평균혈압" ;
  late String appKey = '';
  //List<BloodPressureDto>? bloodPressureList = [];

  HashMap<String,bool> searchMonthCheck = HashMap(); //조회된 달력 리스트
  HashMap<String,List<BloodPressureDto>> searchBpList = HashMap(); //조회된 데이터 리스트
  HashMap<String,List<BloodPressureDto>> searchBpAvgList = HashMap(); //조회된 데이터 일평균
  BloodPressureDto searchBpLastData = BloodPressureDto(); //조회된 날짜중 마지막 데이터
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
            msg: "재로그인이 필요합니다.",
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
        //앱 업데이트를 위해 넣어둠
        getServerBpList(false);
      }
    }catch(e){
      print('22222222>>>>>>>>>>>>>>');
      Fluttertoast.showToast(
          msg: "재로그인이 필요합니다.",
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
   * 화면들어올떄 데이터 초기화 시켜주기
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
    // selectDayInfo();  //데이터를 받고 나서 데이터를 셋팅해줘야 한다. 2
    // titleSetting();   //데이터를 받고 나서 데이터를 셋팅해줘야 한다. 3
    // chartRefresh(true);   //데이터를 받고 나서 데이터를 셋팅해줘야 한다. 1

  }

  /**
   * 서버에서 혈압데이터 조회하기
   * 시작일과 끝일을 선택후
   * 날짜/ 평균일까지 계산
   */
  getServerBpList(bool freepass)async{
    print('>>>>>>>>>>>>>>>>>>타타');
    //한번 조회된 해당달은 조회하지 않는다.단 해당달에 데이터가 혈압 수정이 있을경우는 다시 조회
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
            //이전 날짜 데이터를 넣어주고 초기화!!!!!!!!!!!!!!!!!!!!!!!!!
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
            //데이터를 넣어준다.
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
          selectDayInfo();  //데이터를 받고 나서 데이터를 셋팅해줘야 한다. 2
          titleSetting();   //데이터를 받고 나서 데이터를 셋팅해줘야 한다. 3
          chartRefresh();   //데이터를 받고 나서 데이터를 셋팅해줘야 한다. 1

        }).catchError((Object obj) async {
          print('에러된값>>>>>>>>>>>>>>>>>>>>>>>>>${obj}');
          EasyLoading.dismiss();
          selectDayInfo();  //데이터를 받고 나서 데이터를 셋팅해줘야 한다. 2
          titleSetting();   //데이터를 받고 나서 데이터를 셋팅해줘야 한다. 3
          chartRefresh();   //데이터를 받고 나서 데이터를 셋팅해줘야 한다. 1
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
   * 마지막 저장일을 체크하여
   * 매시지를 체크한다.
   * 데이터가 없는경우
   * 마지막 체크일이 7일전인경우
   * 오늘 데이터가 있는 경우
   */
  titleSetting()async{
    //데이터가 없는 경우
    if(searchBpLastData == null || searchBpLastData.date == null){
      strTitleMsg = await getHeaderText(null,0);
    }
    //데이터가 있는 경우
    else{
      int intDayDifference = dateDifference(typeChangeDateTime(searchBpLastData.date!)) ;
      //7일 이전
      if(intDayDifference < 7){
        //오늘 데이터가 있는 경우
        if(intDayDifference == 0 ){
          strTitleMsg = await getHeaderText(searchBpLastData,3);
        }
        //오늘 데이터가 없는 경우
        else{
          strTitleMsg = await getHeaderText(searchBpLastData,2);
        }
      }
      //7일 이후
      else{
        strTitleMsg = await getHeaderText(null,1);
      }
    }
    update();
  }
  //날짜 선택시
  void changeSelectedDay(DateTime sDay,DateTime fDay){
    print('>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>.클릭쓰');
    selectedDay = sDay ;
    focusedDay = fDay ;
    update();
    getServerBpList(false);
  }

  //요일 바꿀시
  void changeFocusedDay(DateTime fDay){
    print('$selectedDay날짜 바뀜?$fDay');
    focusedDay = fDay ;
    int difference = int.parse(focusedDay.difference(selectedDay).inDays.toString());
    print('>>>>>두날짜간 차>>>>>>>>>>>>>>>>>>>>>>>>>>>>>.${difference}');
    if(!(difference > 0 && difference <=6)){
      selectedDay = fDay ;
    }
    update();
    getServerBpList(false);
  }


  //셀프 혈압등록
  void selfBpInput(Function refresh)async{
    final saveData = await Get.toNamed(AppRoutes.SELFINFUT,arguments: {"date":selectedDay,"todayIndex":todayIndex})!;
    print('저장되고 온 데이터>>>>>>${saveData}');
    selectedDay = saveData['date'];
    focusedDay = getFocusedDay(todayIndex,selectedDay);
    update();
    refresh();
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
    //선택한 날짜에 -7일 데이터를 가지구 온다.
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

    //차트 차이틀 체크 ( 이번주인지 지난주인지 체크 )
    // strChartTitle = dateDifference(focusedDay) == 0 ? "최근 일주일 평균혈압" : "일주일 평균혈압" ;
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
    print('개>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>${selectDayBPDataList.length}');
    // bpDataCheck = (selectDayBPDataList[0].systolic! > 0 ? false : true) ;
    position = (selectDayBPDataList.length-1);
    //화살표 버튼 고정
    // beforeBtnImg = position == 0 ? "images/arrow_le_off.png" : "images/arrow_le_on.png" ;
    // afterBtnImg = position == (position) ?"images/arrow_ri_off.png" : "images/arrow_r.png" ;
    beforeBtnImg = position == 0 ? "images/arrow_le_on.png" : "images/arrow_le_on.png" ;
    afterBtnImg = position == (position) ?"images/arrow_r.png" : "images/arrow_r.png" ;
    bpRiskLevel.getStandardData(selectDayBPDataList[position].systolic!, selectDayBPDataList[position].diastolic!);
    update();
  }

  //화살표 버튼 고정
  // String beforeBtnImg = "images/arrow_le_off.png" ;
  // String afterBtnImg = "images/arrow_ri_off.png";
  String beforeBtnImg = "images/arrow_le_on.png" ;
  String afterBtnImg = "images/arrow_r.png";
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
      //화살표 버튼 고정
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
            msg: "오늘 이후의 날짜는 선택이 불가능 합니다.",
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
      //     msg: "${strBtnMsg} 데이터가 없습니다.",
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
    print('저장되고 온 데이터>>>>>>${saveData}');
    selectedDay = saveData['date'];
    focusedDay = getFocusedDay(todayIndex,selectedDay);
    update();
    refresh();
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
    String street1 = arrStreet.length > 2 ? arrStreet[1] : "" ; //서울시
    String street2 = arrStreet.length > 3 ? arrStreet[2] : "" ; //서초구
    String street3 = arrStreet.length > 4 ? arrStreet[3] : "" ; //반포동포동
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
      // weatherTemp = "${_weatherResult.weatherInfo.t1h}℃ " ;로컬 디비로 저장할때는 ℃ 를 붙여서 저장했지만  서버에 저장하는 경우는 온도만 저장
      weatherTemp = "${_weatherResult.weatherInfo.t1h}℃" ;
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
        weatherTemp = '${(await getWeatherTemp())!}℃' ;
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
          '혈압데이터 저장시 그날의 날씨를 확인하고 싶으면 \n위치권한을 허용해주세요!',
          '설정', () {
        Navigator.pop(context);
        openAppSettings().then((value){
          print('>>>>>>결과값>>>>>>>>>>>>>>>>>>${value}');
          update();
        });

      });
    }else{
      print('>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>흠....${gpsCheck}');
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
    print('날짜선택>>>>>>>>>>>>>>>>>>>>>>>>>>>>>${selectedDay}');
    focusedDay = getFocusedDay(todayIndex,selectedDay);
    update();
  }

  /**
   * 차트 필터 데이터 7일중 데이터가 없는건 혈압데이터를 0으로 셋팅
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
   * 혈압관리 디테일 데이터 셋팅
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
      data.weather = '맑음' ;
      list.add(data);
    }
    print('선넘지마!!!!!!!>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>${list.length}');
    return list ;
  }
}