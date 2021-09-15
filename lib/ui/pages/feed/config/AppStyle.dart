import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:bloodpressure_keeper_app/ui/pages/feed/utils/GeneralUtils.dart';
import 'package:bloodpressure_keeper_app/ui/pages/feed/config/config.dart';

class AppStyle {

  /** 검색폼 */
  static InputDecoration decorationForSearch ({String hint = ""}) {
    return InputDecoration(
      hintText: hint,
      counterText: "", //yr counterText 숨김
      hintStyle: TextStyle(
          color:  const Color(0xffa2a2a2),
          fontWeight: FontWeight.w400,
          fontFamily: Font.NotoSansCJKkrRegular,
          fontStyle:  FontStyle.normal,
          fontSize: getUiSize(9.0)
      ),
      contentPadding: EdgeInsets.only(left: getUiSize(18.6)),
      filled: true,
      fillColor: Colors.white,
      border: UnderlineInputBorder(
        borderSide: BorderSide(color: const Color(0xff3e3e3e)),
      ),
      focusedBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: const Color(0xff3e3e3e)),
      ),

    );
  }

}