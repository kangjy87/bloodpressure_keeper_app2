import 'package:json_annotation/json_annotation.dart';

import 'FeedsItemDto.dart';
part 'LikesDto.g.dart';

@JsonSerializable ()
class LikesResultDto {
  bool? result;
  int? statusCode;
  String? message;
  LikesDto? data;

  LikesResultDto({
    this.result,
    this.statusCode,
    this.message,
    this.data
  });

  factory LikesResultDto.fromJson (Map<String, dynamic> json) => _$LikesResultDtoFromJson (json);
  Map<String, dynamic> toJson () => _$LikesResultDtoToJson (this);

}

@JsonSerializable ()
class LikesDto {
  int? media_id;
  int? article_id;
  String? behavior_type;
  String? user_id;
  int? id ;
  int? like ;
  int? dislike ;
  int? report ;

  LikesDto({
    this.media_id,
    this.article_id,
    this.behavior_type,
    this.user_id,
    this.id,
    this.like,
    this.dislike,
    this.report
  });

  factory LikesDto.fromJson (Map<String, dynamic> json) => _$LikesDtoFromJson (json);
  Map<String, dynamic> toJson () => _$LikesDtoToJson (this);

}