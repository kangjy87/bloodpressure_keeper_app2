package com.appkeeper.bloodpressure_keeper_app

import android.content.Context
import android.view.LayoutInflater
import android.view.View
import android.widget.Button
import android.widget.ImageView
import android.widget.RatingBar
import android.widget.TextView
import com.google.android.gms.ads.nativead.MediaView
import com.google.android.gms.ads.nativead.NativeAd
import com.google.android.gms.ads.nativead.NativeAdView
import io.flutter.plugins.googlemobileads.GoogleMobileAdsPlugin
import io.flutter.plugins.googlemobileads.GoogleMobileAdsPlugin.NativeAdFactory

class NativeAdLarge (val context: Context) : GoogleMobileAdsPlugin.NativeAdFactory {

    override fun createNativeAd(
        nativeAd: NativeAd,
        customOptions: MutableMap<String, Any>?
    ): NativeAdView {

        val adView = LayoutInflater.from(context)
            .inflate(R.layout.native_ad_large, null) as NativeAdView

        adView.mediaView = adView.findViewById<View>(R.id.ad_media) as MediaView
        adView.mediaView.setMediaContent(nativeAd.mediaContent)

        adView.headlineView = adView.findViewById(R.id.ad_headline)
        adView.bodyView = adView.findViewById(R.id.ad_body)
        adView.iconView = adView.findViewById(R.id.ad_app_icon)
        adView.starRatingView = adView.findViewById(R.id.ad_stars)
        adView.callToActionView = adView.findViewById(R.id.ad_call_to_action)

        var iconViewText = adView.findViewById<TextView>(R.id.ad_app_icon_text)
        var mediaViewSmall = adView.findViewById<TextView>(R.id.ad_headline_small)

        (adView.headlineView as TextView).text = nativeAd.headline
        (mediaViewSmall as TextView).text = nativeAd.headline

        if (nativeAd.body == null) {
            adView.bodyView.visibility = View.INVISIBLE
        } else {
            adView.bodyView.visibility = View.VISIBLE
            (adView.bodyView as TextView).text = nativeAd.body
        }
        if (nativeAd.callToAction == null) {
            adView.callToActionView.visibility = View.INVISIBLE
        } else {
            adView.callToActionView.visibility = View.VISIBLE
            (adView.callToActionView as Button).text = nativeAd.callToAction
        }
        if (nativeAd.icon == null) {
            adView.iconView.visibility = View.GONE
            iconViewText.visibility = View.VISIBLE
        } else {
            (adView.iconView as ImageView).setImageDrawable(nativeAd.icon.drawable)
            adView.iconView.visibility = View.VISIBLE
            iconViewText.visibility = View.INVISIBLE
        }
        if (nativeAd.starRating == null) {
            adView.starRatingView.visibility = View.INVISIBLE
        } else {
            (adView.starRatingView as RatingBar).rating = nativeAd.starRating.toFloat()
            adView.starRatingView.visibility = View.VISIBLE
        }

        adView.setNativeAd(nativeAd)
        return adView;
    }
}