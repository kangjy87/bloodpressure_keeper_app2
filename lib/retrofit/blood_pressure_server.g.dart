// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'blood_pressure_server.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

class _BloodPressureServer implements BloodPressureServer {
  _BloodPressureServer(this._dio, {this.baseUrl}) {
    baseUrl ??= 'https://blood-pressure.tdi9.com';
  }

  final Dio _dio;

  String? baseUrl;

  @override
  Future<GetClientCredentialsGrantDto> clientCredentialsGrant(task) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(task.toJson());
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<GetClientCredentialsGrantDto>(
            Options(method: 'POST', headers: <String, dynamic>{}, extra: _extra)
                .compose(_dio.options, '/oauth/token',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = GetClientCredentialsGrantDto.fromJson(_result.data!);
    return value;
  }

  @override
  Future<GetUsersDto> UsersInfo(authorization, task) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(task.toJson());
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<GetUsersDto>(Options(
                method: 'POST',
                headers: <String, dynamic>{r'Authorization': authorization},
                extra: _extra)
            .compose(_dio.options, '/api/v1/users',
                queryParameters: queryParameters, data: _data)
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = GetUsersDto.fromJson(_result.data!);
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
