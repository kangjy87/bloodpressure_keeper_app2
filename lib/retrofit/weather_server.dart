import 'dart:convert';
import 'package:bloodpressure_keeper_app/model/weather_dto.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';

part 'weather_server.g.dart';

@RestApi(baseUrl: "https://appservice9.com")
abstract class WeatherServer {
  factory WeatherServer(Dio dio, {String baseUrl}) = _WeatherServer;

  @GET("/api/v1/weathers")
  @Utf8Codec()
  Future<WeatherDto> getCurrentWeather(
      @Query('sidoName') String sidoName,
      @Query('cityName') String cityName);
}