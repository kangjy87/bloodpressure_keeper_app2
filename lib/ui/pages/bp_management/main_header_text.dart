
import 'dart:math';
import 'package:bloodpressure_keeper_app/model/blood_pressure_item.dart';
import 'package:bloodpressure_keeper_app/model/bp_standard_model.dart';

Future<String> getHeaderText(BloodPressureItem? toDayBPData,bool? latelyDatacheck)async{
  String strReturn = "";
  List<String> selectList = [];
  if(toDayBPData == null){
    if(latelyDatacheck == true){
      selectList = <String>[
        '반가워요~🖐\n저는 당신만의 혈압매니저예요!\n오늘의 혈압을 기록해주세요. ',
        '오늘 혈압 아직 기록하지 않았네요.\n혈압 관리는 꾸준함이 중요해요!👀'
      ];
    }else{
      selectList = <String>[
        '왜이렇게 오랜만에 오셨어요!😯\n혈압관리는 꾸준함이 중요해요.\n오늘의 혈압을 입력해주세요~',
        '조금 귀찮더라도 매일 기록해주세요.\n당신이 아프면 속상해요😰\n혈압건강 챙기기 약속해요!'
      ];
    }
  }else{
    BPStandardModel bpRiskLevel =  BPStandardModel();
    await bpRiskLevel.getStandardData(toDayBPData.systolic!, toDayBPData.diastole!);
    bpRiskLevel.bpSituation;

    int bpcode = bpRiskLevel.situationCode ;
    String bpcode2 = bpRiskLevel.bpSituation ;
    print('개발>>>>>>>>>>>>>>>${bpcode2}>>>>>>>>>>>>>>>>${bpcode}');
    switch(bpcode){
    //데이터없음
      case 0 :
        if(latelyDatacheck == false){
          selectList = <String>[
            '반가워요~🖐\n저는 당신만의 혈압매니저예요!\n오늘의 혈압을 기록해주세요. ',
            '오늘 혈압 아직 기록하지 않았네요.\n혈압 관리는 꾸준함이 중요해요!👀'
          ];
        }else{
          selectList = <String>[
            '왜이렇게 오랜만에 오셨어요!😯\n혈압관리는 꾸준함이 중요해요.\n오늘의 혈압을 입력해주세요~',
            '조금 귀찮더라도 매일 기록해주세요.\n당신이 아프면 속상해요😰\n혈압건강 챙기기 약속해요!'
          ];
        }
        break ;
    //정상혈압
      case 1 :
        selectList = <String>[
          '오늘 혈압 아주 좋아요! 👍\n건강한 식단으로 혈압건강 유지해요!'
        ];
        break ;
    //주의혈압
      case 2 :
        selectList = <String>[
          '오늘 혈압 주의가 필요해요😥\n짠 음식 주의!!!'
        ];
        break ;
    //고혈압 전단계
      case 3 :
        selectList = <String>[
          '오늘 혈압 빨간불🔴\n스트레스는 혈압의 적!\n심호흡 한번 할까요?',
          '오늘 혈압이 좋지않아요😱\n가볍게 산책 30분 어때요?\n적당한 운동은 혈압건강에 필수!',
          '오늘 혈압이 좋지않아요😱\n싱겁게 먹고 술과 담배는 피해주세요.\n전 당신이 늘 건강하길 바란답니다!'
        ];
        break ;
    //1기 고혈압
      case 4 :
        selectList = <String>[
          '오늘 혈압 빨간불🔴\n스트레스는 혈압의 적! 심호흡 한번 할까요?',
          '오늘 혈압이 좋지않아요😱\n가볍게 산책 30분 어때요?\n적당한 운동은 혈압건강에 필수예요!',
          '오늘 혈압이 좋지않아요😱\n싱겁게 먹고 술과 담배는 피해주세요.\n전 당신이 늘 건강하길 바란답니다!'
        ];
        break ;
    //2기 고혈압
      case 5 :
        selectList = <String>[
          '오늘 혈압 빨간불🔴\n스트레스는 혈압의 적! 심호흡 한번 할까요?',
          '오늘 혈압이 좋지않아요😱\n가볍게 산책 30분 어때요?\n적당한 운동은 혈압건강에 필수예요!',
          '오늘 혈압이 좋지않아요😱\n싱겁게 먹고 술과 담배는 피해주세요.\n전 당신이 늘 건강하길 바란답니다!'
        ];
        break ;
    //수축기단독고혈압
      case 6 :
        selectList = <String>[
          '오늘 혈압 빨간불🔴\n스트레스는 혈압의 적! 심호흡 한번 할까요?',
          '오늘 혈압이 좋지않아요😱\n가볍게 산책 30분 어때요?\n적당한 운동은 혈압건강에 필수예요!',
          '오늘 혈압이 좋지않아요😱\n싱겁게 먹고 술과 담배는 피해주세요.\n전 당신이 늘 건강하길 바란답니다!'
        ];
        break ;
    }
  }
  int randomkey = selectList.length-1 ;
  strReturn = selectList[randomkey];
  return strReturn ;
}