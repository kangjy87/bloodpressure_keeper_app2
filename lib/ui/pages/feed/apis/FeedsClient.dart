
import 'package:bloodpressure_keeper_app/model/feed_favorite_groups_add_dto.dart';
import 'package:bloodpressure_keeper_app/model/get_favorite_groups_dto.dart';
import 'package:bloodpressure_keeper_app/model/set_add_favorite_groups.dart';
import 'package:bloodpressure_keeper_app/ui/pages/feed/dtos/FeedsDetailDto.dart';
import 'package:bloodpressure_keeper_app/ui/pages/feed/dtos/FeedsKeywordsDto.dart';
import 'package:dio/dio.dart' hide Headers;
import 'package:bloodpressure_keeper_app/ui/pages/feed/config/config.dart';
import 'package:bloodpressure_keeper_app/ui/pages/feed/dtos/CommonDto.dart';
import 'package:bloodpressure_keeper_app/ui/pages/feed/dtos/auth/AuthRequestBody.dart';
import 'package:bloodpressure_keeper_app/ui/pages/feed/dtos/auth/AuthTokenDto.dart';
import 'package:bloodpressure_keeper_app/ui/pages/feed/dtos/FeedsListDto.dart';
import 'package:bloodpressure_keeper_app/ui/pages/feed/utils/SharedPrefUtil.dart';
import 'package:retrofit/http.dart';
import 'package:bloodpressure_keeper_app/ui/pages/feed/dtos/FavoritesDto.dart';
import 'package:bloodpressure_keeper_app/ui/pages/feed/dtos/LikesDto.dart';
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
      @Header('C9') C9,
      @Query ("platform") String? platform,
      @Query ("search") String? search,
      @Query ("user_id") int? user_id
      );

  @GET('/api/v1/favorites')
  Future<FavoriteListDto> getFavorite (
      @Query("media_id") int media_id,
      @Query("page") int page,
      @Query ("per_page") int per_page,
      @Header('C9') C9,
      @Query ("platform") String? platform,
      @Query ("search") String? search,
      @Query ("user_id") int? user_id
      );

  @GET('/api/v1/articles/{articleId}')
  Future<FeedsDetailDto> getFeedDetail (
      @Path ('articleId') String articleId,
      @Query ("user_id") int? user_id,
      @Header('C9') C9,
      );

  @POST("/api/v1/favorites")
  Future<FavoritesResultDto> setFavorite(
      @Header('C9') C9,
      @Body() FavoritesDto task
      );

  @POST("/api/v1/articles/{article_id}/{behavior_type}")
  Future<LikesResultDto> setLike(
      @Path ('article_id') String article_id,
      @Path ('behavior_type') String behavior_type,
      @Header('C9') C9,
      @Body() LikesDto task
      );

  @GET('/api/v1/keywords/suggestion')
  Future<FeedsKeywordsListDto> getKeywordsList (
      @Header('C9') C9,
      @Query("media_id") int media_id,
      @Query("sort") String? sort,
      @Query ("page") int? page,
      @Query ("per_page") int? per_page
      );

  @GET('/api/v1/favorite-groups')
  Future<GetFavoriteGroup> getFavoriteGroups (
      @Header('C9') C9,
      @Query("media_id") int media_id,
      @Query("user_id") String user_id,
      @Query("page") int page,
      @Query("per_page") int per_page,
      @Query("search") String search,
      );

  @POST('/api/v1/favorite-groups')
  Future<FeedFavoriteGroupsAddDto> addFavoriteGroups (
      @Header('C9') C9,
      @Body() SetAddFavoriteGroups data
      );

  @GET('/api/v1/favorites')
  Future<FavoriteListDto> getFavoritesGroupDetailList (
      @Header('C9') C9,
      @Query ('page') int page,
      @Query ('per_page') int per_page,
      @Query ('group_id') String group_id,
      @Query ('group_use') String group_use,
      @Query ("media_id") int? media_id,
      @Query ("user_id") String user_id,
      );
}