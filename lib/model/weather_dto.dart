import 'package:json_annotation/json_annotation.dart';

part 'weather_dto.g.dart';

@JsonSerializable()
class WeatherDto{
  AirInfo airInfo;
  WeatherInfo weatherInfo;
  List<WeatherForecast> weatherForecast;
  WeatherMidForecast weatherMidForecast;
  WeatherMidLandForecast weatherMidLandForecast;

  WeatherDto({required this.airInfo, required this.weatherInfo, required this.weatherForecast, required this.weatherMidForecast, required this.weatherMidLandForecast});

  factory WeatherDto.fromJson(Map<String, dynamic> json) => _$WeatherDtoFromJson(json);

  Map<String, dynamic> toJson() => _$WeatherDtoToJson(this);
}

@JsonSerializable()
class AirInfo{
  String dataTime = "";
  String sidoName = "";
  String cityName = "";
  double so2Value = 0;
  double coValue = 0;
  double o3Value = 0;
  double no2Value = 0;
  int pm10Value = 0;
  int pm25Value = 0;
  int timestamp = 0;

  AirInfo(
      this.dataTime,
      this.sidoName,
      this.cityName,
      this.so2Value,
      this.coValue,
      this.o3Value,
      this.no2Value,
      this.pm10Value,
      this.pm25Value,
      this.timestamp);

  factory AirInfo.fromJson(Map<String, dynamic> json) => _$AirInfoFromJson(json);

  Map<String, dynamic> toJson() => _$AirInfoToJson(this);
}

@JsonSerializable()
class WeatherInfo{
  String dataTime = "";
  String sidoName = "";
  String cityName = "";
  int t1h = 0;
  int rn1 = 0;
  double uuu = 0;
  double vvv = 0;
  int reh = 0;
  int pty = 0;
  int vec = 0;
  int wsd = 0;
  int sky = 0;
  int lgt = 0;
  int timestamp = 0;

  WeatherInfo(
      this.dataTime,
      this.sidoName,
      this.cityName,
      this.t1h,
      this.rn1,
      this.uuu,
      this.vvv,
      this.reh,
      this.pty,
      this.vec,
      this.wsd,
      this.sky,
      this.lgt,
      this.timestamp);

  factory WeatherInfo.fromJson(Map<String, dynamic> json) => _$WeatherInfoFromJson(json);

  Map<String, dynamic> toJson() => _$WeatherInfoToJson(this);
}

@JsonSerializable()
class WeatherForecast{
  String dataTime = "";
  String sidoName = "";
  String cityName = "";
  int pop = 0;
  int pty = 0;
  int r06 = 0;
  int reh = 0;
  int s06 = 0;
  int sky = 0;
  int t3h = 0;
  int tmn = 0;
  int tmx = 0;
  double uuu = 0;
  double vvv = 0;
  int wav = 0;
  int vec = 0;
  double wsd = 0;
  int timestamp = 0;

  WeatherForecast(
      this.dataTime,
      this.sidoName,
      this.cityName,
      this.pop,
      this.pty,
      this.r06,
      this.reh,
      this.s06,
      this.sky,
      this.t3h,
      this.tmn,
      this.tmx,
      this.uuu,
      this.vvv,
      this.wav,
      this.vec,
      this.wsd,
      this.timestamp);

  factory WeatherForecast.fromJson(Map<String, dynamic> json) => _$WeatherForecastFromJson(json);

  Map<String, dynamic> toJson() => _$WeatherForecastToJson(this);
}

@JsonSerializable()
class WeatherMidForecast{
  String dataTime = "";
  String sidoName = "";
  String cityName = "";
  int taMin3 = 0;
  int taMin3Low = 0;
  int taMin3High = 0;
  int taMax3 = 0;
  int taMax3Low = 0;
  int taMax3High = 0;

  int taMin4 = 0;
  int taMin4Low = 0;
  int taMin4High = 0;
  int taMax4 = 0;
  int taMax4Low = 0;
  int taMax4High = 0;

  int taMin5 = 0;
  int taMin5Low = 0;
  int taMin5High = 0;
  int taMax5 = 0;
  int taMax5Low = 0;
  int taMax5High = 0;

  int taMin6 = 0;
  int taMin6Low = 0;
  int taMin6High = 0;
  int taMax6 = 0;
  int taMax6Low = 0;
  int taMax6High = 0;

  int taMin7 = 0;
  int taMin7Low = 0;
  int taMin7High = 0;
  int taMax7 = 0;
  int taMax7Low = 0;
  int taMax7High = 0;

  int taMin8 = 0;
  int taMin8Low = 0;
  int taMin8High = 0;
  int taMax8 = 0;
  int taMax8Low = 0;
  int taMax8High = 0;

  int taMin9 = 0;
  int taMin9Low = 0;
  int taMin9High = 0;
  int taMax9 = 0;
  int taMax9Low = 0;
  int taMax9High = 0;

  int taMin10 = 0;
  int taMin10Low = 0;
  int taMin10High = 0;
  int taMax10 = 0;
  int taMax10Low = 0;
  int taMax10High = 0;
  int timestamp = 0;


  WeatherMidForecast(
      this.dataTime,
      this.sidoName,
      this.cityName,
      this.taMin3,
      this.taMin3Low,
      this.taMin3High,
      this.taMax3,
      this.taMax3Low,
      this.taMax3High,
      this.taMin4,
      this.taMin4Low,
      this.taMin4High,
      this.taMax4,
      this.taMax4Low,
      this.taMax4High,
      this.taMin5,
      this.taMin5Low,
      this.taMin5High,
      this.taMax5,
      this.taMax5Low,
      this.taMax5High,
      this.taMin6,
      this.taMin6Low,
      this.taMin6High,
      this.taMax6,
      this.taMax6Low,
      this.taMax6High,
      this.taMin7,
      this.taMin7Low,
      this.taMin7High,
      this.taMax7,
      this.taMax7Low,
      this.taMax7High,
      this.taMin8,
      this.taMin8Low,
      this.taMin8High,
      this.taMax8,
      this.taMax8Low,
      this.taMax8High,
      this.taMin9,
      this.taMin9Low,
      this.taMin9High,
      this.taMax9,
      this.taMax9Low,
      this.taMax9High,
      this.taMin10,
      this.taMin10Low,
      this.taMin10High,
      this.taMax10,
      this.taMax10Low,
      this.taMax10High,
      this.timestamp);

  factory WeatherMidForecast.fromJson(Map<String, dynamic> json) => _$WeatherMidForecastFromJson(json);

  Map<String, dynamic> toJson() => _$WeatherMidForecastToJson(this);
}

@JsonSerializable()
class WeatherMidLandForecast{
  String dataTime = "";
  String region = "";
  int rnSt3Am = 0;
  int rnSt3Pm = 0;
  int rnSt4Am = 0;
  int rnSt4Pm = 0;
  int rnSt5Am = 0;
  int rnSt5Pm = 0;
  int rnSt6Am = 0;
  int rnSt6Pm = 0;
  int rnSt7Am = 0;
  int rnSt7Pm = 0;
  int rnSt8 = 0;
  int rnSt9 = 0;
  int rnSt10 = 0;
  String wf3Am = "";
  String wf3Pm = "";
  String wf4Am = "";
  String wf4Pm = "";
  String wf5Am = "";
  String wf5Pm = "";
  String wf6Am = "";
  String wf6Pm = "";
  String wf7Am = "";
  String wf7Pm = "";
  String wf8 = "";
  String wf9 = "";
  String wf10 = "";
  int timestamp = 0;

  WeatherMidLandForecast(
      this.dataTime,
      this.region,
      this.rnSt3Am,
      this.rnSt3Pm,
      this.rnSt4Am,
      this.rnSt4Pm,
      this.rnSt5Am,
      this.rnSt5Pm,
      this.rnSt6Am,
      this.rnSt6Pm,
      this.rnSt7Am,
      this.rnSt7Pm,
      this.rnSt8,
      this.rnSt9,
      this.rnSt10,
      this.wf3Am,
      this.wf3Pm,
      this.wf4Am,
      this.wf4Pm,
      this.wf5Am,
      this.wf5Pm,
      this.wf6Am,
      this.wf6Pm,
      this.wf7Am,
      this.wf7Pm,
      this.wf8,
      this.wf9,
      this.wf10,
      this.timestamp);

  factory WeatherMidLandForecast.fromJson(Map<String, dynamic> json) => _$WeatherMidLandForecastFromJson(json);

  Map<String, dynamic> toJson() => _$WeatherMidLandForecastToJson(this);
}