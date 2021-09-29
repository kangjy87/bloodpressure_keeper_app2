import 'package:json_annotation/json_annotation.dart';

part 'FeedsItemDto.g.dart';

@JsonSerializable ()
class FeedsItemDto {

  int? id;
  int? media_id;
  String? platform;
  String? type;
  String? keyword;
  String? channel;
  String? article_owner_id;
  String? url;
  String? title;
  String? contents;
  String? storage_thumbnail_url;
  String? thumbnail_url;
  int? thumbnail_width;
  int? thumbnail_height;
  String? hashtag;
  int? state;
  DateTime? date;
  ArticleOwnerDto? article_owner;
  ArticleDetail? article_detail;
  List<ArticleMediaItemDto>? article_medias;
  bool? is_favorite ;


  FeedsItemDto({
    this.id,
    this.media_id,
    this.platform,
    this.type,
    this.keyword,
    this.channel,
    this.article_owner_id,
    this.url, this.title,
    this.contents,
    this.storage_thumbnail_url,
    this.thumbnail_url,
    this.thumbnail_width,
    this.thumbnail_height,
    this.hashtag,
    this.state,
    this.date,
    this.article_owner,
    this.article_detail,
    this.article_medias,
    this.is_favorite
  });

  factory FeedsItemDto.fromJson (Map<String, dynamic> json) => _$FeedsItemDtoFromJson (json);
  Map<String, dynamic>  toJson () => _$FeedsItemDtoToJson (this);

}


@JsonSerializable ()
class ArticleMediaItemDto {

  int? id;
  int? article_id;
  String? type;
  String? storage_url;
  String? url;
  int? width;
  int? height;

  ArticleMediaItemDto({
    this.id,
    this.article_id,
    this.type = "",
    this.storage_url = "",
    this.url, this.width,
    this.height
  });

  factory ArticleMediaItemDto.fromJson (Map<String, dynamic> json) => _$ArticleMediaItemDtoFromJson (json);
  Map<String, dynamic> toJson () => _$ArticleMediaItemDtoToJson (this);

}


@JsonSerializable ()
class ArticleOwnerDto {

  String? id;
  String? platform;
  String? url;
  String? name;
  String? storage_thumbnail_url;
  String? thumbnail_url;
  int? thumbnail_width;
  int? thumbnail_height;

  DateTime? created_at;
  DateTime? updated_at;

  ArticleOwnerDto ({
    this.id,
    this.platform,
    this.url,
    this.name,
    this.storage_thumbnail_url,
    this.thumbnail_url,
    this.thumbnail_width,
    this.thumbnail_height,
    this.created_at,
    this.updated_at
  });

  factory ArticleOwnerDto.fromJson (Map<String, dynamic> json) => _$ArticleOwnerDtoFromJson (json);
  Map<String, dynamic> toJson () => _$ArticleOwnerDtoToJson (this);

}


@JsonSerializable ()
class ArticleDetail {
  int? id;
  int? article_id;
  int? like;
  int? dislike;
  int? report;

  ArticleDetail ({
    this.id,
    this.article_id,
    this.like,
    this.dislike,
    this.report
  });

  factory ArticleDetail.fromJson (Map<String, dynamic> json) => _$ArticleDetailFromJson (json);
  Map<String, dynamic> toJson () => _$ArticleDetailToJson (this);
}