import 'package:json_annotation/json_annotation.dart';
part 'get_favorite_groups_dto.g.dart';

@JsonSerializable ()
class GetFavoriteGroup{
  bool? result ;
  int? statusCode ;
  String? message ;
  GetFavoriteGroupList? data ;

  GetFavoriteGroup({
    this.result,
    this.statusCode,
    this.message,
    this.data,
  });

  factory GetFavoriteGroup.fromJson(Map<String, dynamic> json) => _$GetFavoriteGroupFromJson(json);
  Map<String, dynamic> toJson() => _$GetFavoriteGroupToJson(this);
}

@JsonSerializable ()
class GetFavoriteGroupList{
  int? totalCount ;
  List<FavoriteGroups>? favoriteGroups ;
  GetFavoriteGroupList({
    this.totalCount,
    this.favoriteGroups,
  });
  factory GetFavoriteGroupList.fromJson(Map<String, dynamic> json) => _$GetFavoriteGroupListFromJson(json);
  Map<String, dynamic> toJson() => _$GetFavoriteGroupListToJson(this);
}

@JsonSerializable ()
class FavoriteGroups{
  int? id ;
  int? media_id ;
  String? user_id ;
  String? group_name ;
  String? created_at ;
  String? updated_at ;
  int? favorite_count ;
  FavoriteGroups({
    this.id,
    this.media_id,
    this.user_id,
    this.group_name,
    this.created_at,
    this.updated_at,
    this.favorite_count,
  });
  factory FavoriteGroups.fromJson(Map<String, dynamic> json) => _$FavoriteGroupsFromJson(json);
  Map<String, dynamic> toJson() => _$FavoriteGroupsToJson(this);
}