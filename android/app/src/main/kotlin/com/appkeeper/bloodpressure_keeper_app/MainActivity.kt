package com.appkeeper.bloodpressure_keeper_app

import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugins.googlemobileads.GoogleMobileAdsPlugin
import io.flutter.plugins.googlemobileads.GoogleMobileAdsPlugin.NativeAdFactory

class MainActivity: FlutterActivity() {
    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        GoogleMobileAdsPlugin.registerNativeAdFactory(flutterEngine, "medium", NativeAdMedium(context))
        GoogleMobileAdsPlugin.registerNativeAdFactory(flutterEngine, "large", NativeAdLarge(context))
        GoogleMobileAdsPlugin.registerNativeAdFactory(flutterEngine, "small", NativeAdSmall(context))
    }

    override fun cleanUpFlutterEngine(flutterEngine: FlutterEngine) {
        GoogleMobileAdsPlugin.unregisterNativeAdFactory(flutterEngine, "medium")
        GoogleMobileAdsPlugin.unregisterNativeAdFactory(flutterEngine, "large")
        GoogleMobileAdsPlugin.unregisterNativeAdFactory(flutterEngine, "small")
    }
}