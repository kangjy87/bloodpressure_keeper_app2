import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'my_controller.dart';
import 'my_page_title.dart';

class MyPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          foregroundColor: Colors.white,
          shadowColor: Colors.white,
          toolbarHeight: 230,
          elevation: 0,
          automaticallyImplyLeading: false,
          // backgroundColor: Colors.red,
          backgroundColor: Color(0xff131523),
          title: Container(
            child: GetBuilder<MyController>(
                init: MyController(),
                builder: (controller) {
                  return MyPageTitle(
                    email: controller.email,
                    nickName: controller.nickName,
                    age: controller.age,
                    sex: controller.sex,
                    viewMsg: controller.viewMsg,
                  );
                }),
          ),
          // title: Obx (() {return Text (Get.find<HomeController>().pageTitle.value);}),
        ),
        body: Container(
          child: GetBuilder<MyController>(
              init: MyController(),
              builder: (controller) {
                return Container(
                  child: ListView(
                    padding: const EdgeInsets.all(28),
                    children: [
                      GestureDetector(
                        child: Container(
                          height: 100,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            // crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Image.asset(
                                'images/warning_circle_fill.png',
                                fit: BoxFit.fill,
                                height: 40,
                                width: 40,
                              ),
                              SizedBox(width: 10,),
                              Text(
                                '개인정보 처리방침',
                                style: TextStyle(
                                    fontFamily: 'NanumRoundB',
                                    fontSize: 15.0,
                                    color: Color(0xff454f63)),
                              ),
                              Expanded(child: Text(''), flex: 9),
                              Image.asset(
                                'images/main_check_icon.png',
                                fit: BoxFit.fill,
                                height: 20,
                                width: 20,
                              ),
                              Expanded(child: Text(''), flex: 1),
                            ],
                          ),
                        ),
                        onTap: () {
                          controller.userInfoAgreement();
                        },
                      ),
                      GestureDetector(
                        child: Container(
                          height: 100,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            // crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Image.asset(
                                'images/sign_out_fill.png',
                                fit: BoxFit.fill,
                                height: 40,
                                width: 40,
                              ),
                              SizedBox(width: 10,),
                              (controller.nickName == ""
                                  ? Text(
                                      '로그인',
                                      style: TextStyle(
                                          fontFamily: 'NanumRoundB',
                                          fontSize: 15.0,
                                          color: Color(0xff454f63)),
                                    )
                                  : Text(
                                      '로그아웃',
                                      style: TextStyle(
                                          fontFamily: 'NanumRoundB',
                                          fontSize: 15.0,
                                          color: Color(0xff454f63)),
                                    ))
                            ],
                          ),
                        ),
                        onTap: () {
                          controller.newLogin(() {
                            print('구른다.');
                            controller.getInfo();
                          });
                        },
                      ),
                      GestureDetector(
                        child: Container(
                          height: 100,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            // crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Image.asset(
                                'images/notebook_fill.png',
                                fit: BoxFit.fill,
                                height: 40,
                                width: 40,
                              ),
                              SizedBox(width: 10,),
                              Text(
                                '버전정보',
                                style: TextStyle(
                                    fontFamily: 'NanumRoundB',
                                    fontSize: 15.0,
                                    color: Color(0xff454f63)),
                              ),
                              Expanded(child: Text(''), flex: 2),
                              Container(
                                width: 180.0,
                                height: 36,
                                // padding: const EdgeInsets.all(10.0),
                                decoration: BoxDecoration(
                                  border: Border.all(width: 1,color: Color(0xff78849e)),
                                  shape: BoxShape.rectangle,
                                  color: Colors.white,//Color(0xfff4f7fc),
                                  borderRadius: BorderRadius.circular(89.0),
                                ),
                                child:Center(
                                  child: Row(
                                    children: [
                                      Expanded(child: Text(''), flex: 1),
                                      Text("v ${controller.version}",
                                          style: TextStyle(
                                          fontFamily: 'NanumRoundB',
                                          fontSize: 12.0,
                                          color: Color(0xff454f63)),
                                        textAlign: TextAlign.center,),
                                      Expanded(child: Text(''), flex: 1),
                                    ],
                                  ),
                                ),
                              ),
                              Expanded(child: Text(''), flex: 1),],
                          ),
                        ),
                        onTap: () {},
                      ),
                    ],
                  ),
                );
              }),
        ));
  }
}