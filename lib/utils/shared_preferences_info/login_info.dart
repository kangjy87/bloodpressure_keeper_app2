import 'package:shared_preferences/shared_preferences.dart';
import 'package:bloodpressure_keeper_app/model/users_dto.dart';
/**
 * 토큰저장
 */
void setUserInfo(String? uuid, String? email, String provider, Function saved)async{
  SharedPreferences _prefs = await SharedPreferences.getInstance();
  _prefs.setString('provider', (provider == null ? "" : provider));
  _prefs.setString('email', (email == null ? "" : email));
  _prefs.setString('uuid',(uuid == null ? "" : uuid)).then((value) => saved());
}
/**
 * 추가정보
 */
void setUserAddInfo(String? nickName, String? gender, String? age,int id, Function saved)async{
  SharedPreferences _prefs = await SharedPreferences.getInstance();
  _prefs.setString('nickName', (nickName == null ? "" : nickName));
  _prefs.setInt('id', id);
  _prefs.setString('gender', (gender == null ? "" : gender));
  _prefs.setString('age', (age == null ? "" : age)).then((value) => saved());
}
/**
 * 저장된 토큰 갖구오기
 */
Future<UsersDto> getUserInfo()async{
  SharedPreferences _prefs = await SharedPreferences.getInstance();
  UsersDto data = UsersDto();
  data.uuid = _prefs.getString('uuid');
  data.email = _prefs.getString('email');
  data.provider = _prefs.getString('provider');
  data.nickname = _prefs.getString('nickName');
  data.gender = _prefs.getString('gender');
  data.age = _prefs.getString('age');
  data.id= _prefs.getInt('id');
  return data ;
}

/**
 * 클린
 */
void setUserClaer(Function saved)async{
  SharedPreferences _prefs = await SharedPreferences.getInstance();
  _prefs.setString('provider', "");
  _prefs.setString('email',  "");
  _prefs.setString('uuid', "");
  _prefs.setString('nickName',  "");
  _prefs.setString('gender',  "");
  _prefs.setString('age',  "").then((value) => saved());
}