import 'package:bloodpressure_keeper_app/ui/pages/feed/utils/GeneralUtils.dart';
import 'package:flutter/material.dart';

class JoinAddInfoTitle extends StatelessWidget {
  final String firstTitle ;
  final String secondTitle ;
  const JoinAddInfoTitle({
    Key? key,
    required this.firstTitle ,
    required this.secondTitle ,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(25, 25, 25, 25),
      width: double.infinity,
      color: Color(0xfff4f7fc),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                firstTitle,
                textAlign: TextAlign.center,
                style: TextStyle(
                    // decoration: TextDecoration.underline,
                    fontFamily: 'NanumRoundEB',
                    fontSize: getUiSize(20),
                    color: Color(0xff454f63))
                ,
              ),
              SizedBox(height: 20,),
              Text(
                secondTitle,
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontFamily: 'NanumRoundB',
                    fontSize: getUiSize(11),
                    color: Color(0xff454f63)),
              ),
            ],
          )
        ],
      ),
    );
  }
}
