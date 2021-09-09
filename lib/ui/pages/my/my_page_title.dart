import 'package:flutter/material.dart';
class MyPageTitle extends StatelessWidget {
  final String email ;
  final String nickName ;
  final String age ;
  final String sex ;
  const MyPageTitle({
    Key? key,
    required this.email,
    required this.nickName,
    required this.age,
    required this.sex,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 230.0,
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
                    height: 20,
                  ),
                  Text(
                    '마이',
                    style: TextStyle(
                        fontFamily: 'NanumRoundB',
                        fontSize: 18,
                        color: Colors.white),
                  ),
                  SizedBox(
                    height: 20,
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
              SizedBox(width: 25,),
              Text(
                "${email}",
                style: TextStyle(
                    fontFamily: 'NanumRoundL', fontSize: 15, color: Colors.white),
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
                  height: 107,
                  // padding: const EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    color: Color(0xffd5dff1),
                    borderRadius: BorderRadius.circular(9.0),
                  ),
                  child: Center(
                    child: Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 25,),
                            Row(
                              children: [
                                SizedBox(width: 20,),
                                Container(
                                  // padding: EdgeInsets.fromLTRB(9, 10, 10, 0),
                                  child:  Text(
                                    '${(age == null || age == '') ? '' : '$age년생'}  ${(sex == null || sex == '') ? '' : sex} ${nickName} 님\n',
                                    style: TextStyle(
                                      // decoration: TextDecoration.underline,
                                        fontFamily: 'NanumRoundEB',
                                        fontSize: 14.0,
                                        color: Color(0xff0057fb)),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                SizedBox(width: 20,),
                                Container(
                                    // padding: EdgeInsets.fromLTRB(14, 0, 0, 0),
                                    child:  Text(
                                      '지키미가 항상 당신을 응원해요!',
                                      style: TextStyle(
                                          fontFamily: 'NanumRoundEB',
                                          fontSize: 14.0,
                                          color: Color(0xff131523)),
                                    )
                                ),
                              ],
                            )
                          ],
                        ),
                        Expanded(
                            child: Image.asset(
                              'images/my_menu_title.png',
                              height: double.infinity,
                              width: double.infinity,
                              fit: BoxFit.fill
                            ),
                            flex: 1),
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
