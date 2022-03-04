
class FeedFavoriteGroupsAddDto {
  bool? result;
  int? statusCode;
  String? message;
  Data? data;

  FeedFavoriteGroupsAddDto(
      {this.result, this.statusCode, this.message, this.data});

  FeedFavoriteGroupsAddDto.fromJson(Map<String, dynamic> json) {
    result = json['result'];
    statusCode = json['statusCode'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['result'] = this.result;
    data['statusCode'] = this.statusCode;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  int? mediaId;
  String? userId;
  String? groupName;
  String? updatedAt;
  String? createdAt;
  int? id;

  Data(
      {this.mediaId,
        this.userId,
        this.groupName,
        this.updatedAt,
        this.createdAt,
        this.id});

  Data.fromJson(Map<String, dynamic> json) {
    mediaId = json['media_id'];
    userId = json['user_id'];
    groupName = json['group_name'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['media_id'] = this.mediaId;
    data['user_id'] = this.userId;
    data['group_name'] = this.groupName;
    data['updated_at'] = this.updatedAt;
    data['created_at'] = this.createdAt;
    data['id'] = this.id;
    return data;
  }
}