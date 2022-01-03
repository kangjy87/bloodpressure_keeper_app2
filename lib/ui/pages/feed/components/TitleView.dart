import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:bloodpressure_keeper_app/ui/pages/feed/utils/GeneralUtils.dart' ;
import 'package:bloodpressure_keeper_app/ui/pages/feed/config/config.dart';

class TitleView extends StatelessWidget {

  TextStyle tStyle = TextStyle (
      color: Color (0xFF2a2a2a),
      fontFamily: Font.NotoSansCJKkrBold,
      fontWeight: FontWeight.bold,
      fontStyle: FontStyle.italic,
      fontSize: getUiSize(15)
  );


  String? mainTitleGray;
  String? mainTitleBlack;
  String? subTitle;
  FontStyle? fontStyle;

  TitleView ({
    this.mainTitleGray,
    this.mainTitleBlack,
    this.subTitle,
    this.fontStyle = FontStyle.italic
  });

  @override
  Widget build(BuildContext context) {
    return Container (
      height: getUiSize(30),
      child: Stack (
        children: [
          RichText(
            text: TextSpan(
              text: "#",
              style: tStyle.copyWith(color: Color (0xFF2a2a2a), fontStyle: fontStyle),
              children: <TextSpan>[
                if (mainTitleGray != null) TextSpan(text: mainTitleGray, style: tStyle.copyWith(color: Color (0xFF878787), fontStyle: fontStyle)),
                if (mainTitleBlack != null) TextSpan(text: mainTitleBlack, style: tStyle.copyWith(fontStyle: fontStyle))
              ],
            ),
          ),
          subTitle != null ?
          Positioned(
              top: getUiSize(18),
              left: getUiSize (10),
              child: Text (
                subTitle!,
                style: tStyle.copyWith(color: Color (0xFFC0C0C0), fontSize: getUiSize(7.5), fontStyle: FontStyle.normal),
              )
          )
              : Container ()

        ],
      ),
    );
  }

}