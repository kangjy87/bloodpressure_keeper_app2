// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'weather_server.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

class _WeatherServer implements WeatherServer {
  _WeatherServer(this._dio, {this.baseUrl}) {
    baseUrl ??= 'https://appservice9.com';
  }

  final Dio _dio;

  String? baseUrl;

  @override
  Future<WeatherDto> getCurrentWeather(sidoName, cityName) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'sidoName': sidoName,
      r'cityName': cityName
    };
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<WeatherDto>(
            Options(method: 'GET', headers: <String, dynamic>{}, extra: _extra)
                .compose(_dio.options, '/api/v1/weathers',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = WeatherDto.fromJson(_result.data!);
    return value;
  }

  RequestOptions _setStreamType<T>(RequestOptions requestOptions) {
    if (T != dynamic &&
        !(requestOptions.responseType == ResponseType.bytes ||
            requestOptions.responseType == ResponseType.stream)) {
      if (T == String) {
        requestOptions.responseType = ResponseType.plain;
      } else {
        requestOptions.responseType = ResponseType.json;
      }
    }
    return requestOptions;
  }
}
