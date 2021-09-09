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
              height: 30,
              width: 30,
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
                      fontSize: 18,
                      color: Color(0xff454f63)),
                ),
                SizedBox(width: 55,)
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
                          Stack(
                            children: [
                              Image.asset(
                                'images/self_bp_input_title.png',
                                // fit: BoxFit.fill,
                                height: 164.0,
                                width: double.infinity,
                              ),
                              Container(
                                padding: EdgeInsets.fromLTRB(220, 30, 0, 0),
                                height: 164.0,
                                width: double.infinity,
                                color: Colors.transparent,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('혈압을 입력해주세요 :)',
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                            fontFamily: 'NanumRoundB',
                                            fontSize: 14,
                                            color: Colors.white)),
                                    SizedBox(height: 8,),
                                    Text('혈압건강 추이를',
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                            fontFamily: 'NanumRoundB',
                                            fontSize: 14,
                                            color: Colors.white)),
                                    SizedBox(height: 8,),
                                    Text('한 눈에 보여드릴게요!',
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                            fontFamily: 'NanumRoundB',
                                            fontSize: 14,
                                            color: Colors.white)),
                                  ],
                                ),
                              ),
                              /**
                               *  날짜 선택 달력
                               */
                              Container(
                                padding: EdgeInsets.fromLTRB(10, 160, 10, 10),
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
                          /**
                           *  데이터 입력
                            */
                          SelfBpInputForm(
                              sys: controller.resultSys,
                              dia: controller.resultDia,
                              pul: controller.resultPul,
                              memo: controller.resultMemo),
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
                      controller.localDbInsert((){
                        oneButtonAlert(
                            context,
                            AppStrings.strSuccessTitle,
                            AppStrings.strSuccessMsg,
                            AppStrings.strButtonClose, () {
                          Navigator.pop(context);
                          Navigator.pop(context, 'S');
                        });
                      });
                    })
              ],
            ),
          ),
        ),
      );
    });
  }
}
