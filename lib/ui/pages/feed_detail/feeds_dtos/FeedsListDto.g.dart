// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'FeedsListDto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FeedsListDto _$FeedsListDtoFromJson(Map<String, dynamic> json) {
  return FeedsListDto(
    result: json['result'] as bool?,
    statusCode: json['statusCode'] as int?,
    message: json['message'] as String?,
    data: json['data'] == null
        ? null
        : FeedsData.fromJson(json['data'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$FeedsListDtoToJson(FeedsListDto instance) =>
    <String, dynamic>{
      'result': instance.result,
      'statusCode': instance.statusCode,
      'message': instance.message,
      'data': instance.data,
    };

FeedsData _$FeedsDataFromJson(Map<String, dynamic> json) {
  return FeedsData(
    totalCount: json['totalCount'] as int?,
    articles: (json['articles'] as List<dynamic>?)
        ?.map((e) => FeedsItemDto.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$FeedsDataToJson(FeedsData instance) => <String, dynamic>{
      'totalCount': instance.totalCount,
      'articles': instance.articles,
    };

FeedsListRequestBody _$FeedsListRequestBodyFromJson(Map<String, dynamic> json) {
  return FeedsListRequestBody(
    media_idx: json['media_idx'] as int?,
    page: json['page'] as int?,
    per_page: json['per_page'] as int?,
  );
}

Map<String, dynamic> _$FeedsListRequestBodyToJson(
        FeedsListRequestBody instance) =>
    <String, dynamic>{
      'media_idx': instance.media_idx,
      'page': instance.page,
      'per_page': instance.per_page,
    };
