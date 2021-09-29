class BloodPressureChartDto {
  int?    position       ;      //리스트 순서
  String? checkData      ;      //측정한 날짜
  String? checkFullData  ;      //측정한 날짜(풀데이터)
  int?    systolic       ;      //수축
  int?    diastole       ;      //확장
  int?    pulse          ;      //심박수

  BloodPressureChartDto({this.position, this.checkData,this.checkFullData, this.systolic, this.diastole, this.pulse});
}