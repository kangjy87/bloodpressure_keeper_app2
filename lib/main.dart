import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:bloodpressure_keeper_app/ui/routes/app_pages.dart';
import 'package:bloodpressure_keeper_app/ui/routes/app_routes.dart';
import 'transition/MyTransitions.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';

import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

void main()async{

  if (kReleaseMode) {
    debugPrint("ReleaseMode---");
  } else {
    debugPrint("DebugMode---");
  }

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]).then((_){
    runZonedGuarded(() {
      runApp(
          SplashScreenApp()
      );
    }, FirebaseCrashlytics.instance.recordError);
  }/*, onError: Crashlytics.instance.recordError*/);

}

class SplashScreenApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: AppRoutes.Splash,
      getPages: AppPages.list,
      defaultTransition: Transition.noTransition,
      translations: MyTranslations(),
      locale: Locale('ko', 'KR'),
      builder: EasyLoading.init(),
    );
  }
}