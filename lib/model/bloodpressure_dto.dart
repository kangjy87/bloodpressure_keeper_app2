import 'package:json_annotation/json_annotation.dart';
part 'bloodpressure_dto.g.dart';

@JsonSerializable ()
class BloodPressureDto{
  int? id ;
  int? user_id ;
  String? date ;
  int? diastolic ;
  int? systolic ;
  int? heart ;
  String? memo ;
  double? temperature ;
  String? weather ;
  String? address_depth1 ;
  String? address_depth2 ;
  String? address_depth3 ;
  String? updated_at ;
  String? created_at ;

  BloodPressureDto({
    this.id,
    this.user_id,
    this.date,
    this.diastolic,
    this.systolic,
    this.heart,
    this.memo,
    this.temperature,
    this.weather,
    this.address_depth1,
    this.address_depth2,
    this.address_depth3,
    this.updated_at,
    this.created_at
  });

  factory BloodPressureDto.fromJson(Map<String, dynamic> json) => _$BloodPressureDtoFromJson(json);
  Map<String, dynamic> toJson() => _$BloodPressureDtoToJson(this);
}

@JsonSerializable ()
class SendBloodPressureDto{
  List<BloodPressureDto>?  blood_pressure ;
  SendBloodPressureDto({
    this.blood_pressure
  });

  factory SendBloodPressureDto.fromJson(Map<String, dynamic> json) => _$SendBloodPressureDtoFromJson(json);
  Map<String, dynamic> toJson() => _$SendBloodPressureDtoToJson(this);
}

@JsonSerializable ()
class GetBloodPressureDto{
  bool? result ;
  int? statusCode ;
  String? message ;
  List<BloodPressureDto>? data ;
  GetBloodPressureDto({
    this.result,
    this.statusCode,
    this.message,
    this.data
  });
  factory GetBloodPressureDto.fromJson(Map<String, dynamic> json) => _$GetBloodPressureDtoFromJson(json);
  Map<String, dynamic> toJson() => _$GetBloodPressureDtoToJson(this);
}

@JsonSerializable ()
class GetBloodPressureDto2{
  bool? result ;
  int? statusCode ;
  String? message ;
  BloodPressureDto? data ;
  GetBloodPressureDto2({
    this.result,
    this.statusCode,
    this.message,
    this.data
  });
  factory GetBloodPressureDto2.fromJson(Map<String, dynamic> json) => _$GetBloodPressureDto2FromJson(json);
  Map<String, dynamic> toJson() => _$GetBloodPressureDto2ToJson(this);
}