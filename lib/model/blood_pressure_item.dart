
class BloodPressureItem{
  int?    id            ;       //자동증가
  String? rData          ;       //등록일
  String? saveData       ;       //저장날짜(시간까지 됨)
  int?    systolic       ;       //수축
  int?    diastole       ;       //확장
  int?    pulse          ;       //심박수
  String? memo           ;       //메모
  String? dayOfTheWeek   ;       //요일코드
  int?    registeredType ;       //타입 1 : 수기 2 기기입력
  int?    temperature    ;       //온도
  String? weatherImg  ;       //날씨 아미지
  String? weatherTemp  ;      //날씨 온도
  String? weatherInfo  ;      //날씨 정보
  int?    sendServerYM ;      //서버에 데이터에 전송되었는지 안되었는지 체크

  //서버에 필요한 데이터
  int? user_id ; //유저 아이디



  BloodPressureItem({
    this.id,
    this.rData ,
    this.saveData ,
    this.systolic ,
    this.diastole ,
    this.pulse ,
    this.memo ,
    this.dayOfTheWeek ,
    this.registeredType,
    this.temperature,
    this.weatherImg,
    this.weatherTemp,
    this.weatherInfo,
    this.sendServerYM,

    this.user_id,
  });

  Map<String, dynamic> toMap(){
    return <String, dynamic>{
      'id'             : id ,
      'rData'          : rData ,
      'saveData'       : saveData ,
      'systolic'       : systolic ,
      'diastole'       : diastole ,
      'pulse'          : pulse ,
      'memo'           : memo ,
      'dayOfTheWeek'   : dayOfTheWeek ,
      'registeredType' : registeredType,
      'temperature'    : temperature,
      'weatherImg'     : weatherImg,
      'weatherTemp'    : weatherTemp,
      'weatherInfo'    : weatherInfo,
      'sendServerYM'   : sendServerYM,
      'user_id'        : user_id
    };
  }

}