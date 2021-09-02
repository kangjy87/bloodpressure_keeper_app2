// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'client_credentials_grant_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetClientCredentialsGrantDto _$GetClientCredentialsGrantDtoFromJson(
    Map<String, dynamic> json) {
  return GetClientCredentialsGrantDto(
    token_type: json['token_type'] as String?,
    expires_in: json['expires_in'] as int?,
    access_token: json['access_token'] as String?,
  );
}

Map<String, dynamic> _$GetClientCredentialsGrantDtoToJson(
        GetClientCredentialsGrantDto instance) =>
    <String, dynamic>{
      'token_type': instance.token_type,
      'expires_in': instance.expires_in,
      'access_token': instance.access_token,
    };

SetClientCredentialsGrantDto _$SetClientCredentialsGrantDtoFromJson(
    Map<String, dynamic> json) {
  return SetClientCredentialsGrantDto(
    grant_type: json['grant_type'] as String?,
    client_id: json['client_id'] as String?,
    client_secret: json['client_secret'] as String?,
    scope: json['scope'] as String?,
  );
}

Map<String, dynamic> _$SetClientCredentialsGrantDtoToJson(
        SetClientCredentialsGrantDto instance) =>
    <String, dynamic>{
      'grant_type': instance.grant_type,
      'client_id': instance.client_id,
      'client_secret': instance.client_secret,
      'scope': instance.scope,
    };
