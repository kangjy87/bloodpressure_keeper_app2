import 'package:bloodpressure_keeper_app/model/users_dto.dart';
import 'package:bloodpressure_keeper_app/utils/shared_preferences_info/login_info.dart';
import 'package:flutter/material.dart';

class BPStandardModel{
  final int NONPressureData = 0 ; //데이터없음
  final int BP1 = 1 ; //정상혈
  final int BP2 = 2; //압주의혈
  final int BP3 = 3 ; //고혈압 전단계
  final int BP4 = 4 ; //1기 고혈압
  final int BP5 = 5 ; //2기 고혈압
  final int BP6 = 6 ; //압수축기단독고혈압
  // final int Hypotension = 1 ; //저혈압
  // final int Normal = 2; //정상
  // final int Prehypertension = 3 ; //고혈압 전단계
  // final int HighBloodPressure = 4 ; //고혈압
  // final int Stage1Hypertension = 5 ; //1기 고혈압
  // final int Stage2Hypertension = 6 ; //2기 고혈압
  // final int HighHighBloodPressure = 7 ; //높은 고혈압

  /**
   * 최고 최저 혈압을 넣어서  현상태와 컬러코드는 받아온다.
   * @param systolic
   * @param diastole
   * @return BPStandardModel
   */
  // getStandardData(int systolic, int diastole){
  //   print('최저>>>>>>>>>>>>>>>>>>>>!!!!!!!!!!!!!!!!!!!!!!!!!!$systolic');
  //   if(systolic == 0 && diastole == 0){
  //     setBPCode(0);
  //   }else{
  //     int systolicCheck = getStandardSystolic(systolic) ;
  //     int diastoleCheck = getStandardDiastole(diastole) ;
  //     print('systolicCheck>>>>>>>>>>>>>>>>>>>>!!!!!!!!!!!!!!!!!!!!!!!!!!$systolicCheck');
  //     print('diastoleCheck>>>>>>>>>>>>>>>>>>>>!!!!!!!!!!!!!!!!!!!!!!!!!!$diastoleCheck');
  //     setBPCode((systolicCheck >= diastoleCheck ? systolicCheck : diastoleCheck));
  //   }
  // }

  getStandardData(int systolic, int diastole){
    int returnBP = 0 ;
    print('@@@@@@@@@>>>>>>>>>>>${systolic}@@@@@@<<<<<<<<<<<<<<<<<${diastole}');
    //없음
    if(systolic == 0 || diastole == 0) {
      returnBP = NONPressureData;
    }
    //정상혈압
    else if(systolic < 120 && diastole < 80){
      returnBP = BP1 ;
    }
    //주의 혈압
    else if((systolic >= 120 && systolic < 129) && diastole < 80){
      returnBP = BP2 ;
    }
    //고혈압 전단계
    else if((systolic >= 130 && systolic < 139) || (diastole >= 80 && diastole < 89)){
      returnBP = BP3 ;
    }
    //고혈압 1기
    else if((systolic >= 140 && systolic < 159) || (diastole >= 90 && diastole < 99)){
      returnBP = BP4 ;
    }
    //고혈압 2기
    else if((systolic >= 160) || (diastole >= 100)){
      returnBP = BP5 ;
    }
    //수축기단독고혈압
    else if((systolic >= 140) || (diastole < 90)){
      returnBP = BP6 ;
    }else{
      returnBP = BP6 ;
    }
    setBPCode(returnBP);
  }
  /**
   * 최저혈압
   * @param diastole
   * @return
   */
  int getStandardDiastole(int diastole){
    //정상혈압
    if(diastole < 120){
      return BP1 ;
    }
    //주의혈압
    else if(diastole <= 129){
      return BP2 ;
    }
    //고혈압전단계
    else if(diastole <= 139){
      return BP3 ;
    }
    //1기 고혈압
    else if(diastole <= 159){
      return BP4 ;
    }
    //2기 고혈압
    else if(diastole <= 160){
      return BP5 ;
    }
    //입력데이터 없음
    else if(diastole == 777){
      return NONPressureData ;
    }
    //수축기단독고혈압
    else{
      return BP6 ;
    }

  }
  /**
   * 최고 혈압체크
   */
  int getStandardSystolic(int systolic){
    //저혈압
    if(systolic <= 90){
      return BP1 ;
    }
    //정상
    else if(systolic <= 120){
      return BP2 ;
    }
    //고혈압 전단계
    else if(systolic <= 140){
      return BP3 ;
    }
    //1기 고혈압
    else if(systolic <= 160){
      return BP4 ;
    }
    //2기 고혈압
    else if(systolic >= 180){
      return BP5 ;
    }
    //입력데이터 없음
    else if(systolic == 777){
      return NONPressureData ;
    }
    //높은 혈압
    else{
      return BP6 ;
    }
  }

  Color colorCode = Color(0xff3dd598) ;
  String bpSituation = '정상' ;
  int situationCode = 2 ;
  String situationMsg = "" ;
  setBPCode(int code)async{
    UsersDto usersDto = await getUserInfo();
    switch (code){
      case 1 :
        situationCode = BP1 ;
        bpSituation = '정상혈압' ;
        situationMsg = "${usersDto.nickname}님의 혈압 상태는 정상입니다" ;
        colorCode = Color(0xff3dd598) ;
        break;

      case 2 :
        situationCode = BP2 ;
        bpSituation = '주의혈압' ;
        situationMsg = "${usersDto.nickname}님은, 혈압에 주의가 필요한 단계입니다" ;
        colorCode = Color(0xff57b8fd) ;
        break;

      case 3 :
        situationCode = BP3 ;
        bpSituation = '고혈압 전단계' ;
        situationMsg = "${usersDto.nickname}님은 현재 고혈압 전단계입니다" ;
        colorCode = Color(0xfff2ac5c) ;
        break;

      case 4 :
        situationCode = BP4 ;
        bpSituation = '1기 고혈압' ;
        situationMsg = "${usersDto.nickname}님은 현재 1단계 고혈압입니다" ;
        colorCode = Color(0xfff25f5c) ;
        break;

      case 5 :
        situationCode = BP5 ;
        bpSituation = '2기 고혈압' ;
        situationMsg = "${usersDto.nickname}님은 현재 2단계 고혈압입니다" ;
        colorCode = Color(0xffe62622) ;
        break;

      case 6:
        situationCode = BP6 ;
        bpSituation = '수축기 단독 고혈압' ;
        situationMsg = "${usersDto.nickname}님은 수축기 단독 고혈압입니다" ;
        colorCode = Color(0xffb65cf2) ;
        break;

      case 0:
        situationCode = NONPressureData ;
        bpSituation = '미체크 상태' ;
        situationMsg = "측정된 혈압이 없습니다." ;
        colorCode = Color(0xff747474) ;
        break;

    }
  }
}