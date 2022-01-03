

import 'package:bloodpressure_keeper_app/model/users_dto.dart';
import 'package:bloodpressure_keeper_app/utils/shared_preferences_info/login_info.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:get/get.dart';
import 'package:bloodpressure_keeper_app/ui/pages/feed/config/config.dart';
import 'package:bloodpressure_keeper_app/ui/routes/app_routes.dart';
import 'package:bloodpressure_keeper_app/ui/pages/feed/utils/logger_utils.dart';

class FirebaseUtil {


  // static FirebaseAnalytics analytics = FirebaseAnalytics();
  // static FirebaseAnalyticsObserver observer = FirebaseAnalyticsObserver(analytics: analytics);


  static Future<void> initDynamicLinks() async {
    FirebaseDynamicLinks.instance.onLink(
        onSuccess: (PendingDynamicLinkData? dynamicLink) async {
          final Uri? deepLink = dynamicLink?.link;

          if (deepLink != null) {
            sendToDeepLink(deepLink);
          }
        }, onError: (OnLinkErrorException e) async {
      print('onLinkError');
      print(e.message);
    });

    final PendingDynamicLinkData? data =
    await FirebaseDynamicLinks.instance.getInitialLink();
    final Uri? deepLink = data?.link;

    if (deepLink != null) {
      sendToDeepLink(deepLink);
    }
  }


  /** 딥링크 생성 */
  static Future<Uri> createDynamicLink(bool short, String route, String params,
      String imageURL, String title, String description) async {
    final DynamicLinkParameters parameters = DynamicLinkParameters(
        uriPrefix: Constants.deeplink_prefix_domain,
        link: Uri.parse('${Constants.deeplink_prefix_domain}$route/$params'),
        androidParameters: AndroidParameters(
          packageName: Constants.androidApplicationId,
          minimumVersion: 1,
        ),
        dynamicLinkParametersOptions: DynamicLinkParametersOptions(
          shortDynamicLinkPathLength: ShortDynamicLinkPathLength.short,
        ),
        iosParameters: IosParameters(
          bundleId: Constants.appleBundleId,
          minimumVersion: '1.0.0',
        ),
        socialMetaTagParameters: SocialMetaTagParameters(
            imageUrl: Uri.parse(imageURL),
            title: title,
            description: description
        )
    );

    Uri url;
    if (short) {
      final ShortDynamicLink shortLink = await parameters.buildShortLink();
      url = shortLink.shortUrl;
    } else {
      url = await parameters.buildUrl();
    }

    return url;
  }

  /** 테스트 로그 */
  // static void sendTestLog (String title, String description) {
  //   analytics.logEvent(
  //     name: 'sns_login',
  //     parameters: <String, dynamic>{
  //       "title" : title,
  //       "description" : description
  //     },
  //   );
  // }

  /** 자 딥링크로 진입합시다!! */
  static Future<void> sendToDeepLink(Uri deepLink) async {
    print("딥링크!! --> ${deepLink.path} --- Get.currentRoute --> ${Get
        .currentRoute}");

    List<String> explodedString = deepLink.path.split("/");
    explodedString.removeAt(0);
    String _routeName = "";
    String? _arcuments;

    if (explodedString.length > 1) {
      for (String str in explodedString) {
        if (str == explodedString.last)
          _arcuments = str;
        else
          _routeName += "/$str";
      }
    } else {
      _routeName = deepLink.path;
    }


    print(
        "routeNem --> $_routeName"
            + "\n parameters --> $_arcuments"
    );

    if (Get.currentRoute == _routeName) {
      Get.back();
      await Future.delayed(Duration(milliseconds: 1000));
    }
    //만약 로그인이 안되어 있는 상태라면 로그인창을 띄워준다.
    UsersDto usersDto = await getUserInfo();
    if(usersDto.nickname == null || usersDto.nickname == ""){
      Get.offAllNamed(AppRoutes.LOGIN);
    }else{
      Get.toNamed('${AppRoutes.FeedDetailPage}/value?page=FeedPage',
          arguments: _arcuments);
    }
    // Get.toNamed(_routeName, arguments: _arcuments);
  }
}