// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'users_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UsersDto _$UsersDtoFromJson(Map<String, dynamic> json) {
  return UsersDto(
    id: json['id'] as int?,
    uuid: json['uuid'] as String?,
    nickname: json['nickname'] as String?,
    gender: json['gender'] as String?,
    age: json['age'] as String?,
    email: json['email'] as String?,
    provider: json['provider'] as String?,
    fcm_token: json['fcm_token'] as String?,
    os_type: json['os_type'] as String?,
    model: json['model'] as String?,
    os_version: json['os_version'] as String?,
    ad_id: json['ad_id'] as String?,
    created_at: json['created_at'] as String?,
    updated_at: json['updated_at'] as String?,
    access_token: json['access_token'] as String?,
  );
}

Map<String, dynamic> _$UsersDtoToJson(UsersDto instance) => <String, dynamic>{
      'id': instance.id,
      'uuid': instance.uuid,
      'nickname': instance.nickname,
      'gender': instance.gender,
      'age': instance.age,
      'email': instance.email,
      'provider': instance.provider,
      'fcm_token': instance.fcm_token,
      'os_type': instance.os_type,
      'model': instance.model,
      'os_version': instance.os_version,
      'ad_id': instance.ad_id,
      'created_at': instance.created_at,
      'updated_at': instance.updated_at,
      'access_token': instance.access_token,
    };

GetUsersDto _$GetUsersDtoFromJson(Map<String, dynamic> json) {
  return GetUsersDto(
    result: json['result'] as bool?,
    statusCode: json['statusCode'] as int?,
    message: json['message'] as String?,
    data: json['data'] == null
        ? null
        : UsersDto.fromJson(json['data'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$GetUsersDtoToJson(GetUsersDto instance) =>
    <String, dynamic>{
      'result': instance.result,
      'statusCode': instance.statusCode,
      'message': instance.message,
      'data': instance.data,
    };
