import 'package:flutter/material.dart';

class BpAppbarTitle extends StatelessWidget {
  const BpAppbarTitle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 148.0,
      padding: EdgeInsets.fromLTRB(25, 25, 25, 25),
      width: double.infinity,
      color: Colors.white,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(child: Text(''), flex: 1),
          Text(
            "혈압관리",
            style: TextStyle(
                fontFamily: 'NanumRoundB',
                fontSize: 20,
                color: Colors.black),
          ),
          Expanded(child: Text(''), flex: 1),
          // Image.asset(controller.todayWeather == null ? "images/drawing_disabled_icon.png" : controller.todayWeather!.weatherImg, width: 30, height: 30,),
        ],
      ),
    );
  }
}
