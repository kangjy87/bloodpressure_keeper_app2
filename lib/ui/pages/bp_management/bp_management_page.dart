import 'package:bloodpressure_keeper_app/ui/utils/bp_info_view/bp_info_listview_selectday.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'bp_management_controller.dart';
import 'package:bloodpressure_keeper_app/ui/utils/week_calendar/week_calendar_table.dart';
import 'package:bloodpressure_keeper_app/ui/pages/bp_management/bp_appbar_title.dart';
import 'package:bloodpressure_keeper_app/ui/utils/chart/combo_bar_line_chart.dart';

import 'bp_page_header.dart';

class BpManagementPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Container(
            child: GetBuilder<BpManagementController>(
              init: BpManagementController(),
              builder: (controller) => Container(
                // height: 148.0,
                // padding: EdgeInsets.fromLTRB(0, 0, 25, 0),
                width: double.infinity,
                color: Colors.white,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(child: Text(''), flex: 4),
                    Text(
                      "혈압관리",
                      style: TextStyle(
                          fontFamily: 'NanumRoundB',
                          fontSize: 20,
                          color: Colors.black),
                    ),
                    Expanded(child: Text(''), flex: 2),
                    Expanded(
                        child: Row(
                          children: [
                            Column(
                              children: [
                                // SizedBox(
                                //   height: 8,
                                // ),
                                Center(
                                    child: Text(
                                  "${controller.weatherTemp}",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontFamily: 'NanumRoundB',
                                      fontSize: 12.5,
                                      color: Colors.black),
                                ))
                              ],
                            ),
                            Container(
                              width: 30,
                              height: 30,
                              child: Row(
                                children: [
                                  Visibility(
                                      visible: !controller.weatherImgCheck,
                                      child: GestureDetector(
                                        child: Image.asset(
                                          'images/main_pul_icon.png',
                                          width: 30,
                                          height: 30,
                                        ),
                                        onTap: (){
                                          controller.callPermissionChecked(context);
                                        },
                                      )),
                                  Visibility(
                                      visible: controller.weatherImgCheck,
                                      child: Image.asset(
                                        controller.weatherImg,
                                        width: 30,
                                        height: 30,
                                      ))
                                ],
                              ),
                            ),
                          ],
                        ),
                        flex: 2),
                  ],
                ),
              ),
            ),
          ),
          // title: Obx (() {return Text (Get.find<HomeController>().pageTitle.value);}),
        ),
        body: Container(
            color: Colors.white,
            child: GetBuilder<BpManagementController>(
              init: BpManagementController(),
              builder: (controller) => SingleChildScrollView(
                child: Column(
                  children: [
                    Stack(
                      children: [
                        BpPageHeader(),
                        /**
                             * 날짜 선택 달력
                             */
                        Container(
                          padding: EdgeInsets.fromLTRB(0, 160, 0, 10),
                          child: WeekCalendarTable(
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
                              controller.selectDayInfo();
                            },
                            onPageChanged: (focusedDay) {
                              controller.changeFocusedDay(focusedDay);
                              controller.selectDayInfo();
                              controller.chartRefresh();
                            },
                          ),
                        )
                      ],
                    ),
                    Stack(
                      children: [
                        /**
                         * 선택일 혈압지수
                         */
                        BpInfoListviewSelectDay(
                          bpRiskLevel: controller.bpRiskLevel,
                          beforeBtnImg: controller.beforeBtnImg,
                          afterBtnImg: controller.afterBtnImg,
                          position: controller.position,
                          lastPage: (controller.selectDayBPDataList.length - 1),
                          selectDayInfoList: controller.selectDayBPDataList,
                          pageController: controller.pageController,
                          setonclicked: (btn, index, lastIndex) {
                            controller.selectDayBpInfoBtn(btn, lastIndex);
                          },
                          detailPageClick: (data) {
                            DateTime nowDate = DateTime.now();
                            controller.detailPageGo(data, () {
                              controller.changeSelectedDay(
                                  nowDate, nowDate); //선택일 오늘로 셋팅
                              controller.chartRefresh(); //차트 리플리쉬
                              controller.selectDayInfo(); //정보보여지기
                            });
                          },
                        ),
                        Container(
                          width: double.infinity,
                          height: 300,
                          child: Visibility(
                              visible: controller.bpDataCheck,
                              child: Container(
                                padding: EdgeInsets.fromLTRB(0, 30, 0, 0),
                                width: double.infinity,
                                height: 300,
                                decoration: BoxDecoration(
                                  color: Colors.white70,
                                  // color: Colors.black87,
                                ),
                                child: Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          // Text(
                                          //   "아래",
                                          //   textAlign: TextAlign.center,
                                          //   style: TextStyle(
                                          //       fontFamily: 'NanumRoundEB',
                                          //       fontSize: 20,
                                          //       color: Color(0xff454f63)),
                                          // ),
                                          Image.asset(
                                            'images/plus_text_icon.png',
                                            // fit: BoxFit.fill,
                                            height: 75,
                                            width: 75,
                                          ),
                                          Text(
                                            "버튼을 눌러 ",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                fontFamily: 'NanumRoundEB',
                                                fontSize: 20,
                                                color: Color(0xff454f63)),
                                          )
                                        ],
                                      ),
                                      Text(
                                        "혈압을 입력해주세요!",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontFamily: 'NanumRoundEB',
                                            fontSize: 20,
                                            color: Color(0xff454f63)),
                                      )
                                    ],
                                  ),
                                ),
                              ),),
                        ),
                      ],
                    ),
                    // BpInfoViewSelectDay(
                    //   beforeSys: controller.beforeSys,
                    //   beforeDia: controller.beforeDia,
                    //   beforePul: controller.beforePul,
                    // ),
                    Container(
                      color: Color(0xfff4f7fc),
                      height: 20,
                    ),
                    /**
                         * 차트
                         */
                    Container(
                      padding: EdgeInsets.fromLTRB(23, 20 , 0, 0),
                      color: Colors.white,
                      height: 40,
                      width: double.infinity,
                      child: Text('평균 혈압 모니터링',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            fontFamily: 'NanumRoundEB',
                            fontSize: 14,
                            color: Color(0xff131523)),),
                    ),
                    Container(
                      padding: const EdgeInsets.fromLTRB(24, 0, 24, 0),
                      width: double.infinity,
                      height: 180,
                      child: Visibility(
                          visible: controller.chartDataCheck,
                          child: ComboBarLineChart(
                              width: double.infinity,
                              height: double.infinity,
                              systolicData: controller.systolicData,
                              diastoleData: controller.diastoleData,
                              pulseData: controller.pulseData,
                              setOnclick: (String data,int pulse){
                                if(pulse != null && pulse > 0){
                                  print('개빡침${data}');
                                }
                              },
                          )
                      ),
                    ),
                    SizedBox(height: 90,)
                  ],
                ),
              ),
            )),
        floatingActionButton: GetBuilder<BpManagementController>(
            init: BpManagementController(),
            builder: (controller) {
              return FloatingActionButton(
                  child: Icon(Icons.add),
                  backgroundColor: Color(0xff454f63),
                  onPressed: () {
                    DateTime nowDate = DateTime.now();
                    controller.selfBpInput(() {
                      controller.changeSelectedDay(
                          nowDate, nowDate); //선택일 오늘로 셋팅
                      controller.chartRefresh(); //차트 리플리쉬
                      controller.selectDayInfo(); //정보보여지기
                    });
                  });
            }));
  }
}
