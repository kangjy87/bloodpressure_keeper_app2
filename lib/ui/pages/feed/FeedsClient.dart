import 'package:dio/dio.dart' hide Headers;
import 'config.dart';
import 'package:bloodpressure_keeper_app/model/feeds/FeedsListDto.dart';
//import 'package:prj_musical_flt/utils/SharedPrefUtil.dart';
// import 'package:prj_musical_flt/dtos/CommonDto.dart';
import 'package:retrofit/http.dart';

import 'feed_dtos/AuthRequestBody.dart';
import 'feed_dtos/AuthTokenDto.dart';

part 'FeedsClient.g.dart';

@RestApi(baseUrl: '${Constants.API_BASE_URL}')
abstract class FeedsClient {

  factory FeedsClient(Dio dio, {String baseUrl}) = _FeedsClient;

  @POST('/oauth/token')
  Future<AuthTokenDto> postToken(
      @Body() AuthRequestBody body,
      );

  ///--> KEVIN 수정 ---------------------- get parameter name  media_idx --> media_id
  @GET('/api/v1/articles?media_id={media_idx}&page={page}&per_page={per_page}')
  Future<FeedsListDto> getFeeds (
      @Path("media_idx") int media_idx,
      @Path("page") int page,
      @Path ("per_page") int per_page
      );

}