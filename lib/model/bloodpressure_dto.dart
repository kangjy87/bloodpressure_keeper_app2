import 'package:json_annotation/json_annotation.dart';
part 'bloodpressure_dto.g.dart';

@JsonSerializable ()
class BloodPressureDto{
  int? id ;
  String? uuid ;
  String? nickname ;
  String? gender ;
  String? age ;
  String? email ;
  String? provider ;
  String? fcm_token ;
  String? os_type ;
  String? model ;
  String? os_version ;
  String? ad_id ;
  String? created_at ;
  String? updated_at ;
  String? access_token ;

  BloodPressureDto({
    this.id,
    this.uuid,
    this.nickname,
    this.gender,
    this.age,
    this.email,
    this.provider,
    this.fcm_token,
    this.os_type,
    this.model,
    this.os_version,
    this.ad_id,
    this.created_at,
    this.updated_at,
    this.access_token,
  });

  factory BloodPressureDto.fromJson(Map<String, dynamic> json) => _$BloodPressureDtoFromJson(json);
  Map<String, dynamic> toJson() => _$BloodPressureDtoToJson(this);
}

@JsonSerializable ()
class GetBloodPressureDto{
  bool? result ;
  int? statusCode ;
  String? message ;
  BloodPressureDto? data ;
  GetBloodPressureDto({
    this.result,
    this.statusCode,
    this.message,
    this.data
  });
  factory GetBloodPressureDto.fromJson(Map<String, dynamic> json) => _$GetBloodPressureDtoFromJson(json);
  Map<String, dynamic> toJson() => _$GetBloodPressureDtoToJson(this);
}