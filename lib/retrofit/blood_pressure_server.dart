import 'dart:convert';
import 'package:bloodpressure_keeper_app/model/blood_pressure_item.dart';
import 'package:bloodpressure_keeper_app/model/bloodpressure_dto.dart';
import 'package:bloodpressure_keeper_app/model/client_credentials_grant_dto.dart';
import 'package:bloodpressure_keeper_app/model/users_dto.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';

part 'blood_pressure_server.g.dart';

@RestApi(baseUrl:"https://blood-pressure.tdi9.com")
abstract class BloodPressureServer {
  factory BloodPressureServer(Dio dio,{String baseUrl}) = _BloodPressureServer ;

  //TDI 서버 인증 토큰 받기
  @POST("/oauth/token")
  @Utf8Codec()
  Future<GetClientCredentialsGrantDto> clientCredentialsGrant(
      @Body() SetClientCredentialsGrantDto task
      );

  //유저로그인, 회원가입
  @POST("/api/v1/users")
  @Utf8Codec()
  Future<GetUsersDto> UsersInfo(
      @Header('Authorization') authorization,
      @Body() UsersDto task
      );


  //혈압등록하기
  @POST("/api/v1/blood_pressure")
  @Utf8Codec()
  Future<GetBloodPressureDto> BloodPressureInsert(
      @Header('Authorization') authorization,
      @Body() BloodPressureDto task
      );

  //혈압수정하기
  @POST("/api/v1/blood_pressure/{id}")
  @Utf8Codec()
  Future<GetBloodPressureDto> BloodPressureUpdate(
      @Path ('id') String id,
      @Body() BloodPressureDto task
      );
}