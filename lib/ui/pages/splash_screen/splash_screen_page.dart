import 'package:bloodpressure_keeper_app/ui/pages/feed/utils/GeneralUtils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'splash_screen_controller.dart';
import 'package:lottie/lottie.dart';

class SplashScreenPage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return GetBuilder<SplashScreenController>(builder: (controller) {
      controller.startSplash(context);
      return Scaffold(
        // appBar: AppBar(
        //   leading: IconButton(
        //     onPressed: () {
        //       Navigator.of(context).pop();
        //     },
        //     icon: Icon(Icons.arrow_back, color: Colors.black),
        //   ),
        //   title: Text(
        //     controller.title,
        //     style: TextStyle(color: Colors.black),
        //   ),
        //   backgroundColor: Colors.white,
        //   foregroundColor: Colors.black,
        // ),
        body: Container(
          color: Color(0xffF4F7FC),
          width: double.infinity,
          height: double.infinity,
          child: Center(
            child: Column(
              children: [
                // Expanded(child: Text(''), flex: 4),
                Expanded(child: Lottie.asset('assets/splash_hm2.json'), flex: 9),
                // Expanded(child: Text(''), flex: 1),
              ],
            ),
          ),
        ),
      );
    });
  }
}