import 'package:bloodpressure_keeper_app/ui/pages/feed/utils/GeneralUtils.dart';
import 'package:flutter/material.dart';
import 'package:bloodpressure_keeper_app/ui/utils/btns/bottom_fullsize_btn.dart';
import 'package:bloodpressure_keeper_app/utils/app_colors.dart';
import 'package:bloodpressure_keeper_app/ui/utils/btns/radio_img_btn.dart';
import 'package:flutter/services.dart';

class BasicInfoForm extends StatelessWidget {
  final int sexIndex ;
  final TextEditingController age ;
  final Function(String sex) setonclicklistener ;
  final Function(int sexIndex) radioBtnSexCheck ;
  final VoidCallback agreementCall;
  const BasicInfoForm({
    Key? key,
    required this.sexIndex,
    required this.age,
    required this.radioBtnSexCheck,
    required this.setonclicklistener,
    required this.agreementCall,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Expanded(
            flex: 1,
            child: SingleChildScrollView(
                child: Container(
              height: getUiSize(340),
              child: Column(
                children: [

                  Expanded(child: Text(''), flex: 3),

                  //성별
                  Row(
                    children: [
                      Expanded(child: Text(''), flex: 2),
                      RadioImgBtn(
                        index: 0,
                        nowIndex: sexIndex,
                        selectImgRoute: 'images/w_on_img.png',
                        unselectedImgRoute: 'images/w_off_img.png',
                        title: '여성',
                        setonclicked: (index) {
                          radioBtnSexCheck.call(index);
                        },
                      ),
                      Expanded(child: Text(''), flex: 1),
                      RadioImgBtn(
                        index: 1,
                        nowIndex: sexIndex,
                        selectImgRoute: 'images/m_on_img.png',
                        unselectedImgRoute: 'images/m_off_img.png',
                        title: '남성',
                        setonclicked: (index) {
                          radioBtnSexCheck.call(index);
                        },
                      ),
                      Expanded(child: Text(''), flex: 2),
                    ],
                  ),

                  Expanded(child: Text(''), flex: 3),

                  //나이
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(child: Text(''), flex: 6),
                      Text(
                        '나는',
                        style: TextStyle(
                            fontFamily: 'NanumRoundB',
                            fontSize: getUiSize(17),
                            color: Color(AppColors.colorBlackInfoText)),
                      ),
                      Expanded(child: Text(''), flex: 3),
                      Container(
                        width: getUiSize(70),
                        height: getUiSize(30),
                        child: TextField(
                          style: TextStyle(
                              fontFamily: 'NanumRoundB',
                              fontSize: 25.0,
                              color: Color(AppColors.colorBlueInfoPointText)),
                          controller: age,
                          keyboardType: TextInputType.number,
                          // ignore: deprecated_member_use
                          // inputFormatters: [WhitelistingTextInputFormatter(RegExp('[0-9]')),],
                          textAlign: TextAlign.center,
                          // decoration: InputDecoration(labelText: '19xx'),
                        ),
                      ),
                      Expanded(child: Text(''), flex: 1),
                      Text(
                        '년생 입니다.',
                        style: TextStyle(
                            fontFamily: 'NanumRoundB',
                            fontSize: getUiSize(17),
                            color: Color(AppColors.colorBlackInfoText)),
                      ),
                      Expanded(child: Text(''), flex: 6),
                    ],
                  ),

                  Expanded(child: Text(''), flex: 7),

                  //동의서 문구
                  Row(
                    children: [
                      Expanded(child: Text(''), flex: 3),
                      Image.asset('images/info_light.png',
                          height: 30, width: 30),
                      Expanded(child: Text(''), flex: 1),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '성별과 나이를 입력해주신 경우',
                            style: TextStyle(
                                fontFamily: 'NanumRoundB',
                                fontSize: getUiSize(12),
                                color: Color(AppColors.colorBlackInfoText)),
                          ),
                          Row(
                            children: [
                              GestureDetector(
                                child: Text(
                                  '개인정보 취급 방침',
                                  style: TextStyle(
                                      fontFamily: 'NanumRoundB',
                                      fontSize: getUiSize(12),
                                      color: Color(
                                          AppColors.colorBlueInfoPointText),
                                      decoration: TextDecoration.underline),
                                ),
                                onTap: agreementCall,
                              ),
                              Text(
                                '에 동의한 것으로 간주합니다.',
                                style: TextStyle(
                                    fontFamily: 'NanumRoundB',
                                    fontSize: getUiSize(12),
                                    color: Color(AppColors.colorBlackInfoText)),
                              ),
                            ],
                          )
                        ],
                      ),
                      Expanded(child: Text(''), flex: 3),
                    ],
                  ),
                  Expanded(child: Text(''), flex: 3),
                ],
              ),
            )),
          ),
          BottomFullSizeBtn(
              text: '완료',
              textColor: Colors.white,
              backgroundColor: Color(AppColors.colorBtnActivate),
              setonclicklistener: () {
                FocusScopeNode currentFocus = FocusScope.of(context);
                currentFocus.unfocus(); //키보드 내리기
                String sex = 'N';
                switch (sexIndex) {
                  case 0:
                    sex = 'F';
                    break;
                  case 1:
                    sex = 'M';
                    break;
                  case 2:
                    sex = 'N';
                    break;
                }
                setonclicklistener.call(sex);
              })
        ],
      ),
    );
  }
}
