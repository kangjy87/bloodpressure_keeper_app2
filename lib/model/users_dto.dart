import 'package:json_annotation/json_annotation.dart';
part 'users_dto.g.dart';

@JsonSerializable ()
class UsersDto{
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

  UsersDto({
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

  factory UsersDto.fromJson(Map<String, dynamic> json) => _$UsersDtoFromJson(json);
  Map<String, dynamic> toJson() => _$UsersDtoToJson(this);
}

@JsonSerializable ()
class GetUsersDto{
  bool? result ;
  int? statusCode ;
  String? message ;
  UsersDto? data ;
  GetUsersDto({
    this.result,
    this.statusCode,
    this.message,
    this.data
  });
  factory GetUsersDto.fromJson(Map<String, dynamic> json) => _$GetUsersDtoFromJson(json);
  Map<String, dynamic> toJson() => _$GetUsersDtoToJson(this);
}