import 'package:json_annotation/json_annotation.dart';

part 'CommonDto.g.dart';

@JsonSerializable ()
class ResultDto {
  String? code;
  String? message;

  ResultDto ({
    this.code,
    this.message
  });


  factory ResultDto.fromJson(Map<String, dynamic> json) => _$ResultDtoFromJson(json);
  Map<String, dynamic> toJson ()=> _$ResultDtoToJson(this);
}

@JsonSerializable ()
class CommonHeader {

  final String? Authrization;

  CommonHeader({
    this.Authrization
  });

  factory CommonHeader.fromJson (Map<String, dynamic> json) => _$CommonHeaderFromJson (json);
  Map<String, dynamic> toJson () => _$CommonHeaderToJson (this);

}