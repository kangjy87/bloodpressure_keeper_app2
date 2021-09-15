import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:bloodpressure_keeper_app/ui/pages/feed/config/config.dart';
import 'package:bloodpressure_keeper_app/ui/pages/feed/config/enums.dart';
import 'package:bloodpressure_keeper_app/ui/pages/feed/utils/GeneralUtils.dart';
import 'package:bloodpressure_keeper_app/ui/pages/feed/utils/SharedPrefUtil.dart';

class TopperIconMenuAsset extends StatelessWidget {

  TopperIconMenu? selected;
  TopperIconBacgroundMode? backgroundMode;
  VoidCallback? onEventTap;
  VoidCallback? onNoticeTap;
  VoidCallback? onMyPageTap;


  TopperIconMenuAsset ({
    this.selected = TopperIconMenu.none,
    this.backgroundMode = TopperIconBacgroundMode.dark,
    this.onEventTap,
    this.onNoticeTap,
    this.onMyPageTap
  });

  @override
  Widget build(BuildContext context) {

    String? _ic_event;
    String? _ic_notice;
    String? _ic_mypage;

    switch (selected) {
      case TopperIconMenu.none :
        _ic_event = backgroundMode == TopperIconBacgroundMode.bright ? AppIcons.ic_event_white : AppIcons.ic_event;
        _ic_notice = backgroundMode == TopperIconBacgroundMode.bright ? AppIcons.ic_notice_white : AppIcons.ic_notice;
        _ic_mypage = backgroundMode == TopperIconBacgroundMode.bright ? AppIcons.ic_mypage_white : AppIcons.ic_mypage;
        break;

      case TopperIconMenu.event :
        _ic_event = backgroundMode == TopperIconBacgroundMode.bright ? AppIcons.ic_event_white : AppIcons.ic_event;
        _ic_notice = backgroundMode == TopperIconBacgroundMode.bright ? AppIcons.ic_notice_white : AppIcons.ic_notice;
        _ic_mypage = backgroundMode == TopperIconBacgroundMode.bright ? AppIcons.ic_mypage_white : AppIcons.ic_mypage;
        break;

      case TopperIconMenu.notice :
        _ic_event = backgroundMode == TopperIconBacgroundMode.bright ? AppIcons.ic_event_white : AppIcons.ic_event;
        _ic_notice = backgroundMode == TopperIconBacgroundMode.bright ? AppIcons.ic_notice_white : AppIcons.ic_notice;
        _ic_mypage = backgroundMode == TopperIconBacgroundMode.bright ? AppIcons.ic_mypage_white : AppIcons.ic_mypage;
        break;

      case TopperIconMenu.mypage :
        _ic_event = backgroundMode == TopperIconBacgroundMode.bright ? AppIcons.ic_event_white : AppIcons.ic_event;
        _ic_notice = backgroundMode == TopperIconBacgroundMode.bright ? AppIcons.ic_notice_white : AppIcons.ic_notice;
        _ic_mypage = AppIcons.ic_mypage;
        break;
    }

    Color? _iconFocusedColor;
    Color? _iconUnFocusedColor;

    switch (backgroundMode) {
      case TopperIconBacgroundMode.bright :
        _iconFocusedColor = Colors.black;
        _iconUnFocusedColor = null;
        break;

      case TopperIconBacgroundMode.dark :
        _iconFocusedColor = Colors.white;
        _iconUnFocusedColor = Colors.white;
        break;
    }




    return Row (
      children: [
        InkWell(
            child: SvgPicture.asset(
              _ic_event!,
              height: getUiSize(15.3),
              color: selected == TopperIconMenu.event ? _iconFocusedColor : _iconUnFocusedColor,
            ),
            onTap: () {
              //TODO : do something for event
              onEventTap! ();
            }
        ),
        SizedBox(width:11.5),
        InkWell(
            child: SvgPicture.asset(
              _ic_notice!,
              height: getUiSize(15.3),
              color: selected == TopperIconMenu.notice ? _iconFocusedColor : _iconUnFocusedColor,
            ),
            onTap: () {
              //TODO : do someting for notice
              onNoticeTap! ();
            }
        ),
        SizedBox(width:11.5),
        InkWell(
            child: SvgPicture.asset(
              _ic_mypage!,
              height: getUiSize(15.3),
              color: selected == TopperIconMenu.mypage ? _iconFocusedColor : _iconUnFocusedColor,
            ),
            onTap: () {
              //TODO : 아래 로그아웃기능은 마이페이지에서 구현이 끝나면 삭제하고 조건문 없앨것.
              // if (selected == TopperIconMenu.mypage) { ///--> 임시 로그아웃 기능
              //   SharedPrefUtil.clear();
              //   Get.offAndToNamed(RouteNames.SPLASH);
              // } else {
              //   Get.find<HomeController>().isMyPage.value = true;
              //   onMyPageTap! ();
              // }
            }
        )
      ],
    );
  }

}