import 'package:bloodpressure_keeper_app/ui/pages/dashboard/dashboard_page.dart';
import 'package:bloodpressure_keeper_app/ui/pages/feed/utils/GeneralUtils.dart';
import 'package:bloodpressure_keeper_app/ui/utils/msg_alert_dialog/onebutton_alert.dart';
import 'package:bloodpressure_keeper_app/utils/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'join_addinfo_controller.dart';
import 'join_addinfo_title.dart';
import 'nickname_info_form.dart';
import 'basic_info_form.dart';
class JoinAddInfoPage extends StatelessWidget {
  const JoinAddInfoPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<JoinAddInfoController>(builder: (controller) {
      final PageController pageController = PageController(
        initialPage: controller.pagerIndex ,

      );
      return Scaffold(

        appBar: AppBar(
          automaticallyImplyLeading: false,
          // leading: IconButton(
          //   onPressed: () {
          //     Navigator.of(context).pop();
          //   },
          //   // icon: Icon(Icons.arrow_back, color: Colors.black),
          // ),
          toolbarHeight: getUiSize(170),
          title: JoinAddInfoTitle(
            firstTitle: controller.firstTitle,
            secondTitle: controller.secondTitle,
          ),
          elevation: 0,
          backgroundColor: Color(0xfff4f7fc),
        ),


        body: PageView(
          controller: pageController,
          physics: new NeverScrollableScrollPhysics(),
          children: [
            SizedBox.expand(
              child: NickNameInfoForm(
                nickname: controller.txtNickname,
                setonclicklistener: (){
                  controller.pageChange();
                  pageController.animateToPage(controller.pagerIndex, duration: Duration(milliseconds: 300), curve: Curves.ease);
                },
              ),
            ),
            // 두 번째 페이지
            SizedBox.expand(
              child: BasicInfoForm(
                age: controller.txtAge,
                sexIndex: controller.sexCheckIndex,
                radioBtnSexCheck: (index){
                  controller.radioBtnChange(index);
                },
                agreementCall: (){
                  controller.userInfoAgreement();
                },
                setonclicklistener: (sex){
                  controller.joinMembership(controller.txtNickname.text,sex,controller.txtAge.text,(){
                    oneButtonAlert(
                        context,
                        AppStrings.strSuccessTitle,
                        AppStrings.strSuccessMsg,
                        AppStrings.strButtonClose, () {
                          Get.offAll(DashboardPage(),transition: Transition.rightToLeft);
                    });
                  });
                },
              ),
            ),
          ],
        ),
      );
    });
  }
}
