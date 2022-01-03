import 'package:shared_preferences/shared_preferences.dart';
import 'package:bloodpressure_keeper_app/model/client_credentials_grant_dto.dart';
/**
 * 토큰저장
 */
void setClientCredentiaksGrant(String? value,Function saved)async{
  SharedPreferences _prefs = await SharedPreferences.getInstance();
  _prefs.setString('access_token', value!).then((value) => saved());
}
/**
 * 저장된 토큰 갖구오기
 */
Future<GetClientCredentialsGrantDto> getClientCredentiaksGrant()async{
  SharedPreferences _prefs = await SharedPreferences.getInstance();
  GetClientCredentialsGrantDto data = GetClientCredentialsGrantDto();
  data.access_token = _prefs.getString('access_token');
  return data ;
}
/**
 *  AccessToken 로그인하고 나서 받아오는 값
 */
void setUserAccessToken(String? accessToken)async{
  SharedPreferences _prefs = await SharedPreferences.getInstance();
  _prefs.setString('UserAccessToken', (accessToken == null ? "" : accessToken));
}
Future<String> getUserAccessToken()async{
  SharedPreferences _prefs = await SharedPreferences.getInstance();
  String? token = _prefs.getString('UserAccessToken');
  return token == null ? "" : 'Bearer ${token}';
}


void setFeedCredentiaksGrant(String? value,Function saved)async{
  SharedPreferences _prefs = await SharedPreferences.getInstance();
  _prefs.setString('feed_token', value!).then((value) => saved());
}
/**
 * 저장된 토큰 갖구오기
 */
Future<GetClientCredentialsGrantDto> getFeedCredentiaksGrant()async{
  SharedPreferences _prefs = await SharedPreferences.getInstance();
  GetClientCredentialsGrantDto data = GetClientCredentialsGrantDto();
  data.access_token = _prefs.getString('feed_token');
  return data ;
}