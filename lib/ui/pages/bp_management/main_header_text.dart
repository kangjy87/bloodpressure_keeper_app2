
import 'dart:math';
import 'package:bloodpressure_keeper_app/model/blood_pressure_item.dart';
import 'package:bloodpressure_keeper_app/model/bloodpressure_dto.dart';
import 'package:bloodpressure_keeper_app/model/bp_standard_model.dart';


//toDayBPData null latelyDatacheck true  7일이전 오늘 혈압 측정안함
//toDayBPData null latelyDatacheck false 7일이후
//toDayBPData 있음                        오늘
/**
 * 데이터가 아예 없을 경우                      0
 * 7일 이후 데이터만 있는 경우                  1
 * 7일이전 데이터는 있지만 오늘 데이터가 없을때      2
 * 오늘 데이터가 있을 경우                     3
 */
Future<String> getHeaderText(BloodPressureDto? toDayBPData,int? typeCheck)async{
  String strReturn = "";
  List<String> selectList = [];
  switch(typeCheck){
    //데이터가 아예 없을 경우
    case 0 :
      selectList = <String>[
        '반가워요~🖐\n저는 당신만의 건강매니저예요!\n오늘의 혈압을 기록해주세요. ',
      ];
      break ;
    //7일 이후 데이터만 있는 경우
    case 1 :
      selectList = <String>[
        '왜이렇게 오랜만에 오셨어요!😯\n혈압관리는 꾸준함이 중요해요.\n오늘의 혈압을 입력해주세요~',
        '조금 귀찮더라도 매일 기록해주세요.\n당신이 아프면 속상해요😰\n혈압건강 챙기기 약속해요!'
      ];
      break ;
    //7일이전 데이터는 있지만 오늘 데이터가 없을때
    case 2 :
      selectList = <String>[
        '반가워요~🖐\n저는 당신만의 건강매니저예요!\n오늘의 혈압을 기록해주세요. ',
        '오늘 혈압 아직 기록하지 않았네요.\n혈압 관리는 꾸준함이 중요해요!👀'
      ];
      break ;
    //오늘 데이터가 있을 경우
    case 3 :
      if(toDayBPData !=  null){
        BPStandardModel bpRiskLevel =  BPStandardModel();
        await bpRiskLevel.getStandardData(toDayBPData.systolic!, toDayBPData.diastolic!);
        bpRiskLevel.bpSituation;

        int bpcode = bpRiskLevel.situationCode ;
        String bpcode2 = bpRiskLevel.bpSituation ;
        print('개발>>>>>>>>>>>>>>>${bpcode2}>>>>>>>>>>>>>>>>${bpcode}');
        switch(bpcode){
        //데이터없음
          case 0 :

            selectList = <String>[
              '반가워요~🖐\n저는 당신만의 건강매니저예요!\n오늘의 혈압을 기록해주세요. ',
              '오늘 혈압 아직 기록하지 않았네요.\n혈압 관리는 꾸준함이 중요해요!👀'
            ];

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
      break ;
  }
  int randomkey = Random().nextInt(selectList.length) ;
  strReturn = selectList[randomkey];
  return strReturn ;
}