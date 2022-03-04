import 'package:bloodpressure_keeper_app/ui/pages/feed/utils/GeneralUtils.dart';
import 'package:flutter/material.dart';
class MyPageTitle extends StatelessWidget {
  final String email ;
  final String nickName ;
  final String age ;
  final String sex ;
  final String viewMsg ;
  const MyPageTitle({
    Key? key,
    required this.email,
    required this.nickName,
    required this.age,
    required this.sex,
    required this.viewMsg
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height:getUiSize (150),
      width: double.infinity,
      color: Color(0xff131523),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: getUiSize(4),
                  ),
                  Text(
                    '마이',
                    style: TextStyle(
                        fontFamily: 'NanumRoundB',
                        fontSize: (isSmallSize() ? getUiSize(15) : getUiSize(12)),
                        color: Colors.white),
                  ),
                  SizedBox(
                    height: getUiSize(14),
                  ),
                  // Container(
                  //   width: double.infinity,
                  //   height: 1,
                  //   color: Colors.white,
                  // )
                ],
              )
          ),
          Row(
            children: [
              // Image.asset(
              //   'images/notebook_fill.png',
              //   height: 40,
              //   width: 40,
              // ),
              SizedBox(width: getUiSize (11),),
              Text(
                "${email}",
                style: TextStyle(
                    fontFamily: 'NanumRoundL', fontSize: getUiSize (12), color: Colors.white),
              ),
            ],
          ),
          SizedBox(
            height: 10.0,
          ),
          Column(
            //MainAxisAlignment: MainAxisAlignment.end,
            //crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                child: Container(
                  width: double.infinity,
                  height: getUiSize(80),
                  // padding: const EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    color: Color(0xffd5dff1),
                    borderRadius: BorderRadius.circular(9.0),
                  ),
                  child: Center(
                    child: Stack(
                      children: [
                        Positioned(
                            right: getUiSize (0.4),
                            top: getUiSize (15.4),
                            child: Image.asset(
                              'images/my_menu_title.png',
                              // fit: BoxFit.fill,
                              height: getUiSize(65),
                              width: getUiSize(100.5),
                              fit: BoxFit.fill,
                            )
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: getUiSize (14),),
                            Row(
                              children: [
                                SizedBox(width: getUiSize (10),),
                                Container(
                                  // padding: EdgeInsets.fromLTRB(9, 10, 10, 0),
                                  child:  Text(
                                    '${viewMsg}\n',
                                    style: TextStyle(
                                      // decoration: TextDecoration.underline,
                                        fontFamily: 'NanumRoundEB',
                                        fontSize: getUiSize (10.4),
                                        color: Color(0xff0057fb)),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                SizedBox(width: getUiSize (10),),
                                Container(
                                  // padding: EdgeInsets.fromLTRB(14, 0, 0, 0),
                                    child:  Text(
                                      '건강 매니저가 항상 당신을 응원해요!',
                                      style: TextStyle(
                                          fontFamily: 'NanumRoundEB',
                                          fontSize: getUiSize (10.4),
                                          color: Color(0xff131523)),
                                    )
                                ),
                              ],
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
