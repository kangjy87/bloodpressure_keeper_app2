// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'FeedsItemDto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FeedsItemDto _$FeedsItemDtoFromJson(Map<String, dynamic> json) {
  return FeedsItemDto(
    id: json['id'] as int?,
    media_id: json['media_id'] as int?,
    platform: json['platform'] as String?,
    type: json['type'] as String?,
    keyword: json['keyword'] as String?,
    channel: json['channel'] as String?,
    article_owner_id: json['article_owner_id'] as String?,
    url: json['url'] as String?,
    title: json['title'] as String?,
    contents: json['contents'] as String?,
    storage_thumbnail_url: json['storage_thumbnail_url'] as String?,
    thumbnail_url: json['thumbnail_url'] as String?,
    thumbnail_width: json['thumbnail_width'] as int?,
    thumbnail_height: json['thumbnail_height'] as int?,
    hashtag: json['hashtag'] as String?,
    state: json['state'] as int?,
    date: json['date'] == null ? null : DateTime.parse(json['date'] as String),
    article_owner: json['article_owner'] == null
        ? null
        : ArticleOwnerDto.fromJson(
            json['article_owner'] as Map<String, dynamic>),
    article_medias: (json['article_medias'] as List<dynamic>?)
        ?.map((e) => ArticleMediaItemDto.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$FeedsItemDtoToJson(FeedsItemDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'media_id': instance.media_id,
      'platform': instance.platform,
      'type': instance.type,
      'keyword': instance.keyword,
      'channel': instance.channel,
      'article_owner_id': instance.article_owner_id,
      'url': instance.url,
      'title': instance.title,
      'contents': instance.contents,
      'storage_thumbnail_url': instance.storage_thumbnail_url,
      'thumbnail_url': instance.thumbnail_url,
      'thumbnail_width': instance.thumbnail_width,
      'thumbnail_height': instance.thumbnail_height,
      'hashtag': instance.hashtag,
      'state': instance.state,
      'date': instance.date?.toIso8601String(),
      'article_owner': instance.article_owner,
      'article_medias': instance.article_medias,
    };

ArticleMediaItemDto _$ArticleMediaItemDtoFromJson(Map<String, dynamic> json) {
  return ArticleMediaItemDto(
    id: json['id'] as int?,
    article_id: json['article_id'] as int?,
    type: json['type'] as String?,
    storage_url: json['storage_url'] as String?,
    url: json['url'] as String?,
    width: json['width'] as int?,
    height: json['height'] as int?,
  );
}

Map<String, dynamic> _$ArticleMediaItemDtoToJson(
        ArticleMediaItemDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'article_id': instance.article_id,
      'type': instance.type,
      'storage_url': instance.storage_url,
      'url': instance.url,
      'width': instance.width,
      'height': instance.height,
    };

ArticleOwnerDto _$ArticleOwnerDtoFromJson(Map<String, dynamic> json) {
  return ArticleOwnerDto(
    id: json['id'] as int?,
    platform: json['platform'] as String?,
    url: json['url'] as String?,
    name: json['name'] as String?,
    storage_thumbnail_url: json['storage_thumbnail_url'] as String?,
    thumbnail_url: json['thumbnail_url'] as String?,
    thumbnail_width: json['thumbnail_width'] as int?,
    thumbnail_height: json['thumbnail_height'] as int?,
    created_at: json['created_at'] == null
        ? null
        : DateTime.parse(json['created_at'] as String),
    updated_at: json['updated_at'] == null
        ? null
        : DateTime.parse(json['updated_at'] as String),
  );
}

Map<String, dynamic> _$ArticleOwnerDtoToJson(ArticleOwnerDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'platform': instance.platform,
      'url': instance.url,
      'name': instance.name,
      'storage_thumbnail_url': instance.storage_thumbnail_url,
      'thumbnail_url': instance.thumbnail_url,
      'thumbnail_width': instance.thumbnail_width,
      'thumbnail_height': instance.thumbnail_height,
      'created_at': instance.created_at?.toIso8601String(),
      'updated_at': instance.updated_at?.toIso8601String(),
    };
