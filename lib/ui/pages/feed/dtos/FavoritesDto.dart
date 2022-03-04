import 'package:json_annotation/json_annotation.dart';

import 'FeedsItemDto.dart';
part 'FavoritesDto.g.dart';

@JsonSerializable ()
class FavoritesResultDto {
  bool? result;
  int? statusCode;
  String? message;
  FavoritesDto? data;

  FavoritesResultDto({
    this.result,
    this.statusCode,
    this.message,
    this.data
  });

  factory FavoritesResultDto.fromJson (Map<String, dynamic> json) => _$FavoritesResultDtoFromJson (json);
  Map<String, dynamic> toJson () => _$FavoritesResultDtoToJson (this);

}

@JsonSerializable ()
class FavoritesDto {
  int? media_id;
  String? user_id;
  int? article_id;
  String? updated_at;
  String? created_at ;
  int? id ;
  int? group_id ;

  FavoritesDto({
    this.media_id,
    this.user_id,
    this.article_id,
    this.updated_at,
    this.created_at,
    this.id,
    this.group_id
  });

  factory FavoritesDto.fromJson (Map<String, dynamic> json) => _$FavoritesDtoFromJson (json);
  Map<String, dynamic> toJson () => _$FavoritesDtoToJson (this);

}