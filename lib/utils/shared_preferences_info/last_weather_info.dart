import 'package:shared_preferences/shared_preferences.dart';
/**
 * 토큰저장
 */
void setWeather(String? img, String? temp, String info)async{
  SharedPreferences _prefs = await SharedPreferences.getInstance();
  _prefs.setString('weather_img', (img  == null ? "" : img));
  _prefs.setString('weather_temp',(temp == null ? "" : temp));
  _prefs.setString('weather_info',(info == null ? "" : info));
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