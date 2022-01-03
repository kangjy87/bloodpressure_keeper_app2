import 'package:json_annotation/json_annotation.dart';

import 'FeedsItemDto.dart';
part 'FeedsDetailDto.g.dart';

@JsonSerializable ()
class FeedsDetailDto {

  bool? result;
  int? statusCode;
  String? message;
  FeedsItemDto? data;

  FeedsDetailDto({
    this.result,
    this.statusCode,
    this.message,
    this.data
  });

  factory FeedsDetailDto.fromJson (Map<String, dynamic> json) => _$FeedsDetailDtoFromJson (json);
  Map<String, dynamic> toJson () => _$FeedsDetailDtoToJson (this);

}