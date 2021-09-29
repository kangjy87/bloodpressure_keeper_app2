import 'dart:math';

import 'package:bloodpressure_keeper_app/ui/pages/feed/dtos/MediaInfo.dart';
import 'package:bloodpressure_keeper_app/ui/pages/feed/utils/ContentsUtil.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:bloodpressure_keeper_app/ui/pages/feed/config/AppTranslations.dart';
import 'package:bloodpressure_keeper_app/ui/pages/feed/config/config.dart';
import 'package:bloodpressure_keeper_app/ui/pages/feed/config/enums.dart';
import 'package:bloodpressure_keeper_app/ui/pages/feed/feed_controller.dart';
import 'package:bloodpressure_keeper_app/ui/pages/feed/dtos/FeedsItemDto.dart';
import 'package:bloodpressure_keeper_app/ui/pages/feed/utils/FormatUtil.dart' ;
import 'package:bloodpressure_keeper_app/ui/pages/feed/utils/GeneralUtils.dart' ;
import 'package:bloodpressure_keeper_app/ui/pages/feed/utils/GeneralUtils.dart' ;
import 'package:bloodpressure_keeper_app/ui/pages/feed/utils/logger_utils.dart' ;

class FeedItemView extends StatelessWidget {

  /** 아래 스타일들 나중에 따로빼자 ------------------- */
  TextStyle tStyle1 = TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.bold,
      color: Color (0xff717171)
  );

  TextStyle tStyle2 = TextStyle(
      fontSize: 12,
      color: Color (0xff8b8b8b)
  );
  /** ------------------------------------------ */


  FeedsItemDto? dto;
  int? index;
  VoidCallback? onTap;

  FeedItemView ({
    this.dto,
    this.index,
    this.onTap
  });

  @override
  Widget build(BuildContext context) {

    MediaInfo _mediaInfo = ContentsUtil.getFeedsThumbNailInfo(dto!);

    // String? _itemImageURL;
    //
    // //TODO : 아이템 높이는 유튜브 제외하고 비율대로 뿌리도록 변경.
    // double _itemWidth = (Get.width - (Constants.feed_tab_horizontal_padding * 2)) * 0.5;
    // double _imgHeight = _itemWidth;
    //
    // if (dto!.thumbnail_url != null && dto!.thumbnail_url!.isNotEmpty) {
    //   _itemImageURL = dto!.thumbnail_url;
    //   _imgHeight = dto!.thumbnail_height!.toDouble() * (_itemWidth / dto!.thumbnail_width!.toDouble());
    // } else if (dto!.storage_thumbnail_url != null && dto!.storage_thumbnail_url!.isNotEmpty) {
    //   _itemImageURL = dto!.storage_thumbnail_url!.startsWith('http') ? dto!.storage_thumbnail_url : Constants.CDN_URL + dto!.storage_thumbnail_url!;
    //   _imgHeight = dto!.thumbnail_height!.toDouble() * (_itemWidth / dto!.thumbnail_width!.toDouble());
    // } else if (dto!.article_medias!.length > 0) {
    //   if (dto!.article_medias!.first.url != null && dto!.article_medias!.first.url!.isNotEmpty) {
    //     _itemImageURL = dto!.article_medias!.first.url;
    //   } else if (dto!.article_medias!.first.storage_url != null && dto!.article_medias!.first.storage_url!.isNotEmpty) {
    //     _itemImageURL = dto!.article_medias!.first.storage_url!.startsWith('http')
    //         ? dto!.article_medias!.first.storage_url
    //         : Constants.CDN_URL + dto!.article_medias!.first.storage_url!;
    //   }
    //
    //   _imgHeight = dto!.article_medias!.first.height!.toDouble() * (_itemWidth / dto!.article_medias!.first.width!.toDouble());
    // } else {
    //   _itemImageURL = "https://usagi-post.com/wp-content/uploads/2020/05/no-image-found-360x250-1.png";
    // }


    List<Color> _colors = [Colors.transparent, Colors.black45];
    List<double> _stops = [0.6, 0.9];

    String? _userThumbnailURL = dto!.article_owner!.thumbnail_url;
    print('>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>${_userThumbnailURL}');
    if (_userThumbnailURL == null || _userThumbnailURL.isEmpty) _userThumbnailURL = "";

    String strContents = '${(dto!.hashtag == null || dto!.hashtag == '')? dto!.contents! : dto!.hashtag!}';

    return Container (
        child : InkWell (
          onTap: onTap,
          child: Column(
            children: [
              Stack (
                children: [

                  ClipRRect(
                      borderRadius: BorderRadius.circular(10.0),
                      child: Container (
                        child: Stack (
                          children: [

                            /** 썸네일 */
                            Container(
                              // height: _mediaInfo.height,
                              height:  0 ,
                              constraints: BoxConstraints (
                                  minHeight: _mediaInfo.url!.startsWith ("http") ? _mediaInfo.height! : 0,
                                  minWidth: double.maxFinite
                              ),
                              child: _mediaInfo.url!.startsWith ("http")
                                  ? CachedNetworkImage(
                                imageUrl: _mediaInfo.url!,
                                cacheKey: dto!.url,
                                cacheManager: DefaultCacheManager(),
                                maxWidthDiskCache: 300,
                                maxHeightDiskCache: 300,
                                memCacheWidth: 300,
                                memCacheHeight: 300,
                                fit: BoxFit.cover,
                                errorWidget: (context, url, error) => Container(
                                  height: _mediaInfo.height,
                                  color: Colors.transparent,
                                  child: Image.asset(
                                    Images.img_no_thumbnail,
                                    height: _mediaInfo.height,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              )
                                  : Container(
                                child: Image.asset(
                                  Images.img_no_thumbnail,
                                  height: _mediaInfo.height,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),

                            /** 그라데이션 커버 */
                            if (_mediaInfo.url!.isNotEmpty)
                              Container (
                                height: _mediaInfo.height,
                                decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter,
                                      colors: _colors,
                                      stops: _stops,
                                    )
                                ),
                              ),
                            /** 북마크**/
                            Positioned(
                              right: getUiSize (6.3),
                              top: getUiSize (6.3),
                              child: Image.asset(dto!.is_favorite == false ? AppIcons.book_makr_off : AppIcons.book_makr_on, height: getUiSize(15.5),width: getUiSize(15.5),),
                            ),
                          ],
                        ),
                      )
                  ),
                ],
              ),
              SizedBox(height: 5,),
              Row(
                children: [
                  SizedBox (width: 3,),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: CachedNetworkImage (
                      width: getUiSize(25),
                      height: getUiSize(25),
                      imageUrl: _userThumbnailURL,
                      placeholder: (context, url) => Container(
                        width: 20,
                        height: 20,
                        color: Colors.transparent,
                        child: Image.asset(Images.img_no_profile),
                      ),
                      errorWidget: (context, url, error) => Container(
                        width: 20,
                        height: 20,
                        color: Colors.transparent,
                        child: Image.asset(Images.img_no_profile),
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox (width: 11,),
                  Container (
                    width: Get.width / 3,
                    // padding: const EdgeInsets.all(1),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        Text (
                          dto!.article_owner!.name!,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          style: TextStyle (
                            color: Color (0xFF2a2a2a),
                            fontFamily: Font.NotoSansCJKkrRegular,
                            fontSize: getUiSize(11),
                          ),
                        )

                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 5,),
              Container(
                padding: const EdgeInsets.all(8),
                child: Text('${strContents}',maxLines: 2,overflow: TextOverflow.ellipsis),
              ),
              SizedBox(height: 7,),
              /** 별점 */
              Row (
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(width: 10,),
                  Image.asset(AppIcons.ic_heart2, height: getUiSize(13.2),width: getUiSize(14.5),),
                  SizedBox (width: getUiSize(2.5),),
                  Text (
                      FormatUtil.numberWithComma(dto!.article_detail  == null ? 0 : dto!.article_detail!.like!),
                      style: TextStyle (
                          color: Colors.black,
                          //fontFamily: Font.NotoSansCJKkrRegular,
                          fontSize: getUiSize(9)
                      )
                  )

                ],
              ),
              SizedBox(height: 14,),
            ],
          )
        ),

        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(getUiSize(10))),
        )
    );

  }

}