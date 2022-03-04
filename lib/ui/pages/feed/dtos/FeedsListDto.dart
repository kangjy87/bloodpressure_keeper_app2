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




@JsonSerializable ()
class FavoriteListDto {
  bool? result;
  int? statusCode;
  String? message;
  FavoriteData? data;

  FavoriteListDto({
    this.result,
    this.statusCode,
    this.message,
    this.data
  });

  factory FavoriteListDto.fromJson (Map<String, dynamic> json) => _$FavoriteListDtoFromJson (json);
  Map<String, dynamic> toJson () => _$FavoriteListDtoToJson (this);
}

@JsonSerializable ()
class FavoriteData {

  int? totalCount;
  List<FavoriteItemDto>? favorites;

  FavoriteData({
    this.totalCount,
    this.favorites
  });

  factory FavoriteData.fromJson (Map<String, dynamic> json) => _$FavoriteDataFromJson (json);
  Map<String, dynamic> toJson () => _$FavoriteDataToJson (this);

}

@JsonSerializable ()
class FavoriteItemDto {

  int? id;
  int? media_id;
  String? user_id;
  int? article_id;
  int? group_id ;
  DateTime? created_at;
  DateTime? updated_at;
  bool? is_like ;
  FavoriteGroup? favorite_group ;
  FeedsItemDto? article;

  FavoriteItemDto ({
    this.id,
    this.media_id,
    this.user_id,
    this.article_id,
    this.group_id,
    this.created_at,
    this.updated_at,
    this.is_like,
    this.favorite_group,
    this.article
  });

  factory FavoriteItemDto.fromJson (Map<String, dynamic> json) => _$FavoriteItemDtoFromJson (json);
  Map<String, dynamic> toJson () => _$FavoriteItemDtoToJson (this);

}

@JsonSerializable ()
class FavoriteGroup{
  int? id ;
  int? media_id ;
  String? user_id ;
  String? group_name ;
  String? created_at ;
  String? updated_at ;
  FavoriteGroup({
    this.id,
    this.media_id,
    this.user_id,
    this.group_name,
    this.created_at,
    this.updated_at,
  });
  factory FavoriteGroup.fromJson(Map<String, dynamic> json) => _$FavoriteGroupFromJson(json);
  Map<String, dynamic> toJson() => _$FavoriteGroupToJson(this);
}
