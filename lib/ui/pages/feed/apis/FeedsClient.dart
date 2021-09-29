import 'package:bloodpressure_keeper_app/ui/pages/feed/dtos/FeedsDetailDto.dart';
import 'package:dio/dio.dart' hide Headers;
import 'package:bloodpressure_keeper_app/ui/pages/feed/config/config.dart';
import 'package:bloodpressure_keeper_app/ui/pages/feed/dtos/CommonDto.dart';
import 'package:bloodpressure_keeper_app/ui/pages/feed/dtos/auth/AuthRequestBody.dart';
import 'package:bloodpressure_keeper_app/ui/pages/feed/dtos/auth/AuthTokenDto.dart';
import 'package:bloodpressure_keeper_app/ui/pages/feed/dtos/FeedsListDto.dart';
import 'package:bloodpressure_keeper_app/ui/pages/feed/utils/SharedPrefUtil.dart';
import 'package:retrofit/http.dart';

part 'FeedsClient.g.dart';

@RestApi(baseUrl: '${Constants.Q_API_BASE_URL}')
abstract class FeedsClient {

  factory FeedsClient(Dio dio, {String baseUrl}) = _FeedsClient;

  @POST('/oauth/token')
  Future<AuthTokenDto> postToken(
      @Body() AuthRequestBody body,
      );

  @GET('/api/v1/articles')
  Future<FeedsListDto> getFeeds (
      @Query("media_id") int media_id,
      @Query("page") int page,
      @Query ("per_page") int per_page,
      @Header('Authorization') authorization,
      @Query ("platform") String? platform,
      @Query ("search") String? search
      );

  @GET('/api/v1/articles/{articleId}')
  Future<FeedsDetailDto> getFeedDetail (
      @Path ('articleId') String articleId
      );
}