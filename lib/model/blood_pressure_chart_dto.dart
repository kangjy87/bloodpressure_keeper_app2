class BloodPressureChartDto {
  int?    position       ;      //리스트 순서
  String? checkData      ;      //측정한 날짜
  int?    systolic       ;      //수축
  int?    diastole       ;      //확장
  int?    pulse          ;      //심박수

  BloodPressureChartDto({this.position, this.checkData, this.systolic, this.diastole, this.pulse});
}