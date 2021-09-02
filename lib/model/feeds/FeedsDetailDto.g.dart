// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'FeedsDetailDto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FeedsDetailDto _$FeedsDetailDtoFromJson(Map<String, dynamic> json) {
  return FeedsDetailDto(
    result: json['result'] as bool?,
    statusCode: json['statusCode'] as int?,
    message: json['message'] as String?,
    data: json['data'] == null
        ? null
        : FeedsItemDto.fromJson(json['data'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$FeedsDetailDtoToJson(FeedsDetailDto instance) =>
    <String, dynamic>{
      'result': instance.result,
      'statusCode': instance.statusCode,
      'message': instance.message,
      'data': instance.data,
    };
