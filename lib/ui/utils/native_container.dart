import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
const Map<String, String> UNIT_ID = kReleaseMode
    ? {
  'ios': '[YOUR iOS AD UNIT ID]',
  'android': 'ca-app-pub-7018589062175673~5088960981',
}
    : {
  'ios': 'ca-app-pub-3940256099942544/2934735716',
  'android': 'ca-app-pub-3940256099942544/2247696110',
};
class NativeContainer extends StatefulWidget {
  const NativeContainer({
    Key? key,
    required this.type,
    required this.color,
  }) : super(key: key);

  final String type;
  final Color? color;

  @override
  _NativeContainerState createState() => _NativeContainerState();
}

class _NativeContainerState extends State<NativeContainer> {
  NativeAd? _nativeAd;
  bool isLoading = true;
  static Map<String, double> adHeight = {'large': 340.0, 'medium': 130.0, 'small': 50.0};

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (mounted) _createNative();
  }

  _createNative() {
    TargetPlatform os = Theme.of(context).platform;
    setState(() => isLoading = true);
    _nativeAd = NativeAd(
      adUnitId: UNIT_ID[os == TargetPlatform.iOS ? 'ios' : 'android']!,
      request: const AdRequest(),
      factoryId: widget.type,
      listener: NativeAdListener(
        onAdLoaded: (Ad ad) {
          setState(() => isLoading = false);
          print('$NativeAd ${widget.type} loaded.');
        },
        onAdFailedToLoad: (Ad ad, LoadAdError error) {
          setState(() => isLoading = true);
          print('$NativeAd failedToLoad: $error');
          ad.dispose();
        },
        onAdOpened: (Ad ad) => print('$NativeAd ${widget.type} onAdOpened.'),
        onAdClosed: (Ad ad) => print('$NativeAd ${widget.type} onAdClosed.'),
      ),
    )..load();
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Container(
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: const Center(child: CircularProgressIndicator()),
      );
    } else {
      return Container(
        color: widget.color,
        width: MediaQuery.of(context).size.width / 2,
        height: adHeight[widget.type],
        child: AdWidget(ad: _nativeAd!),
      );
    }
  }
}