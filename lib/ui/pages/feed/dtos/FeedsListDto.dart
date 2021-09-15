import 'package:json_annotation/json_annotation.dart';

import 'FeedsItemDto.dart';

part 'FeedsListDto.g.dart';

@JsonSerializable ()
class FeedsListDto {

  bool? result;
  int? statusCode;
  String? message;
  FeedsData? data;

  FeedsListDto({
    this.result,
    this.statusCode,
    this.message,
    this.data
  });

  factory FeedsListDto.fromJson (Map<String, dynamic> json) => _$FeedsListDtoFromJson (json);
  Map<String, dynamic> toJson () => _$FeedsListDtoToJson (this);

}


@JsonSerializable ()
class FeedsData {

  int? totalCount;
  List<FeedsItemDto>? articles;

  FeedsData({
    this.totalCount,
    this.articles
  });

  factory FeedsData.fromJson (Map<String, dynamic> json) => _$FeedsDataFromJson (json);
  Map<String, dynamic> toJson () => _$FeedsDataToJson (this);

}

@JsonSerializable ()
class FeedsListRequestBody {

  int? media_idx;
  int? page;
  int? per_page;

  FeedsListRequestBody({
    this.media_idx,
    this.page,
    this.per_page
  });

  factory FeedsListRequestBody.fromJson (Map<String, dynamic> json) => _$FeedsListRequestBodyFromJson (json);
  Map<String, dynamic> toJson () => _$FeedsListRequestBodyToJson (this);

}