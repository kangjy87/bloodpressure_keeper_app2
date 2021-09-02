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
          '로그',
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
                            Image.asset(
                              'images/login_bg.png',
                              fit: BoxFit.fill,
                              height: double.infinity,
                              width: double.infinity,
                            ),
                            Container(
                              padding: EdgeInsets.fromLTRB(0, 80, 200, 0),
                              height: double.infinity,
                              width: double.infinity,
                              color: Colors.transparent,
                              child: Column(
                                children: [
                                  Text('혈압지키미',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontFamily: 'NanumRoundB',
                                          fontSize: 25,
                                          color: Colors.white)),
                                  SizedBox(
                                    height: 8,
                                  ),
                                  Text('당신의 혈압 관리 매니저',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontFamily: 'NanumRoundR',
                                          fontSize: 12.5,
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
                              child: Text('LOGIN',
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
                                padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
                                width: 350,
                                height: 50,
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
                                        height: 30,
                                        width: 30,
                                      ),
                                      Expanded(
                                        flex: 2,
                                        child: Text(''),
                                      ),
                                      Text('Sign in with KakaoTalk',
                                          textAlign: TextAlign.left,
                                          style: TextStyle(
                                              fontFamily: 'NanumRoundB',
                                              fontSize: 13.3,
                                              color: Color(0xff131523))),
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
                                width: 350,
                                height: 50,
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
                                        height: 30,
                                        width: 30,
                                      ),
                                      Expanded(
                                        flex: 2,
                                        child: Text(''),
                                      ),
                                      Text('Sign in with Google',
                                          textAlign: TextAlign.left,
                                          style: TextStyle(
                                              fontFamily: 'NanumRoundB',
                                              fontSize: 13.3,
                                              color: Color(0xff454f63))),
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
                                width: 350,
                                height: 50,
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
                                        height: 30,
                                        width: 30,
                                      ),
                                      Expanded(
                                        flex: 2,
                                        child: Text(''),
                                      ),
                                      Text('Sign in with Apple',
                                          textAlign: TextAlign.left,
                                          style: TextStyle(
                                              fontFamily: 'NanumRoundB',
                                              fontSize: 13.3,
                                              color: Color(0xffffffff))),
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