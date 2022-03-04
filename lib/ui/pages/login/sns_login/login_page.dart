import 'package:bloodpressure_keeper_app/ui/pages/feed/utils/GeneralUtils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'login_controller.dart';

class LoginPage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // leading: IconButton(
        //   onPressed: () {
        //     Navigator.of(context).pop();
        //   },
        //   icon: Icon(Icons.arrow_back, color: Colors.black),
        // ),
        toolbarHeight: 0,
        title: Text(
          '로그인',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),
      body: Container(
        child: GetBuilder<LoginController>(
            init: LoginController(),
            builder: (controller) {
              return Center(
                child: Column(
                  children: [
                    Expanded(
                        child: Stack(
                          children: [
                            Container(
                              color: Color(0xff131522),
                              height: double.infinity,
                              width: double.infinity,
                            ),
                            Positioned(
                                right: getUiSize (0.4),
                                // bottom: getUiSize (0.4),
                                top: getUiSize (35.4),
                                child: Image.asset(
                                  'images/login_bg.png',
                                  // fit: BoxFit.fill,
                                  height: getUiSize(220),
                                  width: getUiSize(245.5),
                                  fit: BoxFit.fill,
                                )
                            ),
                            Container(
                              padding: EdgeInsets.fromLTRB(getUiSize(60), getUiSize(60), 0, 0),
                              height: double.infinity,
                              width: double.infinity,
                              color: Colors.transparent,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('건강매니저',
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                          fontFamily: 'NanumRoundB',
                                          fontSize: getUiSize(22),
                                          color: Colors.white)),
                                  SizedBox(
                                    height: 8,
                                  ),
                                  Text('당신의 건강 관리 매니저',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontFamily: 'NanumRoundR',
                                          fontSize: getUiSize(10),
                                          color: Color(0xffc7c7c7))),
                                ],
                              ),
                            ),
                          ],
                        ),
                        flex: 2),
                    Expanded(
                        child: Column(
                          children: [
                            Expanded(
                              flex: 3,
                              child: Text(''),
                            ),
                            Container(
                              padding: EdgeInsets.all(30),
                              width: double.infinity,
                              child: Text('',
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      fontFamily: 'NanumRoundB',
                                      fontSize: 17.5,
                                      color: Color(0xff131523))),
                            ),
                            Expanded(
                              child: Text(''),
                            ),
                            GestureDetector(
                              child: Container(
                                padding: EdgeInsets.fromLTRB(getUiSize(15), 0, getUiSize(15), 0),
                                width: getUiSize(250),
                                height: getUiSize(40),
                                decoration: BoxDecoration(
                                  shape: BoxShape.rectangle,
                                  color: Color(0xfffff068),
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                child: Center(
                                  child: Row(
                                    children: [
                                      Expanded(
                                        flex: 3,
                                        child: Text(''),
                                      ),
                                      Image.asset(
                                        'images/kakao.png',
                                        height: getUiSize(24),
                                        width: getUiSize(24),
                                      ),
                                      SizedBox(width: 30,),
                                      Container(
                                        width: getUiSize(120),
                                        child: Text('카카오로 시작하기',
                                            textAlign: TextAlign.left,
                                            style: TextStyle(
                                                fontFamily: 'NanumRoundB',
                                                fontSize: getUiSize(11),
                                                color: Color(0xff131523))),
                                      ),
                                      Expanded(
                                        flex: 3,
                                        child: Text(''),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              onTap: () {
                                controller.kakaoLogin();
                              },
                            ),
                            Expanded(
                              child: Text(''),
                            ),
                            GestureDetector(
                              child: Container(
                                // padding: EdgeInsets.all(30),
                                width: getUiSize(250),
                                height: getUiSize(40),
                                decoration: BoxDecoration(
                                  border: Border.all(width: 1),
                                  shape: BoxShape.rectangle,
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                child: Center(
                                  child: Row(
                                    children: [
                                      Expanded(
                                        flex: 3,
                                        child: Text(''),
                                      ),
                                      Image.asset(
                                        'images/google.png',
                                        height: getUiSize(24),
                                        width: getUiSize(24),
                                      ),
                                      SizedBox(width: 30,),
                                      Container(
                                        width: getUiSize(120),
                                        child: Text('구글로 시작하기',
                                            textAlign: TextAlign.left,
                                            style: TextStyle(
                                                fontFamily: 'NanumRoundB',
                                                fontSize: getUiSize(11),
                                                color: Color(0xff454f63))),
                                      ),
                                      Expanded(
                                        flex: 3,
                                        child: Text(''),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              onTap: () {
                                controller.googleLogin();
                              },
                            ),
                            Expanded(
                              child: Text(''),
                            ),
                            GestureDetector(
                              child: Container(
                                // padding: EdgeInsets.all(30),
                                width: getUiSize(250),
                                height: getUiSize(40),
                                decoration: BoxDecoration(
                                  shape: BoxShape.rectangle,
                                  color: Colors.black,
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                child: Center(
                                  child: Row(
                                    children: [
                                      Expanded(
                                        flex: 3,
                                        child: Text(''),
                                      ),
                                      Image.asset(
                                        'images/apple.png',
                                        height:getUiSize(24),
                                        width: getUiSize(24),
                                      ),
                                      SizedBox(width: 30,),
                                      Container(
                                        width: getUiSize(120),
                                        child:Text('애플로 시작하기',
                                            textAlign: TextAlign.left,
                                            style: TextStyle(
                                                fontFamily: 'NanumRoundB',
                                                fontSize: getUiSize(11),
                                                color: Color(0xffffffff))),
                                      ),
                                      Expanded(
                                        flex: 3,
                                        child: Text(''),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              onTap: () {
                                controller.appleLogin();
                              },
                            ),
                            Expanded(
                              flex: 6,
                              child: Text(''),
                            ),
                          ],
                        ),
                        flex: 3),
                  ],
                ),
              );
            }),
      ),
    );
  }
}