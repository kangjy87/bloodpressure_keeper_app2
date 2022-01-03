import 'package:bloodpressure_keeper_app/ui/pages/feed/utils/GeneralUtils.dart';
import 'package:flutter/material.dart';
import 'package:bloodpressure_keeper_app/ui/utils/btns/bottom_fullsize_btn.dart';
import 'package:bloodpressure_keeper_app/utils/app_colors.dart';

class NickNameInfoForm extends StatelessWidget {
  final TextEditingController nickname ;
  final Function() setonclicklistener ;
  const NickNameInfoForm({
    Key? key,
    required this.nickname,
    required this.setonclicklistener,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          Expanded(child: Text(''), flex: 1),
          Container(
            height: getUiSize(100),
            padding: EdgeInsets.fromLTRB(20, 0, 20, 00),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Image.asset(
                  'images/join_nickname.png',
                  height: getUiSize(35),
                  width: getUiSize(35),
                ),
                SizedBox(width: getUiSize(8)),
                SizedBox(
                  width: getUiSize(45),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '닉네임',
                        style: TextStyle(
                            fontFamily: 'NanumRoundEB',
                            fontSize: getUiSize(11),
                            color: Colors.black),
                      ),
                      Text(
                        'Nickname',
                        style: TextStyle(
                          fontFamily: 'NanumRoundEB',
                          fontSize: getUiSize(9),
                          color: Color(0xff78849e),
                        ),
                      )
                    ],
                  ),
                ),
                Expanded(child: Text(''), flex: 1),
                Expanded(
                  child: TextFormField(
                      // style: TextStyle(fontSize: 10,height: 1),
                      // autovalidateMode: AutovalidateMode.always,
                      // validator : (String? value) {
                      //   return (value != null && value ==  '')
                      //       ? ((isSmallSize() ? '닉네임을 입력해주세요.' : '닉네임을 입력해주세요.')) : null ;
                      // },
                      controller: nickname,
                      textAlign: TextAlign.left,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(32.0)),
                        labelText: '직접입력',
                      )),
                  flex: 5,
                ),
              ],
            ),
          ),
          Expanded(child: Text(''), flex: 3),
          BottomFullSizeBtn(
              text: '다음',
              textColor: Colors.white,
              backgroundColor: Color(AppColors.colorBtnActivate),
              setonclicklistener: () {
                FocusScopeNode currentFocus = FocusScope.of(context);
                currentFocus.unfocus(); //키보드 내리기
                setonclicklistener.call() ;
              })
        ],
      ),
    );
  }
}
