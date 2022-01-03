import 'package:bloodpressure_keeper_app/ui/pages/feed/utils/GeneralUtils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:bloodpressure_keeper_app/ui/pages/bp_management/self_bp_input/self_bp_input_controller.dart';
import 'package:bloodpressure_keeper_app/ui/utils/week_calendar/week_calendar_table.dart';
import 'package:bloodpressure_keeper_app/ui/utils/btns/bottom_fullsize_btn.dart';
import 'package:bloodpressure_keeper_app/utils/app_strings.dart';
import 'package:bloodpressure_keeper_app/utils/app_colors.dart';
import 'package:bloodpressure_keeper_app/ui/utils/msg_alert_dialog/onebutton_alert.dart';
import 'package:bloodpressure_keeper_app/ui/pages/bp_management/self_bp_input/self_bp_input_form.dart';

class SelfBpInputPage extends StatelessWidget {
  const SelfBpInputPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SelfBpInputController>(builder: (controller) {
      return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: Image.asset(
              'images/appbar_back.png',
              // fit: BoxFit.fill,
              height: getUiSize(22),
              width: getUiSize(22),
            ),
          ),
          title: Center(
            child: Row(

              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  controller.title,
                  textAlign : TextAlign.center,
                  style: TextStyle(
                      fontFamily: 'NanumRoundB',
                      fontSize: (isSmallSize() ? getUiSize(15) : getUiSize(12)),
                      color: Color(0xff454f63)),
                ),
                SizedBox(width: getUiSize(35),)
              ],
            )
          ),
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
        ),
        body: Container(
          child: Center(
            child: Column(
              children: [
                Expanded(
                    flex: 1,
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Container(
                            child: Stack(
                              children: [
                                Container(
                                  color: Color(0xff131522),
                                  width: double.infinity,
                                  height: getUiSize(97),
                                ),
                                Positioned(
                                    left: getUiSize (0.4),
                                    top: getUiSize (0.1),
                                    child: Image.asset(
                                      'images/self_bp_input_title.png',
                                      // fit: BoxFit.fill,
                                      height: getUiSize(110),
                                      width: getUiSize(280.5),
                                      fit: BoxFit.fill,
                                    )
                                ),

                                // Image.asset(
                                //   'images/self_bp_input_title.png',
                                //   // fit: BoxFit.fill,
                                //   height: 164.0,
                                //   width: double.infinity,
                                //   fit: BoxFit.fill,
                                // ),
                                Container(
                                  padding: EdgeInsets.fromLTRB(getUiSize(0), 30, 30, 0),
                                  height: getUiSize(110.5),
                                  width: double.infinity,
                                  color: Colors.transparent,
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Text('혈압을 입력해주세요 :)',
                                          textAlign: TextAlign.left,
                                          style: TextStyle(
                                              fontFamily: 'NanumRoundB',
                                              fontSize: (isSmallSize() ? getUiSize(12) : getUiSize(11)),
                                              color: Colors.white)),
                                      SizedBox(height: getUiSize(3),),
                                      Text('혈압건강 추이를',
                                          textAlign: TextAlign.left,
                                          style: TextStyle(
                                              fontFamily: 'NanumRoundB',
                                              fontSize: (isSmallSize() ? getUiSize(12) : getUiSize(11)),
                                              color: Colors.white)),
                                      SizedBox(height: getUiSize(3),),
                                      Text('한 눈에 보여드릴게요!',
                                          textAlign: TextAlign.left,
                                          style: TextStyle(
                                              fontFamily: 'NanumRoundB',
                                              fontSize: (isSmallSize() ? getUiSize(12) : getUiSize(11)),
                                              color: Colors.white)),
                                    ],
                                  ),
                                ),
                                /**
                                 *  날짜 선택 달력
                                 */
                                Container(
                                  padding: EdgeInsets.fromLTRB(0, getUiSize(115), 0, getUiSize(8)),
                                  child: WeekCalendarTable(
                                    datePicker: (){
                                      controller.selectDataPicker(context);
                                    },
                                    pageControllers: controller.pageControllers,
                                    pageControllerFunction:
                                        (PageController pageController) {
                                      controller.pageControllers = pageController;
                                    },
                                    selectedDay: controller.selectedDay,
                                    focusedDay: controller.focusedDay,
                                    onDaySelected: (selectedDay, focusedDay) {
                                      controller.changeSelectedDay(
                                          selectedDay, focusedDay);
                                    },
                                    onPageChanged: (focusedDay) {
                                      controller.changeFocusedDay(focusedDay);
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                          /**
                           *  데이터 입력
                            */
                          SelfBpInputForm(
                              sys: controller.resultSys,
                              dia: controller.resultDia,
                              focusDia: controller.focusDia,
                              pul: controller.resultPul,
                              focusPul: controller.focusPul,
                              memo: controller.resultMemo,
                              focusMemo: controller.focusMemo,),
                        ],
                      ),
                    )),
                /**
                 * 등록버튼
                  */
                BottomFullSizeBtn(
                    text: AppStrings.strBpInput,
                    textColor: Colors.white,
                    backgroundColor: Color(AppColors.colorBtnActivate),
                    setonclicklistener: () {
                      FocusScopeNode currentFocus = FocusScope.of(context);
                      currentFocus.unfocus(); //키보드 내리기
                      // controller.localDbInsert((){
                        controller.serverDBInsert((){
                          oneButtonAlert(
                              context,
                              AppStrings.strSuccessTitle,
                              AppStrings.strSuccessMsg,
                              AppStrings.strButtonClose, () {
                            Get.back();
                            Get.back(result:{"date":controller.selectedDay});
                          });
                        },(){
                          oneButtonAlert(
                              context,
                              "에러",
                              "통신이 원활하지 않아 저장에 실패하였습니다.",
                              "종료", () {
                            Navigator.pop(context);
                            Get.back();
                            Get.back();
                          });
                        });
                      // });
                    })
              ],
            ),
          ),
        ),
      );
    });
  }
}
