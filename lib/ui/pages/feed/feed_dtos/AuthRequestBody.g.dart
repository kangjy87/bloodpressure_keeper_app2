// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'AuthRequestBody.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AuthRequestBody _$AuthRequestBodyFromJson(Map<String, dynamic> json) {
  return AuthRequestBody(
    grant_type: json['grant_type'] as String?,
    client_id: json['client_id'] as String?,
    client_secret: json['client_secret'] as String?,
  );
}

Map<String, dynamic> _$AuthRequestBodyToJson(AuthRequestBody instance) =>
    <String, dynamic>{
      'grant_type': instance.grant_type,
      'client_id': instance.client_id,
      'client_secret': instance.client_secret,
    };
