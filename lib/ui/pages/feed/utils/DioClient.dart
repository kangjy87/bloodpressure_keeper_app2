import 'dart:convert';

import 'package:bloodpressure_keeper_app/utils/getPhoneInfo.dart';
import 'package:dio/dio.dart';
import 'package:bloodpressure_keeper_app/ui/pages/feed/config/config.dart';
import 'package:bloodpressure_keeper_app/ui/pages/feed/utils/SharedPrefUtil.dart';

import 'logger_utils.dart';

abstract class DioClient {

  static final dio = Dio()
    ..interceptors.add(
      InterceptorsWrapper(
        onRequest: onRequestWrapper,
        onResponse: onResponseWrapper,
        onError: onErrorWrapper,
      ),
    );




  static dynamic parseBody(dynamic data) {
    try {
      if (data != null) {
        return data.toString();
      } else {
        print(data.runtimeType);
        if (data is List) {
          print('isList');
          final dynamicList = [];
          for (int i = 0; i < data.length; i++) {
            dynamicList.add(parseBody(data[i]));
          }
          return dynamicList;
        }

        if (data is Map) {
          for (var key in data.keys) {
            // RelationController.relationApprove 호출할때 아래 항목 때문에 NoSuchMethodError 발생해서 주석처리함
            data[key] = parseBody(data[key]);
          }
        }

        if (data is int) return data;
        if (data is double) return data;
        return data;
      }
    } catch (e) {
      customLogger.e(
        '이 에러가 난다면 해결 또는 헬프요청. 실행에는 영향 없음.'
            '\n$e',
      );
    }
  }


  static void onRequestWrapper(RequestOptions options, RequestInterceptorHandler handler) async {

    /** AUTH TOKEN */
    String? q_auth_token = await SharedPrefUtil.getString(SharedPrefKey.CURATOR9_TOKEN);
    options.headers['Authorization'] = q_auth_token;
    PhoneInfo phoneInfo = await getPhoneInfo();
    options.headers['device'] = phoneInfo.device;
    options.headers['os_version'] = phoneInfo.osVersion;
    options.headers['app_version'] = phoneInfo.appVersion;
    options.headers['advertising_id'] = phoneInfo.advertsingId;
    options.headers['os'] = phoneInfo.os;

    // if (options.baseUrl.startsWith(Constants.Q_API_BASE_URL) && q_auth_token != null && q_auth_token.isNotEmpty) {
    //   options.headers['Authorization'] = q_auth_token;
    // }
    //
    // String? api_auth_token = await SharedPrefUtil.getString(SharedPrefKey.AUTH_TOKEN);
    // if (options.baseUrl.startsWith(Constants.API_BASE_URL) && api_auth_token != null && api_auth_token.isNotEmpty) {
    //   options.headers['Authorization'] = api_auth_token;
    // }

    customLogger.d('!!!!!!!!!!REQUEST SENT WITH FOLLOWING LOG!!!!!!!!!!\n'
        'path: ${options.baseUrl}${options.path}\n'
        'body: ${parseBody(options.data)}\n'
        'query: ${parseBody(options.queryParameters)}\n'
        'headers: ${options.headers}');

    return handler.next(options);
  }

  //error handling
  static void onErrorWrapper(DioError error, ErrorInterceptorHandler handler) async {
    if (error == DioErrorType.connectTimeout) {
      customLogger.e(error.error);
    }

    customLogger.d(
      '!!!!!!!!!!ERROR THROWN WITH FOLLOWING LOG!!!!!!!!!!\n'
          'path: ${error.requestOptions.baseUrl}${error.requestOptions.path}\n'
          'status code: ${error.response?.statusCode ?? ''}\n'
          'body: ${error.response?.data.toString() ?? ''}\n'
          'headers: ${error.response?.headers ?? ''}',
    );

    return handler.next(error);
  }

  static void onResponseWrapper(Response resp, ResponseInterceptorHandler handler) async {

    if (resp.data is Map) {
      var encoder = JsonEncoder.withIndent('  ');
      String message = encoder.convert(resp.data);

      customLogger.d(
        '!!!!!!!!!!RESPONSE RECEIVED WITH FOLLOWING LOG!!!!!!!!!!\n'
            'path: ${resp.requestOptions.baseUrl}${resp.requestOptions.path}\n'
            'headers: ${resp.headers}'
            'body: $message\n',
      );
    } else {
      customLogger.d(
        '!!!!!!!!!!RESPONSE RECEIVED WITH FOLLOWING LOG!!!!!!!!!!\n'
            'path: ${resp.requestOptions.baseUrl}${resp.requestOptions.path}\n'
            'body: ${resp.data}\n'
            'headers: ${resp.headers}',
      );
    }

    return handler.next(resp);
  }

}