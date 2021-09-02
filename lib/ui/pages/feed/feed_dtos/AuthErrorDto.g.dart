// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'AuthErrorDto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AuthErrorDto _$AuthErrorDtoFromJson(Map<String, dynamic> json) {
  return AuthErrorDto(
    error: json['error'] as String?,
    error_description: json['error_description'] as String?,
    hint: json['hint'] as String?,
    message: json['message'] as String?,
  );
}

Map<String, dynamic> _$AuthErrorDtoToJson(AuthErrorDto instance) =>
    <String, dynamic>{
      'error': instance.error,
      'error_description': instance.error_description,
      'hint': instance.hint,
      'message': instance.message,
    };
