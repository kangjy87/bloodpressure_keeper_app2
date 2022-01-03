import 'package:shared_preferences/shared_preferences.dart';

/**
 * 도시저장
 */
void setCity(String si, String gu, String dong)async{
  SharedPreferences _prefs = await SharedPreferences.getInstance();
  _prefs.setString('city_si', (si  == null ? "" : si));
  _prefs.setString('city_gu',(gu == null ? "" : gu));
  _prefs.setString('city_dong',(dong == null ? "" : dong));
}
/**
 * 도시 시
 */
Future<String?> getCity_si()async{
  SharedPreferences _prefs = await SharedPreferences.getInstance();
  return (_prefs.getString('city_si') == null ? '' : _prefs.getString('city_si')) ;
}
/**
 * 도시 구
 */
Future<String?> getCity_gu()async{
  SharedPreferences _prefs = await SharedPreferences.getInstance();
  return (_prefs.getString('city_gu') == null ? '' : _prefs.getString('city_gu')) ;
}
/**
 * 도시 동
 */
Future<String?> getCity_dong()async{
  SharedPreferences _prefs = await SharedPreferences.getInstance();
  return (_prefs.getString('city_dong') == null ? '' : _prefs.getString('city_dong')) ;
}


/**
 * 토큰저장
 */
void setWeather(String? img, String? temp, String info,String saveTime)async{
  SharedPreferences _prefs = await SharedPreferences.getInstance();
  _prefs.setString('weather_save_time', (saveTime  == null ? "" : saveTime));
  _prefs.setString('weather_img', (img  == null ? "" : img));
  _prefs.setString('weather_temp',(temp == null ? "" : temp));
  _prefs.setString('weather_info',(info == null ? "" : info));
}
/**
 * 마지막 날짜
 */
Future<String?> getWeatherSaveTime()async{
  SharedPreferences _prefs = await SharedPreferences.getInstance();
  return (_prefs.getString('weather_save_time') == null ? '' : _prefs.getString('weather_save_time')) ;
}
/**
 * 마지막 이미지
 */
Future<String?> getWeatherImg()async{
  SharedPreferences _prefs = await SharedPreferences.getInstance();
  return _prefs.getString('weather_img') ;
}

/**
 * 마지막 온도
 */
Future<String?> getWeatherTemp()async{
  SharedPreferences _prefs = await SharedPreferences.getInstance();
  return _prefs.getString('weather_temp') ;
}

/**
 * 마지막 정보
 */
Future<String?> getWeatherInfo()async{
  SharedPreferences _prefs = await SharedPreferences.getInstance();
  return _prefs.getString('weather_info') ;
}