import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SelfBpInputForm extends StatelessWidget {
  final TextEditingController sys ;
  final TextEditingController dia ;
  final FocusNode focusDia ;
  final TextEditingController pul ;
  final FocusNode focusPul ;
  final TextEditingController memo ;
  final FocusNode focusMemo ;
  const SelfBpInputForm({
    Key? key,
    required this.sys,
    required this.dia,
    required this.focusDia,
    required this.pul,
    required this.focusPul,
    required this.memo,
    required this.focusMemo,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        /**
         * 수축혈압
         */
        Container(
          height: 80.0,
          padding: EdgeInsets.fromLTRB(10, 0, 20, 20),
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
                    // autovalidateMode: AutovalidateMode.always,
                    // validator : (String? value) {
                    //   return (value != null && int.parse(value) > 200)
                    //       ? '혈압지수가 너무 높습니다.' : null ;
                    // },
                      keyboardType: TextInputType.number,
                      // ignore: deprecated_member_use
                      inputFormatters: [WhitelistingTextInputFormatter(RegExp('[0-9]')),],
                      controller: sys,
                      style: TextStyle(fontSize: 17,height: 1),
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(32.0)),
                        // labelText: '수축기혈압',
                      ),
                      textInputAction: TextInputAction.next,
                      onFieldSubmitted: (v){
                        FocusScope.of(context).requestFocus(focusDia);
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
          height: 80.0,
          padding: EdgeInsets.fromLTRB(10, 0, 20, 20),
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
                    // autovalidateMode: AutovalidateMode.always,
                    // validator : (String? value) {
                    //   return (value != null && int.parse(value) > 200)
                    //       ? '혈압지수가 너무 높습니다.' : null ;
                    // },
                      keyboardType: TextInputType.number,
                      // ignore: deprecated_member_use
                      inputFormatters: [WhitelistingTextInputFormatter(RegExp('[0-9]')),],
                      textAlign: TextAlign.center,
                      controller: dia,
                      style: TextStyle(fontSize: 17,height: 1),
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(32.0)),
                        // labelText: '이완기혈압',
                      ),
                      textInputAction: TextInputAction.next,
                      focusNode: focusDia,
                      onFieldSubmitted: (v){
                        FocusScope.of(context).requestFocus(focusPul);
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
          height: 80.0,
          padding: EdgeInsets.fromLTRB(10, 0, 20, 20),
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
                    // autovalidateMode: AutovalidateMode.always,
                    // validator : (String? value) {
                    //   return (value != null && int.parse(value) > 200)
                    //       ? '혈압지수가 너무 높습니다.' : null ;
                    // },
                      controller: pul,
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
                    focusNode: focusPul,
                    onFieldSubmitted: (v){
                      FocusScope.of(context).requestFocus(focusMemo);
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
                        controller: memo,
                        minLines: 4,
                        maxLines: 40,
                        textAlign: TextAlign.left,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(32.0)),
                            labelText: '예) 컨디션 좋음',
                            labelStyle: TextStyle(fontSize: 13)),
                        textInputAction: TextInputAction.done,
                        focusNode: focusMemo,
                    )
                ),
              ],
            )),
      ],
    );
  }
}
