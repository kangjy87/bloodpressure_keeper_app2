import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:bloodpressure_keeper_app/ui/pages/feed/config/config.dart';
import 'package:bloodpressure_keeper_app/ui/pages/feed/utils/GeneralUtils.dart';
import 'package:bloodpressure_keeper_app/ui/pages/feed/utils/FormatUtil.dart';

class FeedItemViewForHome extends StatelessWidget {

  ImageDto? dto;

  FeedItemViewForHome ({
    this.dto
  });

  @override
  Widget build(BuildContext context) {
    return Container (
      child: Stack (
        children: [

          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: CachedNetworkImage(
              imageUrl: dto!.url!,
              width: getUiSize(110),
              height: getUiSize(150),
              fit: BoxFit.cover,
            ),
          ),

          /*Positioned(
              top: getUiSize(4.3),
              left: getUiSize(4.3),
              child: Stack (
                alignment: Alignment.center,
                children: [

                  Container (
                    width: getUiSize(25),
                    height: getUiSize(25),
                    decoration: BoxDecoration (
                        shape: BoxShape.circle,
                        color: Colors.white
                    ),

                  ),

                  ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: CachedNetworkImage (
                      width: getUiSize(22),
                      height: getUiSize(22),
                      imageUrl: dto!.url!,
                      fit: BoxFit.cover,
                    ),
                  ),

                ],
              )
          ),*/

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
                    FormatUtil.numberWithComma(123567),
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
    );
  }

}