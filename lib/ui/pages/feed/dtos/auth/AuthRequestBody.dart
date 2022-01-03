import 'package:json_annotation/json_annotation.dart';

part 'AuthRequestBody.g.dart';

@JsonSerializable ()
class AuthRequestBody {

  String? grant_type;
  String? client_id;
  String? client_secret;


  AuthRequestBody ({
    this.grant_type = 'client_credentials',
    this.client_id = '9403d49b-dba2-4dbe-87b1-0001de30125d',
    this.client_secret = 'wIh5A7aLmEYl4Mdk85Jrey8xjsKmMxfSmJ8BLg3s'
  });


  factory AuthRequestBody.fromJson(Map<String, dynamic> json) => _$AuthRequestBodyFromJson(json);
  Map<String, dynamic> toJson ()=> _$AuthRequestBodyToJson(this);
}
