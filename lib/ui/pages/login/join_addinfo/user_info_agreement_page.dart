import 'dart:async';

import 'package:bloodpressure_keeper_app/ui/pages/feed/utils/GeneralUtils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'user_info_agreement_controller.dart';
import 'package:webview_flutter/webview_flutter.dart';

class UserInfoAgreementPage extends StatelessWidget {
  const UserInfoAgreementPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Completer<WebViewController> _controller = Completer<WebViewController>();
    return GetBuilder<UserInfoAgreementController>(builder: (controller) {
      return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: Icon(Icons.arrow_back, color: Colors.black),
          ),
          title: Row(
            children: [
          // Expanded(child: Text(''), flex: 7),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  controller.title,
                  style: TextStyle(
                      fontFamily: 'NanumRoundB',
                      fontSize: (isSmallSize() ? getUiSize(15) : getUiSize(12)),
                      color: Color(0xff454f63)),
                )
              ],
            ),
          ),
          SizedBox(width: 60,)
            ],
          ),
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
        ),
        body: WebView(
          initialUrl: 'https://appservice9.com/policy/com.bloodpressure.smartmanager',
          javascriptMode: JavascriptMode.unrestricted,
          onWebViewCreated: (WebViewController webViewController) {
            _controller.complete(webViewController);
          },
          onProgress: (int progress) {
            print("WebView is loading (progress : $progress%)");
          },
          javascriptChannels: <JavascriptChannel>{
            // _toasterJavascriptChannel(context),
          },
          onPageStarted: (String url) {
            print('Page started loading: $url');
          },
          onPageFinished: (String url) {
            print('Page finished loading: $url');
          },
          gestureNavigationEnabled: true,
        ),
      );
    });
  }
}
