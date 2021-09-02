// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'weather_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WeatherDto _$WeatherDtoFromJson(Map<String, dynamic> json) {
  return WeatherDto(
    airInfo: AirInfo.fromJson(json['airInfo'] as Map<String, dynamic>),
    weatherInfo:
        WeatherInfo.fromJson(json['weatherInfo'] as Map<String, dynamic>),
    weatherForecast: (json['weatherForecast'] as List<dynamic>)
        .map((e) => WeatherForecast.fromJson(e as Map<String, dynamic>))
        .toList(),
    weatherMidForecast: WeatherMidForecast.fromJson(
        json['weatherMidForecast'] as Map<String, dynamic>),
    weatherMidLandForecast: WeatherMidLandForecast.fromJson(
        json['weatherMidLandForecast'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$WeatherDtoToJson(WeatherDto instance) =>
    <String, dynamic>{
      'airInfo': instance.airInfo,
      'weatherInfo': instance.weatherInfo,
      'weatherForecast': instance.weatherForecast,
      'weatherMidForecast': instance.weatherMidForecast,
      'weatherMidLandForecast': instance.weatherMidLandForecast,
    };

AirInfo _$AirInfoFromJson(Map<String, dynamic> json) {
  return AirInfo(
    json['dataTime'] as String,
    json['sidoName'] as String,
    json['cityName'] as String,
    (json['so2Value'] as num).toDouble(),
    (json['coValue'] as num).toDouble(),
    (json['o3Value'] as num).toDouble(),
    (json['no2Value'] as num).toDouble(),
    json['pm10Value'] as int,
    json['pm25Value'] as int,
    json['timestamp'] as int,
  );
}

Map<String, dynamic> _$AirInfoToJson(AirInfo instance) => <String, dynamic>{
      'dataTime': instance.dataTime,
      'sidoName': instance.sidoName,
      'cityName': instance.cityName,
      'so2Value': instance.so2Value,
      'coValue': instance.coValue,
      'o3Value': instance.o3Value,
      'no2Value': instance.no2Value,
      'pm10Value': instance.pm10Value,
      'pm25Value': instance.pm25Value,
      'timestamp': instance.timestamp,
    };

WeatherInfo _$WeatherInfoFromJson(Map<String, dynamic> json) {
  return WeatherInfo(
    json['dataTime'] as String,
    json['sidoName'] as String,
    json['cityName'] as String,
    json['t1h'] as int,
    json['rn1'] as int,
    (json['uuu'] as num).toDouble(),
    (json['vvv'] as num).toDouble(),
    json['reh'] as int,
    json['pty'] as int,
    json['vec'] as int,
    json['wsd'] as int,
    json['sky'] as int,
    json['lgt'] as int,
    json['timestamp'] as int,
  );
}

Map<String, dynamic> _$WeatherInfoToJson(WeatherInfo instance) =>
    <String, dynamic>{
      'dataTime': instance.dataTime,
      'sidoName': instance.sidoName,
      'cityName': instance.cityName,
      't1h': instance.t1h,
      'rn1': instance.rn1,
      'uuu': instance.uuu,
      'vvv': instance.vvv,
      'reh': instance.reh,
      'pty': instance.pty,
      'vec': instance.vec,
      'wsd': instance.wsd,
      'sky': instance.sky,
      'lgt': instance.lgt,
      'timestamp': instance.timestamp,
    };

WeatherForecast _$WeatherForecastFromJson(Map<String, dynamic> json) {
  return WeatherForecast(
    json['dataTime'] as String,
    json['sidoName'] as String,
    json['cityName'] as String,
    json['pop'] as int,
    json['pty'] as int,
    json['r06'] as int,
    json['reh'] as int,
    json['s06'] as int,
    json['sky'] as int,
    json['t3h'] as int,
    json['tmn'] as int,
    json['tmx'] as int,
    (json['uuu'] as num).toDouble(),
    (json['vvv'] as num).toDouble(),
    json['wav'] as int,
    json['vec'] as int,
    (json['wsd'] as num).toDouble(),
    json['timestamp'] as int,
  );
}

Map<String, dynamic> _$WeatherForecastToJson(WeatherForecast instance) =>
    <String, dynamic>{
      'dataTime': instance.dataTime,
      'sidoName': instance.sidoName,
      'cityName': instance.cityName,
      'pop': instance.pop,
      'pty': instance.pty,
      'r06': instance.r06,
      'reh': instance.reh,
      's06': instance.s06,
      'sky': instance.sky,
      't3h': instance.t3h,
      'tmn': instance.tmn,
      'tmx': instance.tmx,
      'uuu': instance.uuu,
      'vvv': instance.vvv,
      'wav': instance.wav,
      'vec': instance.vec,
      'wsd': instance.wsd,
      'timestamp': instance.timestamp,
    };

WeatherMidForecast _$WeatherMidForecastFromJson(Map<String, dynamic> json) {
  return WeatherMidForecast(
    json['dataTime'] as String,
    json['sidoName'] as String,
    json['cityName'] as String,
    json['taMin3'] as int,
    json['taMin3Low'] as int,
    json['taMin3High'] as int,
    json['taMax3'] as int,
    json['taMax3Low'] as int,
    json['taMax3High'] as int,
    json['taMin4'] as int,
    json['taMin4Low'] as int,
    json['taMin4High'] as int,
    json['taMax4'] as int,
    json['taMax4Low'] as int,
    json['taMax4High'] as int,
    json['taMin5'] as int,
    json['taMin5Low'] as int,
    json['taMin5High'] as int,
    json['taMax5'] as int,
    json['taMax5Low'] as int,
    json['taMax5High'] as int,
    json['taMin6'] as int,
    json['taMin6Low'] as int,
    json['taMin6High'] as int,
    json['taMax6'] as int,
    json['taMax6Low'] as int,
    json['taMax6High'] as int,
    json['taMin7'] as int,
    json['taMin7Low'] as int,
    json['taMin7High'] as int,
    json['taMax7'] as int,
    json['taMax7Low'] as int,
    json['taMax7High'] as int,
    json['taMin8'] as int,
    json['taMin8Low'] as int,
    json['taMin8High'] as int,
    json['taMax8'] as int,
    json['taMax8Low'] as int,
    json['taMax8High'] as int,
    json['taMin9'] as int,
    json['taMin9Low'] as int,
    json['taMin9High'] as int,
    json['taMax9'] as int,
    json['taMax9Low'] as int,
    json['taMax9High'] as int,
    json['taMin10'] as int,
    json['taMin10Low'] as int,
    json['taMin10High'] as int,
    json['taMax10'] as int,
    json['taMax10Low'] as int,
    json['taMax10High'] as int,
    json['timestamp'] as int,
  );
}

Map<String, dynamic> _$WeatherMidForecastToJson(WeatherMidForecast instance) =>
    <String, dynamic>{
      'dataTime': instance.dataTime,
      'sidoName': instance.sidoName,
      'cityName': instance.cityName,
      'taMin3': instance.taMin3,
      'taMin3Low': instance.taMin3Low,
      'taMin3High': instance.taMin3High,
      'taMax3': instance.taMax3,
      'taMax3Low': instance.taMax3Low,
      'taMax3High': instance.taMax3High,
      'taMin4': instance.taMin4,
      'taMin4Low': instance.taMin4Low,
      'taMin4High': instance.taMin4High,
      'taMax4': instance.taMax4,
      'taMax4Low': instance.taMax4Low,
      'taMax4High': instance.taMax4High,
      'taMin5': instance.taMin5,
      'taMin5Low': instance.taMin5Low,
      'taMin5High': instance.taMin5High,
      'taMax5': instance.taMax5,
      'taMax5Low': instance.taMax5Low,
      'taMax5High': instance.taMax5High,
      'taMin6': instance.taMin6,
      'taMin6Low': instance.taMin6Low,
      'taMin6High': instance.taMin6High,
      'taMax6': instance.taMax6,
      'taMax6Low': instance.taMax6Low,
      'taMax6High': instance.taMax6High,
      'taMin7': instance.taMin7,
      'taMin7Low': instance.taMin7Low,
      'taMin7High': instance.taMin7High,
      'taMax7': instance.taMax7,
      'taMax7Low': instance.taMax7Low,
      'taMax7High': instance.taMax7High,
      'taMin8': instance.taMin8,
      'taMin8Low': instance.taMin8Low,
      'taMin8High': instance.taMin8High,
      'taMax8': instance.taMax8,
      'taMax8Low': instance.taMax8Low,
      'taMax8High': instance.taMax8High,
      'taMin9': instance.taMin9,
      'taMin9Low': instance.taMin9Low,
      'taMin9High': instance.taMin9High,
      'taMax9': instance.taMax9,
      'taMax9Low': instance.taMax9Low,
      'taMax9High': instance.taMax9High,
      'taMin10': instance.taMin10,
      'taMin10Low': instance.taMin10Low,
      'taMin10High': instance.taMin10High,
      'taMax10': instance.taMax10,
      'taMax10Low': instance.taMax10Low,
      'taMax10High': instance.taMax10High,
      'timestamp': instance.timestamp,
    };

WeatherMidLandForecast _$WeatherMidLandForecastFromJson(
    Map<String, dynamic> json) {
  return WeatherMidLandForecast(
    json['dataTime'] as String,
    json['region'] as String,
    json['rnSt3Am'] as int,
    json['rnSt3Pm'] as int,
    json['rnSt4Am'] as int,
    json['rnSt4Pm'] as int,
    json['rnSt5Am'] as int,
    json['rnSt5Pm'] as int,
    json['rnSt6Am'] as int,
    json['rnSt6Pm'] as int,
    json['rnSt7Am'] as int,
    json['rnSt7Pm'] as int,
    json['rnSt8'] as int,
    json['rnSt9'] as int,
    json['rnSt10'] as int,
    json['wf3Am'] as String,
    json['wf3Pm'] as String,
    json['wf4Am'] as String,
    json['wf4Pm'] as String,
    json['wf5Am'] as String,
    json['wf5Pm'] as String,
    json['wf6Am'] as String,
    json['wf6Pm'] as String,
    json['wf7Am'] as String,
    json['wf7Pm'] as String,
    json['wf8'] as String,
    json['wf9'] as String,
    json['wf10'] as String,
    json['timestamp'] as int,
  );
}

Map<String, dynamic> _$WeatherMidLandForecastToJson(
        WeatherMidLandForecast instance) =>
    <String, dynamic>{
      'dataTime': instance.dataTime,
      'region': instance.region,
      'rnSt3Am': instance.rnSt3Am,
      'rnSt3Pm': instance.rnSt3Pm,
      'rnSt4Am': instance.rnSt4Am,
      'rnSt4Pm': instance.rnSt4Pm,
      'rnSt5Am': instance.rnSt5Am,
      'rnSt5Pm': instance.rnSt5Pm,
      'rnSt6Am': instance.rnSt6Am,
      'rnSt6Pm': instance.rnSt6Pm,
      'rnSt7Am': instance.rnSt7Am,
      'rnSt7Pm': instance.rnSt7Pm,
      'rnSt8': instance.rnSt8,
      'rnSt9': instance.rnSt9,
      'rnSt10': instance.rnSt10,
      'wf3Am': instance.wf3Am,
      'wf3Pm': instance.wf3Pm,
      'wf4Am': instance.wf4Am,
      'wf4Pm': instance.wf4Pm,
      'wf5Am': instance.wf5Am,
      'wf5Pm': instance.wf5Pm,
      'wf6Am': instance.wf6Am,
      'wf6Pm': instance.wf6Pm,
      'wf7Am': instance.wf7Am,
      'wf7Pm': instance.wf7Pm,
      'wf8': instance.wf8,
      'wf9': instance.wf9,
      'wf10': instance.wf10,
      'timestamp': instance.timestamp,
    };
