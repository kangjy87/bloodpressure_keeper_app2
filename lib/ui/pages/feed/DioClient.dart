import 'dart:convert';

import 'package:bloodpressure_keeper_app/model/client_credentials_grant_dto.dart';
import 'package:bloodpressure_keeper_app/utils/shared_preferences_info/get_client_credentials_grant.dart';
import 'package:dio/dio.dart';
import 'config.dart';
// import 'package:prj_musical_flt/utils/SharedPrefUtil.dart';

// import 'logger_utils.dart';

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
      // customLogger.e(
      //   '이 에러가 난다면 해결 또는 헬프요청. 실행에는 영향 없음.'
      //       '\n$e',
      // );
    }
  }


  static void onRequestWrapper(RequestOptions options, RequestInterceptorHandler handler) async {

    /** AUTH TOKEN */
    // String? auth_token = await SharedPrefUtil.getString(SharedPrefKey.CURATOR9_TOKEN);
    GetClientCredentialsGrantDto gcDto = await getFeedCredentiaksGrant(); ///--> KEVIN 수정
    String auth_token = "Bearer ${gcDto.access_token}" ;///--> KEVIN 수정
    print ("auth_token ---> $auth_token");
    if (options.baseUrl.startsWith(Constants.API_BASE_URL) && auth_token != null && auth_token.isNotEmpty){
      options.headers['Authorization'] = auth_token;
      // options.headers['c9'] = 'dev';
    }

    print ('!!!!!!!!!!REQUEST SENT WITH FOLLOWING LOG!!!!!!!!!!\n'
        'path: ${options.baseUrl}${options.path}\n'
        'body: ${parseBody(options.data)}\n'
        'headers: ${options.headers}');

    return handler.next(options);
  }

  //error handling
  static void onErrorWrapper(DioError error, ErrorInterceptorHandler handler) async {
    if (error == DioErrorType.connectTimeout) {
      // customLogger.e(error.error);
    }

    print (
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

      print(
        '!!!!!!!!!!RESPONSE RECEIVED WITH FOLLOWING LOG!!!!!!!!!!\n'
            'path: ${resp.requestOptions.baseUrl}${resp.requestOptions.path}\n'
            'headers: ${resp.headers}'
            'body: $message\n',
      );
    } else {
      print(
        '!!!!!!!!!!RESPONSE RECEIVED WITH FOLLOWING LOG!!!!!!!!!!\n'
            'path: ${resp.requestOptions.baseUrl}${resp.requestOptions.path}\n'
            'body: ${resp.data}\n'
            'headers: ${resp.headers}',
      );
    }

    return handler.next(resp);
  }

}