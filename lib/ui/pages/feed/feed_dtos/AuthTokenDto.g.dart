// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'AuthTokenDto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AuthTokenDto _$AuthTokenDtoFromJson(Map<String, dynamic> json) {
  return AuthTokenDto(
    token_type: json['token_type'] as String?,
    expires_in: json['expires_in'] as int?,
    access_token: json['access_token'] as String?,
  );
}

Map<String, dynamic> _$AuthTokenDtoToJson(AuthTokenDto instance) =>
    <String, dynamic>{
      'token_type': instance.token_type,
      'expires_in': instance.expires_in,
      'access_token': instance.access_token,
    };
