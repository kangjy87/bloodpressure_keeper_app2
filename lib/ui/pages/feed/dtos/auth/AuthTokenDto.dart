import 'package:json_annotation/json_annotation.dart';

part 'AuthTokenDto.g.dart';

@JsonSerializable ()
class AuthTokenDto {

  String? token_type;
  int? expires_in;
  String? access_token;

  AuthTokenDto ({
    this.token_type,
    this.expires_in,
    this.access_token
  });


  factory AuthTokenDto.fromJson(Map<String, dynamic> json) => _$AuthTokenDtoFromJson(json);
  Map<String, dynamic> toJson ()=> _$AuthTokenDtoToJson(this);


  //토큰 내놓으슈.
  // String getToken () {
  //   return (token_type != null && access_token != null) ? "$token_type $access_token" : "None";
  // }
  String getToken () {
    return (token_type != null && access_token != null) ? "$access_token" : "None";
  }
}
