import 'package:json_annotation/json_annotation.dart';
part 'client_credentials_grant_dto.g.dart';

@JsonSerializable ()
class GetClientCredentialsGrantDto{
  String? token_type ;
  int? expires_in ;
  String? access_token ;

  GetClientCredentialsGrantDto({
    this.token_type,
    this.expires_in,
    this.access_token,
  });

  factory GetClientCredentialsGrantDto.fromJson(Map<String, dynamic> json) => _$GetClientCredentialsGrantDtoFromJson(json);
  Map<String, dynamic> toJson() => _$GetClientCredentialsGrantDtoToJson(this);
}

@JsonSerializable ()
class SetClientCredentialsGrantDto{
  String? grant_type ;
  String? client_id ;
  String? client_secret ;
  String? scope ;
  SetClientCredentialsGrantDto({
    this.grant_type,
    this.client_id,
    this.client_secret,
    this.scope
  });
  factory SetClientCredentialsGrantDto.fromJson(Map<String, dynamic> json) => _$SetClientCredentialsGrantDtoFromJson(json);
  Map<String, dynamic> toJson() => _$SetClientCredentialsGrantDtoToJson(this);
}