import 'dart:math';

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

    String? _itemImageURL;

    //TODO : 아이템 높이는 유튜브 제외하고 비율대로 뿌리도록 변경.
    double _itemWidth = (Get.width - (Constants.feed_tab_horizontal_padding * 2)) * 0.5;
    double _imgHeight = _itemWidth;

    if (dto!.thumbnail_url != null && dto!.thumbnail_url!.isNotEmpty) {
      _itemImageURL = dto!.thumbnail_url;
      _imgHeight = dto!.thumbnail_height!.toDouble() * (_itemWidth / dto!.thumbnail_width!.toDouble());
    } else if (dto!.storage_thumbnail_url != null && dto!.storage_thumbnail_url!.isNotEmpty) {
      _itemImageURL = dto!.storage_thumbnail_url!.startsWith('http') ? dto!.storage_thumbnail_url : Constants.CDN_URL + dto!.storage_thumbnail_url!;
      _imgHeight = dto!.thumbnail_height!.toDouble() * (_itemWidth / dto!.thumbnail_width!.toDouble());
    } else if (dto!.article_medias!.length > 0) {
      if (dto!.article_medias!.first.url != null && dto!.article_medias!.first.url!.isNotEmpty) {
        _itemImageURL = dto!.article_medias!.first.url;
      } else if (dto!.article_medias!.first.storage_url != null && dto!.article_medias!.first.storage_url!.isNotEmpty) {
        _itemImageURL = dto!.article_medias!.first.storage_url!.startsWith('http')
            ? dto!.article_medias!.first.storage_url
            : Constants.CDN_URL + dto!.article_medias!.first.storage_url!;
      }

      _imgHeight = dto!.article_medias!.first.height!.toDouble() * (_itemWidth / dto!.article_medias!.first.width!.toDouble());
    } else {
      _itemImageURL = "https://usagi-post.com/wp-content/uploads/2020/05/no-image-found-360x250-1.png";
    }




    List<Color> _colors = [Colors.transparent, Colors.black45];
    List<double> _stops = [0.6, 0.9];

    return Container (
        child : InkWell (
          onTap: onTap,
          child: Stack (
            children: [

              ClipRRect(
                  borderRadius: BorderRadius.circular(10.0),
                  child: Container (
                    child: Stack (
                      children: [

                        /** 썸네일 */
                        Container (
                          color: Color (0xffe0e0e0),
                          height: _imgHeight,
                          constraints: BoxConstraints (
                              minHeight: _itemImageURL!.startsWith ("http") ? _imgHeight : 0,
                              minWidth: double.maxFinite
                          ),
                          child: _itemImageURL.startsWith ("http")
                              ? CachedNetworkImage(
                            imageUrl: _itemImageURL,
                            fit: BoxFit.cover,
                            cacheKey: dto!.id.toString() + "_fiid_img",
                            placeholder: (context, url) => Container(
                              height: _imgHeight,
                              color: Colors.transparent,
                              child: Image.asset(
                                Images.img_no_thumbnail,
                                height: _imgHeight,
                                fit: BoxFit.cover,
                              ),
                            ),
                            errorWidget: (context, url, error) => Container(
                              height: _imgHeight,
                              color: Colors.transparent,
                              child: Image.asset(
                                Images.img_no_thumbnail,
                                height: _imgHeight,
                                fit: BoxFit.cover,
                              ),
                            ),
                          )
                              : Container (
                            child: Image.asset(
                              Images.img_no_thumbnail,
                              height: _imgHeight,
                              fit: BoxFit.cover,
                            ),
                          ),

                        ),

                        /** 그라데이션 커버 */
                        Container (
                          height: _imgHeight,
                          decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: _colors,
                                stops: _stops,
                              )
                          ),
                        ),

                        /** 별점 */
                        Positioned(
                          right: getUiSize (6.3),
                          bottom: getUiSize (6.3),
                          child: Row (
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [

                              Image.asset(AppIcons.ic_heart, height: getUiSize(8),),
                              SizedBox (width: getUiSize(2.5),),
                              Text (
                                  FormatUtil.numberWithComma(Random.secure().nextInt(1000)),
                                  style: TextStyle (
                                      color: Colors.white,
                                      //fontFamily: Font.NotoSansCJKkrRegular,
                                      fontSize: getUiSize(9)
                                  )
                              )

                            ],
                          ),
                        )

                      ],
                    ),
                  )
              ),
            ],
          ),
        ),

        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(getUiSize(10))),
        )
    );

  }

}