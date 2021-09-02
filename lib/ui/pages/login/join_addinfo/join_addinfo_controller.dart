import 'package:bloodpressure_keeper_app/model/client_credentials_grant_dto.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:bloodpressure_keeper_app/ui/routes/app_routes.dart';
import 'package:bloodpressure_keeper_app/retrofit/blood_pressure_server.dart';
import 'package:bloodpressure_keeper_app/model/users_dto.dart';
import 'package:bloodpressure_keeper_app/retrofit/tdi_servers.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:bloodpressure_keeper_app/utils/shared_preferences_info/get_client_credentials_grant.dart';
import 'package:bloodpressure_keeper_app/utils/shared_preferences_info/login_info.dart';
import 'package:intl/intl.dart';

class JoinAddInfoController extends GetxController {
  String firstTitle = "", secondTitle= "" ;
  int pagerIndex = 0 ;
  TextEditingController txtNickname = TextEditingController() ;

  @override
  void onInit() {
    super.onInit();
    firstPage();
  }

  pageChange(){
    pagerIndex = pagerIndex == 0 ? 1 : 0 ;
    switch(pagerIndex){
      case 0 :
        firstPage();
        break ;
      case 1 :
        if(nickNameCheck()){
          secondPage();
        }
        break ;
    }
  }
  bool nickNameCheck(){
    if(txtNickname.text == ""){
      pagerIndex = 0 ;
      Fluttertoast.showToast(
          msg: "닉네임을 입력해주세요.",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Color(0xff454f63),
          textColor: Colors.red,
          fontSize: 16.0
      );
      update();
      return false ;
    }
    return true ;
  }
  firstPage(){
    firstTitle = "닉네임을 알려주세요." ;
    secondTitle = " 따뜻하고 친절하게 닉네임을 불러드릴게요! " ;
    update();
  }

  secondPage(){
    firstTitle = "당신을 알려주세요";
    secondTitle = "맞춤 혈압정보를 알려드릴께요";
    update();
  }


  int sexCheckIndex = 3 ;
  TextEditingController txtAge = TextEditingController() ;
  radioBtnChange(int index){
    sexCheckIndex = index ;
    update();
  }

  userInfoAgreement(){
    Get.toNamed(AppRoutes.UserInfoAgreement);
  }

  bool ageCheck(){
    if(txtAge.text.length != 4){
      Fluttertoast.showToast(
          msg: "잘못된 출생년도 입니다.",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Color(0xff454f63),
          textColor: Colors.red,
          fontSize: 16.0
      );
      update();
      return false ;
    }else if(int.parse(txtAge.text) < 1900){
      Fluttertoast.showToast(
          msg: "잘못된 출생년도 입니다.",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Color(0xff454f63),
          textColor: Colors.red,
          fontSize: 16.0
      );
      update();
      return false ;
    }else if(int.parse(txtAge.text) > int.parse(DateFormat('yyyy').format(DateTime.now()))){
      Fluttertoast.showToast(
          msg: "잘못된 출생년도 입니다.",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Color(0xff454f63),
          textColor: Colors.red,
          fontSize: 16.0
      );
      update();
      return false ;
    }
    return true ;
  }
  joinMembership(String nickName,String gender, String age,Function save)async{
    if(ageCheck()){
      GetClientCredentialsGrantDto gcDto = await getClientCredentiaksGrant();
      String appKey = "Bearer ${gcDto.access_token}" ;

      UsersDto usersDto = await getUserInfo();

      await FirebaseMessaging.instance.getToken().then((fcmToken){
        TdiServers(bloodPressureServer: (BloodPressureServer bps) async {
          print('키값>>>>>>>>>>>>>>>>>>>>$fcmToken');
          print('닉네임>>>>>>>>>>>>>>>>>>>>$nickName');
          print('성별>>>>>>>>>>>>>>>>>>>>$gender');
          print('나이>>>>>>>>>>>>>>>>>>>>$age');
          print('키>>>>>>>>>>>>>>>>>>>>${usersDto.uuid}');
          print('구분>>>>>>>>>>>>>>>>>>>>${usersDto.provider}');
          print('멜>>>>>>>>>>>>>>>>>>>>${usersDto.email}');
          UsersDto task = UsersDto();
          task.uuid = usersDto.uuid ;
          task.provider =  usersDto.provider ;
          task.email = usersDto.email ;
          task.fcm_token = fcmToken ;
          task.nickname = nickName ;
          task.gender = gender ;
          task.age = age ;
          final resp = await bps.UsersInfo(appKey, task);
          print('저장된값>>>>>>>>>>>>>>>>>>>>>>>>>${resp.data!.id}');
          if(resp.data != null){
            setUserAddInfo(nickName, gender, age, (){
              print('저장이 완료');
              save.call();
            });
          }
        });
      });
    }
  }
}