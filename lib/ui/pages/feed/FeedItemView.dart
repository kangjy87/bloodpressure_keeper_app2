import 'dart:math';

import 'package:bloodpressure_keeper_app/ui/routes/app_pages.dart';
import 'package:bloodpressure_keeper_app/ui/routes/app_routes.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:prj_musical_flt/config/AppTranslations.dart';
import 'PageFeedsDetail.dart';
import 'config.dart';
import 'enums.dart';
import 'package:bloodpressure_keeper_app/model/feeds/FeedsItemDto.dart';
//import 'package:prj_musical_flt/utils/logger_utils.dart';

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

  FeedItemView ({
    this.dto,
    this.index
  });

  @override
  Widget build(BuildContext context) {

    String? _itemImageURL = (dto!.storage_thumbnail_url == null || dto!.storage_thumbnail_url!.isEmpty)
        ? ""
        : dto!.storage_thumbnail_url!.startsWith("http") ? dto!.storage_thumbnail_url
        : Constants.CDN_URL + dto!.storage_thumbnail_url!;

    String _snsIcon;
    switch (enumFromString(SnsType.values, dto!.platform!)) {
      case SnsType.youtube :
        _snsIcon = Images.img_ic_youtube;
        break;
      case SnsType.instagram :
        _snsIcon = Images.img_ic_insta;
        break;

    /** 향후 추가할것. */

      default :
        _snsIcon = Images.img_ic_google;
    }


    double _imgHeight = 100;
    if (dto!.thumbnail_height != null && dto!.thumbnail_width != null) {
      _imgHeight = ((Get.width - 30) / 2 / dto!.thumbnail_width!.toDouble()) * dto!.thumbnail_height!.toDouble();
    }

    return Container (
        child : InkWell (
          onTap: () {
            /** KEVIN 수정 */
            Get.toNamed(AppRoutes.FeedDetailPage, arguments: dto); /** 상세페이지로!! */
          },
          child: Stack (
            children: [

              ClipRRect(
                  borderRadius: BorderRadius.circular(10.0),
                  child: Container (
                    child: Column (
                      children: [

                        /** 썸네일 */
                        Container (
                          color: Color (0xffe0e0e0),
                          constraints: BoxConstraints (
                              minHeight: _itemImageURL!.startsWith ("http") ? _imgHeight : 0,
                              minWidth: double.maxFinite
                          ),
                          child: _itemImageURL.startsWith ("http")
                              ? CachedNetworkImage(
                            imageUrl: _itemImageURL,
                            errorWidget: (context, url, error) => Icon(Icons.error, color: Colors.grey),
                            fit: BoxFit.cover,
                            cacheKey: _itemImageURL,
                          )
                              : Container (),

                        ),

                        /** 디스크립션 영역 */
                        Container (
                          padding: EdgeInsets.all(10),
                          child: Column (
                            children: [

                              /** 타이틀 */
                              Text (
                                '',
                                // dto!.title!.isEmpty ? AppTranslation.lbl_no_title.tr : dto!.title!,
                                style: tStyle1,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),

                              SizedBox (height:10),

                              /** description */
                              Text (
                                dto!.contents!,
                                style: tStyle2,
                                maxLines: 5,
                                overflow: TextOverflow.ellipsis,
                              )

                            ],
                          ),
                        )
                      ],
                    ),
                  )
              ),

              /** 의미가 있나 싶다.. */
              /*Positioned(
                right: 10,
                top: 10,
                child: Image.asset(
                  _snsIcon , width: 25,
                ),
              ),*/
            ],
          ),
        ),

        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
              bottomLeft: Radius.circular(10),
              bottomRight: Radius.circular(10)
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 2,
              offset: Offset(0, 0), // changes position of shadow
            ),
          ],
        )
    );

  }

}