import 'package:bloodpressure_keeper_app/ui/pages/feed/utils/GeneralUtils.dart';
import 'package:flutter/material.dart';

oneButtonAlert(BuildContext buidContext, String strTitle, String strMsg,
    String strBtn, Function onclickEvent) {
  return showDialog(
      context: buidContext,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(32.0))),
          contentPadding: EdgeInsets.only(top: 10.0),
          content: Container(
            width: getUiSize(300),
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.start,
              // crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  height: 20,
                ),
                Image.asset(
                  'images/popup_complete.png',
                  height: getUiSize(50),
                  width: getUiSize(50),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  strTitle,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontFamily: 'NanumRoundEB',
                      fontSize: getUiSize(19),
                      color: const Color(0xff454f63)),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  strMsg,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontFamily: 'NanumRoundB',
                      fontSize: getUiSize(10),
                      color: const Color(0xff454f63)),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                    width: getUiSize(180),
                    height: getUiSize(40),
                    child: ElevatedButton(
                        child: Text(strBtn.toUpperCase(),
                            style: TextStyle(fontSize: getUiSize(12),)),
                        style: ButtonStyle(
                            foregroundColor:
                                MaterialStateProperty.all<Color>(Colors.white),
                            backgroundColor: MaterialStateProperty.all<Color>(
                                Color(0xff454f63)),
                            shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(70.0),
                                    side:
                                        BorderSide(color: Color(0xff454f63))))),
                        onPressed: () {
                          onclickEvent();
                        })),
                SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        );
      });
}
