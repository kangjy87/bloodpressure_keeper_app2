import 'package:json_annotation/json_annotation.dart';

part 'AuthErrorDto.g.dart';

@JsonSerializable ()
class AuthErrorDto {

  String? error;
  String? error_description;
  String? hint;
  String? message;

  AuthErrorDto ({
    this.error,
    this.error_description,
    this.hint,
    this.message
  });

  factory AuthErrorDto.fromJson(Map<String, dynamic> json) => _$AuthErrorDtoFromJson(json);
  Map<String, dynamic> toJson ()=> _$AuthErrorDtoToJson(this);

}