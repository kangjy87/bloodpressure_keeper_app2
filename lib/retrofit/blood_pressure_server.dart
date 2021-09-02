import 'dart:convert';
import 'package:bloodpressure_keeper_app/model/client_credentials_grant_dto.dart';
import 'package:bloodpressure_keeper_app/model/users_dto.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';

part 'blood_pressure_server.g.dart';

@RestApi(baseUrl:"https://blood-pressure.tdi9.com")
abstract class BloodPressureServer {
  factory BloodPressureServer(Dio dio,{String baseUrl}) = _BloodPressureServer ;

  @POST("/oauth/token")
  @Utf8Codec()
  Future<GetClientCredentialsGrantDto> clientCredentialsGrant(
      @Body() SetClientCredentialsGrantDto task
      );

  @POST("/api/v1/users")
  @Utf8Codec()
  Future<GetUsersDto> UsersInfo(
      @Header('Authorization') authorization,
      @Body() UsersDto task
      );
}