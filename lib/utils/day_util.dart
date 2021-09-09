import 'package:bloodpressure_keeper_app/utils/shared_preferences_info/last_weather_info.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

String getStringDay(String yyyymmdd){
  return DateFormat('yyyy-MM-dd').format(DateTime.parse(yyyymmdd));
}
String getKorDayOfTheWeek(String strSelectDay){
  String strReturn = "";
  switch(strSelectDay){
    case 'Sunday' :
      strReturn = '일요일';
      break ;
    case 'Monday' :
      strReturn = '월요일';
      break ;
    case 'Tuesday' :
      strReturn = '화요일';
      break ;
    case 'Wednesday' :
      strReturn = '수요일';
      break ;
    case 'Thursday' :
      strReturn = '목요일';
      break ;
    case 'Friday' :
      strReturn = '금요일';
      break ;
    case 'Saturday' :
      strReturn = '토요일';
      break ;
  }
  return strReturn ;
}

int getIntDayOfTheWeek(String strSelectDay){
  int strReturn = 0;
  switch(strSelectDay){
    case 'Sunday' :
      strReturn = 0 ;
      break ;
    case 'Monday' :
      strReturn = 1 ;
      break ;
    case 'Tuesday' :
      strReturn = 2 ;
      break ;
    case 'Wednesday' :
      strReturn = 3 ;
      break ;
    case 'Thursday' :
      strReturn = 4 ;
      break ;
    case 'Friday' :
      strReturn = 5 ;
      break ;
    case 'Saturday' :
      strReturn = 6 ;
      break ;
  }
  return strReturn ;
}

String getStringDayOfTheWeek(int intSelectDay){
  String strReturn = "";
  switch(intSelectDay){
    case 0 :
      strReturn = 'Sunday';
      break ;
    case 1 :
      strReturn = 'Monday';
      break ;
    case 2 :
      strReturn = 'Tuesday';
      break ;
    case 3 :
      strReturn = 'Wednesday';
      break ;
    case 4 :
      strReturn = 'Thursday';
      break ;
    case 5 :
      strReturn = 'Friday';
      break ;
    case 6 :
      strReturn = 'Saturday';
      break ;
  }
  return strReturn ;
}

String getWeekDaySearch(String strSunday,int seachWeekDay){
  DateTime date = DateTime.parse(strSunday);
  String day = DateFormat('yyyy-MM-dd').format(DateTime(date.year, date.month, date.day - seachWeekDay));
  return day ;
}

Future<bool> getWeatherSearchCheck()async{
  String strSaveTime = (await getWeatherSaveTime())!;
  DateTime saveTime = DateTime.parse(strSaveTime) ;
  if(saveTime != ""){
    int day = int.parse(DateTime.now().difference(saveTime).inMinutes.toString());
    // print('${strSaveTime}!!!!!!!!!!!!!!!!!!!!!!!!>>>>>>>>>${day}');
    if(day >= 30){
      return true ;
    }
  }else{
    return true ;
  }
  return false ;
}

String getselectWeekSunday(String strSelectDay){
  DateTime date = DateTime.parse(strSelectDay);
  int selectDayMondayDiff = 0 ;
  switch(DateFormat('EEEE').format(date)){
    case 'Sunday' :
      selectDayMondayDiff = 0 ;
      break ;
    case 'Monday' :
      selectDayMondayDiff = -1 ;
      break ;
    case 'Tuesday' :
      selectDayMondayDiff = -2 ;
      break ;
    case 'Wednesday' :
      selectDayMondayDiff = -3 ;
      break ;
    case 'Thursday' :
      selectDayMondayDiff = -4 ;
      break ;
    case 'Friday' :
      selectDayMondayDiff = -5 ;
      break ;
    case 'Saturday' :
      selectDayMondayDiff = -6 ;
      break ;
  }
  print('마이너스데이>>>$selectDayMondayDiff');
  print('마이너스데이>>>${DateFormat('yyyy-MM-dd').format(DateTime(date.year, date.month, date.day))}');
  String day = DateFormat('yyyy-MM-dd').format(DateTime(date.year, date.month, date.day + selectDayMondayDiff));
  return day ;
}

String getselectWeekSaturday(String strSelectDay){
  DateTime date = DateTime.parse(strSelectDay);
  int selectDayMondayDiff = 0 ;
  switch(DateFormat('EEEE').format(date)){
    case 'Saturday' :
      selectDayMondayDiff = 0 ;
      break ;
    case 'Sunday' :
      selectDayMondayDiff = 6 ;
      break ;
    case 'Monday' :
      selectDayMondayDiff = 5 ;
      break ;
    case 'Tuesday' :
      selectDayMondayDiff = 4 ;
      break ;
    case 'Wednesday' :
      selectDayMondayDiff = 3 ;
      break ;
    case 'Thursday' :
      selectDayMondayDiff = 2 ;
      break ;
    case 'Friday' :
      selectDayMondayDiff = 1 ;
      break ;
  }
  String day = DateFormat('yyyy-MM-dd').format(DateTime(date.year, date.month, date.day + selectDayMondayDiff));
  return day ;
}

StartingDayOfWeek startWeekdaySetting(){
  final today = DateTime.now();
  switch(DateFormat('EEEE').format(today)){
    case 'Saturday' :
      return StartingDayOfWeek.sunday ;

    case 'Sunday' :
      return StartingDayOfWeek.monday ;

    case 'Monday' :
      return StartingDayOfWeek.tuesday ;

    case 'Tuesday' :
      return StartingDayOfWeek.wednesday ;

    case 'Wednesday' :
      return StartingDayOfWeek.thursday ;

    case 'Thursday' :
      return StartingDayOfWeek.friday ;

    case 'Friday' :
      return StartingDayOfWeek.saturday ;
    default :
      return StartingDayOfWeek.sunday ;
  }
}
