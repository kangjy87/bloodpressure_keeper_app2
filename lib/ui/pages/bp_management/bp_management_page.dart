import 'package:bloodpressure_keeper_app/ui/pages/feed/utils/GeneralUtils.dart';
import 'package:bloodpressure_keeper_app/ui/utils/bp_info_view/bp_info_listview_selectday.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'bp_management_controller.dart';
import 'package:bloodpressure_keeper_app/ui/utils/week_calendar/week_calendar_table.dart';
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
                    SizedBox(width: getUiSize(95),),
                    // Expanded(child: Text(''), flex: 7),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "혈압관리",
                            style: TextStyle(
                                fontFamily: 'NanumRoundB',
                                fontSize: (isSmallSize() ? getUiSize(15) : getUiSize(12)),
                                color: Color(0xff454f63)),
                          )
                        ],
                      ),
                    ),
                    SizedBox(width: getUiSize(95),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.center,
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
                                      fontSize: getUiSize(10),
                                      color: Colors.black),
                                ))
                          ],
                        ),
                        Container(
                          width: getUiSize(26),
                          height: getUiSize(26),
                          child: Row(
                            children: [
                              Visibility(
                                  visible: (!controller.weatherImgCheck && !controller.gpsCheck),
                                  child: GestureDetector(
                                    child: Container(
                                      padding: EdgeInsets.only(left: 0, top: 0, right: 0, bottom: 0),
                                      child: Image.asset(
                                        'images/weather_setting.png',
                                        width: getUiSize(26),
                                        height: getUiSize(26),
                                      ),
                                    ),
                                    onTap: (){
                                      controller.callPermissionChecked(context);
                                    },
                                  )),
                              Visibility(
                                  visible: controller.weatherImgCheck,
                                  child: Image.asset(
                                    controller.weatherImg,
                                    width: getUiSize(26),
                                    height: getUiSize(26),
                                  ))
                            ],
                          ),
                        ),
                      ],
                    ),),
                    // Expanded(child: Text(''), flex: (!controller.weatherImgCheck && !controller.gpsCheck) ? 5 : 4 ),
                    // Expanded(
                    //     child: Row(
                    //       children: [
                    //         Column(
                    //           children: [
                    //             // SizedBox(
                    //             //   height: 8,
                    //             // ),
                    //             Center(
                    //                 child: Text(
                    //               "${controller.weatherTemp}",
                    //               textAlign: TextAlign.center,
                    //               style: TextStyle(
                    //                   fontFamily: 'NanumRoundB',
                    //                   fontSize: 12.5,
                    //                   color: Colors.black),
                    //             ))
                    //           ],
                    //         ),
                    //         Container(
                    //           width: 30,
                    //           height: 30,
                    //           child: Row(
                    //             children: [
                    //               Visibility(
                    //                   visible: (!controller.weatherImgCheck && !controller.gpsCheck),
                    //                   child: GestureDetector(
                    //                     child: Container(
                    //                       padding: EdgeInsets.only(left: 0, top: 0, right: 0, bottom: 0),
                    //                       child: Image.asset(
                    //                         'images/weather_setting.png',
                    //                         width: 30,
                    //                         height: 30,
                    //                       ),
                    //                     ),
                    //                     onTap: (){
                    //                       controller.callPermissionChecked(context);
                    //                     },
                    //                   )),
                    //               Visibility(
                    //                   visible: controller.weatherImgCheck,
                    //                   child: Image.asset(
                    //                     controller.weatherImg,
                    //                     width: 30,
                    //                     height: 30,
                    //                   ))
                    //             ],
                    //           ),
                    //         ),
                    //       ],
                    //     ),
                    //     flex: (!controller.weatherImgCheck && !controller.gpsCheck) ? 2 : 0 ),
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
                        BpPageHeader(
                          strTitle: controller.strTitleMsg,
                        ),
                        /**
                         * 날짜 선택 달력
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
                            controller.detailPageGo(data, () {
                              controller.getServerBpList(true);
                              // controller.chartRefresh(); //차트 리플리쉬
                              // controller.selectDayInfo(); //정보보여지기
                            });
                          },
                          selfPageClick: (){
                            controller.selfBpInput(() {
                              controller.getServerBpList(true);
                              // controller.chartRefresh(); //차트 리플리쉬
                              // controller.selectDayInfo(); //정보보여지기
                            });
                          },
                        ),
                        GestureDetector(
                          child: Container(
                            width: double.infinity,
                            height: getUiSize(250),
                            child: Visibility(
                              visible: controller.bpDataCheck,
                              child: Container(
                                padding: EdgeInsets.fromLTRB(0, 30, 0, 0),
                                width: double.infinity,
                                height: getUiSize(250),
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
                          onTap: (){
                            controller.selfBpInput(() {
                              controller.chartRefresh(); //차트 리플리쉬
                              controller.selectDayInfo(); //정보보여지기
                            });
                          },
                        )
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
                      child: Text(controller.strChartTitle,
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
                                  controller.chartCheck(data);
                                }
                              },
                          )
                      ),
                    ),
                    SizedBox(height: getUiSize(55),)
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
                    controller.selfBpInput(() {
                      controller.getServerBpList(true);
                      // controller.chartRefresh(); //차트 리플리쉬
                      // controller.selectDayInfo(); //정보보여지기
                      // controller.titleSetting(); //타이틀바
                    });
                  });
            }));
  }
}
