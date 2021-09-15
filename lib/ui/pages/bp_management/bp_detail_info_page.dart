import 'package:bloodpressure_keeper_app/model/blood_pressure_item.dart';
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
                        Stack(
                          children: [
                            Image.asset(
                              'images/self_bp_input_title.png',
                              // fit: BoxFit.fill,
                              height: 164.0,
                              width: double.infinity,
                            ),
                            Container(
                              padding: EdgeInsets.fromLTRB(220, 60, 0, 0),
                              height: 164.0,
                              width: double.infinity,
                              color: Colors.transparent,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('혈압을 수정해주세요 :)',
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                          fontFamily: 'NanumRoundB',
                                          fontSize: 14,
                                          color: Colors.white)),
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10,),
                        Container(
                          width: 290.0,
                          height: 45,
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
                                      fontSize: 14.0,
                                      color: Color(0xff78849e)),
                                  textAlign: TextAlign.center,),
                                Expanded(child: Text(''), flex: 1),
                                Text("${controller.data.weatherTemp} ",style: TextStyle(
                                    fontFamily: 'NanumRoundB',
                                    fontSize: 14.0,
                                    color: Color(0xff78849e)),
                                  textAlign: TextAlign.center,),
                                Visibility(visible: controller.data.weatherImg != '',child: Image.asset(controller.data.weatherImg!, width: 30, height: 30,),),
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
                          height: 80.0,
                          padding: EdgeInsets.fromLTRB(10, 0, 20, 00),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Image.asset(
                                'images/main_sys_icon.png',
                                height: 55,
                                width: 55,
                              ),
                              SizedBox(width: 10),
                              SizedBox(
                                width: 80,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      '수축기 혈압',
                                      style: TextStyle(
                                          fontFamily: 'NanumRoundEB',
                                          fontSize: 15.0,
                                          color: Colors.black),
                                    ),
                                    Text(
                                      'SYS/mmHg',
                                      style: TextStyle(
                                        fontFamily: 'NanumRoundEB',
                                        fontSize: 12.0,
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
                                  height: 50,
                                  child: TextFormField(
                                      keyboardType: TextInputType.number,
                                      // ignore: deprecated_member_use
                                      inputFormatters: [WhitelistingTextInputFormatter(RegExp('[0-9]')),],
                                      controller: controller.resultSys,
                                      style: TextStyle(fontSize: 17,height: 1),
                                      textAlign: TextAlign.center,
                                      decoration: InputDecoration(
                                        border: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(32.0)),
                                        // labelText: '수축기혈압',
                                      ),
                                      textInputAction: TextInputAction.next,
                                      onFieldSubmitted: (v){
                                        FocusScope.of(context).requestFocus(controller.focusDia);
                                        },),
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
                          height: 80.0,
                          padding: EdgeInsets.fromLTRB(10, 0, 20, 00),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Image.asset(
                                'images/main_dia_icon.png',
                                height: 55,
                                width: 55,
                              ),
                              SizedBox(width: 10),
                              SizedBox(
                                width: 80,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      '이완기 혈압',
                                      style: TextStyle(
                                          fontFamily: 'NanumRoundEB',
                                          fontSize: 15.0,
                                          color: Colors.black),
                                    ),
                                    Text(
                                      'DIA/mmHg',
                                      style: TextStyle(
                                        fontFamily: 'NanumRoundEB',
                                        fontSize: 12.0,
                                        color: Color(0xff78849e),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Expanded(child: Text(''), flex: 1),
                              Expanded(
                                child: SizedBox(
                                  height: 50,
                                  child: TextFormField(
                                      keyboardType: TextInputType.number,
                                      // ignore: deprecated_member_use
                                      inputFormatters: [WhitelistingTextInputFormatter(RegExp('[0-9]')),],
                                      textAlign: TextAlign.center,
                                      controller: controller.resultDia,
                                      style: TextStyle(fontSize: 17,height: 1),
                                      decoration: InputDecoration(
                                        border: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(32.0)),
                                        // labelText: '이완기혈압',
                                      ),
                                      textInputAction: TextInputAction.next,
                                      focusNode: controller.focusDia,
                                      onFieldSubmitted: (v){
                                        FocusScope.of(context).requestFocus(controller.focusPul);
                                        },),
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
                          height: 80.0,
                          padding: EdgeInsets.fromLTRB(10, 0, 20, 00),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Image.asset(
                                'images/main_pul_icon.png',
                                height: 55,
                                width: 55,
                              ),
                              SizedBox(width: 10),
                              SizedBox(
                                width: 80,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      '심박수',
                                      style: TextStyle(
                                          fontFamily: 'NanumRoundEB',
                                          fontSize: 15.0,
                                          color: Colors.black),
                                    ),
                                    Text(
                                      'PUL/min',
                                      style: TextStyle(
                                        fontFamily: 'NanumRoundEB',
                                        fontSize: 12.0,
                                        color: Color(0xff78849e),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Expanded(child: Text(''), flex: 1),
                              Expanded(
                                child: SizedBox(
                                  height: 50,
                                  child: TextFormField(
                                      controller: controller.resultPul,
                                      style: TextStyle(fontSize: 17,height: 1),
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
                                        },),
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
                            padding: EdgeInsets.fromLTRB(10, 0, 20, 20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Row(
                                  children: [
                                    Image.asset(
                                      'images/memo_icon.png',
                                      height: 55,
                                      width: 55,
                                    ),
                                    SizedBox(width: 10),
                                    SizedBox(
                                        width: 80,
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              '메모',
                                              style: TextStyle(
                                                  fontFamily: 'NanumRoundEB',
                                                  fontSize: 15.0,
                                                  color: Colors.black),
                                            ),
                                            Text(
                                              '선택사항',
                                              style: TextStyle(
                                                fontFamily: 'NanumRoundEB',
                                                fontSize: 12.0,
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
                                            labelStyle: TextStyle(fontSize: 13)),
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
                  text: '햘압수정',
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
