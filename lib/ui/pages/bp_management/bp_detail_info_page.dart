import 'package:bloodpressure_keeper_app/model/blood_pressure_item.dart';
import 'package:bloodpressure_keeper_app/ui/pages/feed/utils/GeneralUtils.dart';
import 'package:bloodpressure_keeper_app/ui/utils/btns/bottom_fullsize_btn.dart';
import 'package:bloodpressure_keeper_app/ui/utils/msg_alert_dialog/onebutton_alert.dart';
import 'package:bloodpressure_keeper_app/utils/app_colors.dart';
import 'package:bloodpressure_keeper_app/utils/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'bp_detail_info_controller.dart';
import 'package:flutter/services.dart';

class BpDetailInfoPage extends StatelessWidget {
  const BpDetailInfoPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<BpDetailInfoController>(builder: (controller) {
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
                      "정보수정",
                      textAlign : TextAlign.center,
                      style: TextStyle(
                          fontFamily: 'NanumRoundB',
                          fontSize: 18,
                          color: Color(0xff454f63)),
                    ),
                    SizedBox(width: 60,)
                  ],
                )
            ),
            backgroundColor: Colors.white,
            foregroundColor: Colors.black,
          ),
          body: Column(
            children: [
              Expanded(
                  flex: 6,
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
                                    Text('혈압을 수정해주세요 :)',
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                            fontFamily: 'NanumRoundB',
                                            fontSize: (isSmallSize() ? getUiSize(12) : getUiSize(11)),
                                            color: Colors.white)),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 10,),
                        Container(
                          width: getUiSize(240),
                          height: getUiSize(40),
                          // padding: const EdgeInsets.all(10.0),
                          decoration: BoxDecoration(
                            shape: BoxShape.rectangle,
                            color: Color(0xfff4f7fc),
                            borderRadius: BorderRadius.circular(89.0),
                          ),
                          child: Center(
                            child: Row(
                              children: [
                                Expanded(child: Text(''), flex: controller.data.weatherImg != '' ? 1 : 2),
                                Text(DateFormat('yyyy-MM-dd').format(DateTime.parse(controller.data.saveData!)) == controller.data.rData
                                    ?"${DateFormat('yyyy.MM.dd HH시 mm분').format(DateTime.parse(controller.data.saveData!))} "
                                    :"${DateFormat('yyyy.MM.dd').format(DateTime.parse(controller.data.rData!))} ",
                                  style: TextStyle(
                                      fontFamily: 'NanumRoundB',
                                      fontSize: getUiSize(12),
                                      color: Color(0xff78849e)),
                                  textAlign: TextAlign.center,),
                                Expanded(child: Text(''), flex: 1),
                                Text("${controller.data.weatherTemp} ",style: TextStyle(
                                    fontFamily: 'NanumRoundB',
                                    fontSize: getUiSize(12),
                                    color: Color(0xff78849e)),
                                  textAlign: TextAlign.center,),
                                Visibility(visible: controller.data.weatherImg != '',child: Image.asset(controller.data.weatherImg!, width: getUiSize(27), height: getUiSize(27),),),
                                Expanded(child: Text(''), flex: 1),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 20,),
                        /**
                         * 수축혈압
                         */
                        Container(
                          height: getUiSize(53),
                          padding: EdgeInsets.fromLTRB(getUiSize(5), 0, getUiSize(10), getUiSize(10)),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Image.asset(
                                'images/main_sys_icon.png',
                                height: getUiSize(39),
                                width: getUiSize(39),
                              ),
                              SizedBox(width: getUiSize(6)),
                              SizedBox(
                                width: getUiSize(60),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      '수축기 혈압',
                                      style: TextStyle(
                                          fontFamily: 'NanumRoundEB',
                                          fontSize: getUiSize(10.5),
                                          color: Colors.black),
                                    ),
                                    Text(
                                      'SYS/mmHg',
                                      style: TextStyle(
                                        fontFamily: 'NanumRoundEB',
                                        fontSize: getUiSize(8),
                                        color: Color(0xff78849e),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Expanded(child: Text(''), flex: 1),
                              // TextFormField(
                              //     initialValue: '${_mainView.intResultSys}'
                              //   ,style: TextStyle(fontFamily: 'NanumRoundEB',fontSize: 25.0, color: Colors.black ),
                              //       decoration: InputDecoration(
                              //         border: OutlineInputBorder(),
                              //         labelText: 'Hint',
                              //       )
                              //   ),
                              Expanded(
                                child: SizedBox(
                                  height: getUiSize(33),
                                  child: TextFormField(
                                    // autovalidateMode: AutovalidateMode.always,
                                    // validator : (String? value) {
                                    //   return (value != null && int.parse(value) > 200)
                                    //       ? '혈압지수가 너무 높습니다.' : null ;
                                    // },
                                    keyboardType: TextInputType.number,
                                    // ignore: deprecated_member_use
                                    inputFormatters: [WhitelistingTextInputFormatter(RegExp('[0-9]')),],
                                    controller: controller.resultSys,
                                    style: TextStyle(fontSize: getUiSize(12),height: 1),
                                    textAlign: TextAlign.center,
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(32.0)),
                                      // labelText: '수축기혈압',
                                    ),
                                    textInputAction: TextInputAction.next,
                                    onFieldSubmitted: (v){
                                      FocusScope.of(context).requestFocus(controller.focusDia);
                                    },
                                  ),
                                ),
                                flex: 3,
                              ),
                            ],
                          ),
                        ),
                        /**
                         * 이완기 혈압
                         */
                        Container(
                          height: getUiSize(53),
                          padding: EdgeInsets.fromLTRB(getUiSize(5), 0, getUiSize(10), getUiSize(10)),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Image.asset(
                                'images/main_dia_icon.png',
                                height: getUiSize(39),
                                width: getUiSize(39),
                              ),
                              SizedBox(width: getUiSize(6)),
                              SizedBox(
                                width: getUiSize(60),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      '이완기 혈압',
                                      style: TextStyle(
                                          fontFamily: 'NanumRoundEB',
                                          fontSize: getUiSize(10.5),
                                          color: Colors.black),
                                    ),
                                    Text(
                                      'DIA/mmHg',
                                      style: TextStyle(
                                        fontFamily: 'NanumRoundEB',
                                        fontSize: getUiSize(8),
                                        color: Color(0xff78849e),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Expanded(child: Text(''), flex: 1),
                              Expanded(
                                child: SizedBox(
                                  height: getUiSize(33),
                                  child: TextFormField(
                                    // autovalidateMode: AutovalidateMode.always,
                                    // validator : (String? value) {
                                    //   return (value != null && int.parse(value) > 200)
                                    //       ? '혈압지수가 너무 높습니다.' : null ;
                                    // },
                                    keyboardType: TextInputType.number,
                                    // ignore: deprecated_member_use
                                    inputFormatters: [WhitelistingTextInputFormatter(RegExp('[0-9]')),],
                                    textAlign: TextAlign.center,
                                    controller: controller.resultDia,
                                    style: TextStyle(fontSize: getUiSize(12),height: 1),
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(32.0)),
                                      // labelText: '이완기혈압',
                                    ),
                                    textInputAction: TextInputAction.next,
                                    focusNode: controller.focusDia,
                                    onFieldSubmitted: (v){
                                      FocusScope.of(context).requestFocus(controller.focusPul);
                                    },
                                  ),
                                ),
                                flex: 3,
                              ),
                            ],
                          ),
                        ),
                        /**
                         * 심박수
                         */
                        Container(
                          height: getUiSize(53),
                          padding: EdgeInsets.fromLTRB(getUiSize(5), 0, getUiSize(10), getUiSize(10)),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Image.asset(
                                'images/main_pul_icon.png',
                                height: getUiSize(39),
                                width: getUiSize(39),
                              ),
                              SizedBox(width: getUiSize(6)),
                              SizedBox(
                                width: getUiSize(60),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      '심박수',
                                      style: TextStyle(
                                          fontFamily: 'NanumRoundEB',
                                          fontSize: getUiSize(10.5),
                                          color: Colors.black),
                                    ),
                                    Text(
                                      'PUL/min',
                                      style: TextStyle(
                                        fontFamily: 'NanumRoundEB',
                                        fontSize: getUiSize(8),
                                        color: Color(0xff78849e),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Expanded(child: Text(''), flex: 1),
                              Expanded(
                                child: SizedBox(
                                  height: getUiSize(33),
                                  child: TextFormField(
                                    // autovalidateMode: AutovalidateMode.always,
                                    // validator : (String? value) {
                                    //   return (value != null && int.parse(value) > 200)
                                    //       ? '혈압지수가 너무 높습니다.' : null ;
                                    // },
                                    controller: controller.resultPul,
                                    style: TextStyle(fontSize: getUiSize(12),height: 1),
                                    keyboardType: TextInputType.number,
                                    // ignore: deprecated_member_use
                                    inputFormatters: [WhitelistingTextInputFormatter(RegExp('[0-9]')),],
                                    textAlign: TextAlign.center,
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(32.0)),
                                      // labelText: '심박수혈압',
                                    ),
                                    textInputAction: TextInputAction.next,
                                    focusNode: controller.focusPul,
                                    onFieldSubmitted: (v){
                                      FocusScope.of(context).requestFocus(controller.focusMemo);
                                    },
                                  ),
                                ),
                                flex: 3,
                              ),
                            ],
                          ),
                        ),
                        /**
                         * 메모
                         */
                        Container(
                          // height: 80.0,
                            padding: EdgeInsets.fromLTRB(getUiSize(5), 0, getUiSize(10), getUiSize(10)),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Row(
                                  children: [
                                    Image.asset(
                                      'images/memo_icon.png',
                                      height: getUiSize(39),
                                      width: getUiSize(39),
                                    ),
                                    SizedBox(width: getUiSize(6)),
                                    SizedBox(
                                        width: getUiSize(90),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              '메모',
                                              style: TextStyle(
                                                  fontFamily: 'NanumRoundEB',
                                                  fontSize: getUiSize(10.5),
                                                  color: Colors.black),
                                            ),
                                            Text(
                                              '선택사항',
                                              style: TextStyle(
                                                fontFamily: 'NanumRoundEB',
                                                fontSize: getUiSize(8),
                                                color: Color(0xff78849e),
                                              ),
                                            )
                                          ],
                                        )),
                                    Expanded(child: Text(''), flex: 1),
                                  ],
                                ),
                                Container(
                                    padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                                    child:
                                    TextFormField(
                                      // autovalidateMode: AutovalidateMode.always,
                                      // validator : (String? value) {
                                      //   return (value != null && value ==  '')
                                      //       ? '메모을 입력해주세요.' : null ;
                                      // },
                                      controller: controller.resultMemo,
                                      minLines: 4,
                                      maxLines: 40,
                                      textAlign: TextAlign.left,
                                      decoration: InputDecoration(
                                          border: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(32.0)),
                                          labelText: '예) 컨디션 좋음',
                                          labelStyle: TextStyle(fontSize: getUiSize(12))),
                                      textInputAction: TextInputAction.done,
                                      focusNode: controller.focusMemo,
                                    )
                                ),
                              ],
                            )),
                      ],
                    ),
                  )),

              /**
               * 등록버튼
               */
              BottomFullSizeBtn(
                  text: '혈압수정',
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
                        Get.back();
                        Get.back(result:{"date":DateTime.parse(controller.data.rData!)});
                      });
                    });
                  })
            ],
          ));
    });
  }
}
