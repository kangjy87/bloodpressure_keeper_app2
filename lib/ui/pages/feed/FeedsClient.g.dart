// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'FeedsClient.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

class _FeedsClient implements FeedsClient {
  _FeedsClient(this._dio, {this.baseUrl}) {
    baseUrl ??= 'https://dev.api.curator9.com';
  }

  final Dio _dio;

  String? baseUrl;

  @override
  Future<AuthTokenDto> postToken(body) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(body.toJson());
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<AuthTokenDto>(
            Options(method: 'POST', headers: <String, dynamic>{}, extra: _extra)
                .compose(_dio.options, '/oauth/token',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = AuthTokenDto.fromJson(_result.data!);
    return value;
  }

  @override
  Future<FeedsListDto> getFeeds(media_idx, page, per_page) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(_setStreamType<
        FeedsListDto>(Options(
            method: 'GET', headers: <String, dynamic>{}, extra: _extra)
        .compose(_dio.options,
            '/api/v1/articles?media_id=$media_idx&page=$page&per_page=$per_page',
            queryParameters: queryParameters, data: _data)
        .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = FeedsListDto.fromJson(_result.data!);
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
