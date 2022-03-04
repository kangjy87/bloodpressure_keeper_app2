
import 'package:json_annotation/json_annotation.dart';
part 'set_add_favorite_groups.g.dart';

@JsonSerializable ()
class SetAddFavoriteGroups{
  int? media_id ;
  String? user_id ;
  String? group ;
  SetAddFavoriteGroups({
    this.media_id ,
    this.user_id ,
    this.group
  });

  factory SetAddFavoriteGroups.fromJson(Map<String, dynamic> json) => _$SetAddFavoriteGroupsFromJson(json);
  Map<String, dynamic> toJson() => _$SetAddFavoriteGroupsToJson(this);
}