import 'package:bloodpressure_keeper_app/ui/pages/feed/utils/GeneralUtils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BpPageHeader extends StatelessWidget {
  final String strTitle ;
  BpPageHeader({
    Key? key,
    required this.strTitle
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 164.0,
      // padding: EdgeInsets.fromLTRB(25, 25, 25, 25),
      width: double.infinity,
      color: Colors.white,//Color(0xfffafafa),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              Image.asset(
                'images/bp_main_top_bg.png',
                // fit: BoxFit.fill,
                height: 164.0,
                width: double.infinity,
              ),
              Container(
                padding: EdgeInsets.fromLTRB(30, 30, getUiSize(110), 0),
                height: 164.0,
                width: double.infinity,
                color: Colors.transparent,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(strTitle,
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            fontFamily: 'NanumRoundB',
                            fontSize: 14,
                            height: 1.6,
                            color: Colors.white)),
                    // Text('반가워요~🖐🖐',
                    //     textAlign: TextAlign.left,
                    //     style: TextStyle(
                    //         fontFamily: 'NanumRoundB',
                    //         fontSize: 14,
                    //         color: Colors.white)),
                    // SizedBox(height: 8,),
                    // Text('저는 당신만의 혈압 지키미예요!',
                    //     textAlign: TextAlign.left,
                    //     style: TextStyle(
                    //         fontFamily: 'NanumRoundB',
                    //         fontSize: 14,
                    //         color: Colors.white)),
                    // SizedBox(height: 8,),
                    // Text('오늘의 혈압을 기록해주세요 :)',
                    //     textAlign: TextAlign.left,
                    //     style: TextStyle(
                    //         fontFamily: 'NanumRoundB',
                    //         fontSize: 14,
                    //         color: Colors.white)),
                  ],
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
