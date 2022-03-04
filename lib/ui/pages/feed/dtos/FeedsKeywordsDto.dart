import 'package:json_annotation/json_annotation.dart';

part 'FeedsKeywordsDto.g.dart';

@JsonSerializable ()
class FeedsKeywordsListDto{
  bool? result;
  int? statusCode;
  String? message;
  FeedsKeywordsDataDto? data ;

  FeedsKeywordsListDto({
    this.result,
    this.statusCode,
    this.message,
    this.data
  });

  factory FeedsKeywordsListDto.fromJson (Map<String, dynamic> json) => _$FeedsKeywordsListDtoFromJson (json);
  Map<String, dynamic>  toJson () => _$FeedsKeywordsListDtoToJson (this);
}

@JsonSerializable ()
class FeedsKeywordsDataDto{
  int? totalCount ;
  List<KeywordsDto>? keywords ;

  FeedsKeywordsDataDto({
    this.totalCount,
    this.keywords
  });

  factory FeedsKeywordsDataDto.fromJson (Map<String, dynamic> json) => _$FeedsKeywordsDataDtoFromJson (json);
  Map<String, dynamic>  toJson () => _$FeedsKeywordsDataDtoToJson (this);
}

@JsonSerializable ()
class KeywordsDto{
  int? id ;
  int? media_id ;
  String? keyword ;
  String? platform ;
  String? topic ;
  int? state ;
  String? created_at ;
  String? updated_at ;

  KeywordsDto({
    this.id,
    this.media_id,
    this.keyword,
    this.platform,
    this.topic,
    this.state,
    this.created_at,
    this.updated_at
  });

  factory KeywordsDto.fromJson (Map<String, dynamic> json) => _$KeywordsDtoFromJson (json);
  Map<String, dynamic>  toJson () => _$KeywordsDtoToJson (this);
}