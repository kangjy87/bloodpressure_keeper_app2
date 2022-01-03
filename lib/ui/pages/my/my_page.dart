import 'dart:ui';

import 'package:bloodpressure_keeper_app/ui/pages/feed/utils/GeneralUtils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'my_controller.dart';
import 'my_page_title.dart';
import 'favorite_feed_list_form.dart';

class MyPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          foregroundColor: Colors.white,
          shadowColor: Colors.white,
          toolbarHeight: getUiSize (150),
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
                return Column(
                  children: [
                    Container(
                      child: TabBar(
                        labelStyle: TextStyle(
                          fontSize: 16,
                          fontFamily: 'NanumRoundB'
                        ),
                        labelColor: Color(0xff454f63),
                        unselectedLabelColor: Color(0xff78849e),
                        indicatorColor: Color(0xff454f63),
                        controller: controller.tabController,
                        onTap: (index){
                          print('?>>>>>>>>${index}');
                          controller.tabSetting(index);
                        },
                        tabs: [
                          Tab(icon: Image.asset(
                            controller.strTab1,
                            height: 17.5,
                            width: 17.5,
                          ),),
                          Tab(icon: Image.asset(
                            controller.strTab2,
                            height: 17.5,
                            width: 17.5,
                          ),)
                        ],
                      ),
                    ),
                    Container(
                      height: getUiSize(400),
                      child: TabBarView(
                        physics: NeverScrollableScrollPhysics(),
                        controller: controller.tabController,
                        children: [
                          FavoriteFeedListForm(),
                          Container(
                            child: ListView(
                              padding: const EdgeInsets.all(28),
                              children: [
                                GestureDetector(
                                  child: Container(
                                    height: getUiSize (70),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      // crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Image.asset(
                                          'images/warning_circle_fill.png',
                                          fit: BoxFit.fill,
                                          height: getUiSize (30),
                                          width: getUiSize (30),
                                        ),
                                        SizedBox(width: getUiSize (8),),
                                        Text(
                                          '개인정보 처리방침',
                                          style: TextStyle(
                                              fontFamily: 'NanumRoundB',
                                              fontSize: getUiSize (13),
                                              color: Color(0xff454f63)),
                                        ),
                                        Expanded(child: Text(''), flex: 9),
                                        Image.asset(
                                          'images/main_check_icon.png',
                                          fit: BoxFit.fill,
                                          height: getUiSize (13),
                                          width: getUiSize (13),
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
                                    height: getUiSize (70),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      // crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Image.asset(
                                          'images/sign_out_fill.png',
                                          fit: BoxFit.fill,
                                          height: getUiSize (30),
                                          width: getUiSize (30),
                                        ),
                                        SizedBox(width: getUiSize (8),),
                                        (controller.nickName == ""
                                            ? Text(
                                          '로그인',
                                          style: TextStyle(
                                              fontFamily: 'NanumRoundB',
                                              fontSize: getUiSize (13),
                                              color: Color(0xff454f63)),
                                        )
                                            : Text(
                                          '로그아웃',
                                          style: TextStyle(
                                              fontFamily: 'NanumRoundB',
                                              fontSize: getUiSize (13),
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
                                    height: getUiSize (70),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      // crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Image.asset(
                                          'images/notebook_fill.png',
                                          fit: BoxFit.fill,
                                          height: getUiSize (30),
                                          width: getUiSize (30),
                                        ),
                                        SizedBox(width: getUiSize (8),),
                                        Text(
                                          '버전정보',
                                          style: TextStyle(
                                              fontFamily: 'NanumRoundB',
                                              fontSize: getUiSize (13),
                                              color: Color(0xff454f63)),
                                        ),
                                        Expanded(child: Text(''), flex: 2),
                                        Container(
                                          width: getUiSize (130),
                                          height: getUiSize (30),
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
                                                      fontSize: getUiSize (10),
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
                          )
                        ],
                      ),
                    )
                  ],
                );
              }),
        ));
  }
}