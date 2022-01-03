import 'package:bloodpressure_keeper_app/model/blood_pressure_item.dart';
import 'package:bloodpressure_keeper_app/model/bloodpressure_dto.dart';
import 'package:bloodpressure_keeper_app/model/bp_standard_model.dart';
import 'package:bloodpressure_keeper_app/ui/pages/feed/utils/GeneralUtils.dart';
import 'package:bloodpressure_keeper_app/utils/day_util.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:bloodpressure_keeper_app/utils/weather_util.dart';

class BpInfoViewSelectDay extends StatelessWidget {
  final BloodPressureDto data ;
  final BPStandardModel bpRiskLevel ;
  final Function(BloodPressureDto data) detailPageClick;
  final Function() selfPageClick;
  const BpInfoViewSelectDay({
    Key? key,
    required this.data,
    required this.bpRiskLevel,
    required this.detailPageClick,
    required this.selfPageClick,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextEditingController memoController = TextEditingController();
    memoController.text = data.memo == null ? '' : ((data.memo!.length > 14) ?  "${data.memo!.substring(0,10)}..." : data.memo!)  ;
    String weatherImg = "" ;
    if(data.weather != null && data.weather != null){
      weatherImg = WeatherUtil.getWeatherImageFromWeatherStr(data.weather!);
    }
    return Container(
      // padding: EdgeInsets.fromLTRB(15, 0, 15, 15),
      width: double.infinity,
      height: getUiSize(240),
      child: Container(
        width: double.infinity,
        height: double.infinity,
        // color: Color(0xfff4f7fc),
        child: Column(
          children: [
            // Expanded(child: Text(''), flex: 1),
            SizedBox(height: getUiSize(9),),
            Container(
              width: getUiSize(300),
              height: getUiSize(28),
              // padding: const EdgeInsets.all(10.0),
              // decoration: BoxDecoration(
              //   shape: BoxShape.rectangle,
              //   color: Color(0xfff4f7fc),
              //   borderRadius: BorderRadius.circular(89.0),
              // ),
              child: Visibility(
                visible: data.systolic! > 0,
                child: Center(
                  child: Row(
                    children: [
                      Expanded(child: Text(''), flex: weatherImg != '' ? 1 : 2),
                      Text(getStringDay(data.created_at!) == getStringDay(data.date!)
                          ?"${DateFormat('yyyy.MM.dd HH시 mm분').format(DateTime.parse(data.created_at!))} "
                          :"${DateFormat('yyyy.MM.dd').format(DateTime.parse(data.date!))} ",
                        style: TextStyle(
                            fontFamily: 'NanumRoundB',
                            fontSize: getUiSize(10),
                            color: Color(0xff78849e)),
                        textAlign: TextAlign.center,),
                      Expanded(child: Text(''), flex: 1),
                      Text(getStringDay(data.created_at!) == getStringDay(data.date!)
                          ?"${data.temperature}℃ "
                          :"",
                        style: TextStyle(
                          fontFamily: 'NanumRoundB',
                          fontSize: getUiSize(10),
                          color: Color(0xff78849e)),
                        textAlign: TextAlign.center,),
                      // Text("${data.temperature}℃ ",style: TextStyle(
                      //     fontFamily: 'NanumRoundB',
                      //     fontSize: getUiSize(10),
                      //     color: Color(0xff78849e)),
                      //   textAlign: TextAlign.center,),
                      Visibility(visible: weatherImg != '',child: Image.asset(weatherImg, width: getUiSize(23), height: getUiSize(23),),),
                      Expanded(child: Text(''), flex: 1),
                    ],
                  ),
                ),
              ),
            ),
            // Expanded(child: Text(''), flex: 1),
            SizedBox(height: getUiSize(9),),
            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset(
                            'images/mini_main_sys_icon.png',
                            height: getUiSize(28),
                            width: getUiSize(28),
                          ),
                          SizedBox(
                            width: 7,
                          ),
                          Text(
                            '${data.systolic}',
                            style: TextStyle(
                                fontFamily: 'NanumRoundEB',
                                fontSize: getUiSize(25),
                                color: Colors.black),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 4,
                      ),
                      Text(
                        '수축기 혈압\nSYS/mmHg',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'NanumRoundEB',
                          fontSize: getUiSize(8.5),
                          color: Color(0xff78849e),
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(0, getUiSize(20), 0, getUiSize(20)),
                  width: 2,
                  color: Color(0xfff4f5f7),
                ),
                Expanded(
                  flex: 1,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset(
                            'images/mini_main_dia_icon.png',
                            height: getUiSize(28),
                            width: getUiSize(28),
                          ),
                          SizedBox(
                            width: 7,
                          ),
                          Text(
                            '${data.diastolic}',
                            style: TextStyle(
                                fontFamily: 'NanumRoundEB',
                                fontSize: getUiSize(25),
                                color: Colors.black),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 4,
                      ),
                      Text(
                        '이완기 혈압\nDIA/mmHg',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'NanumRoundEB',
                          fontSize: getUiSize(8.5),
                          color: Color(0xff78849e),
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(0, getUiSize(8.5), 0, getUiSize(8.5)),
                  width: 0.5,
                  child: Container(
                    color: Color(0xff78849e),
                  ),
                ),
              ],
            ),
            // Expanded(child: Text(''), flex: 1),
            SizedBox(height: getUiSize(13),),
            Container(
              padding: EdgeInsets.fromLTRB(getUiSize(13), 0, getUiSize(13), 0),
              height: 2,
              child: Container(
                color: Color(0xfff4f5f7),
              ),
            ),
            SizedBox(height: getUiSize(13),),
            Expanded(
              flex: 1,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Text(''),
                  ),
                  Image.asset(
                    'images/mini_main_pul_icon.png',
                    height: getUiSize(28),
                    width: getUiSize(28),
                  ),
                  Expanded(
                    child: Text(''),
                  ),
                  Text(
                    '${data.heart}',
                    style: TextStyle(
                        fontFamily: 'NanumRoundEB',
                        fontSize: getUiSize(25),
                        color: Colors.black),
                  ),
                  Expanded(
                    child: Text(''),
                  ),
                  Text(
                    '심박수\nPUL/min',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'NanumRoundEB',
                      fontSize: getUiSize(8.5),
                      color: Color(0xff78849e),
                    ),
                  ),
                  Expanded(
                    child: Text(''),
                  )
                ],
              ),
            ),
            SizedBox(height: getUiSize(13),),
            /**
             * 메모
             */
            Container(
                // height: (memoController.text.length > 10) ? 69.0 : 54.0 ,
                // padding: EdgeInsets.fromLTRB(10, 0, 20, 00),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                        width: getUiSize(40),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              'images/memo_icon.png',
                              height: getUiSize(28),
                              width: getUiSize(28),
                            ),
                            Text(
                              '메모',
                              style: TextStyle(
                                  fontFamily: 'NanumRoundEB',
                                  fontSize: getUiSize(10),
                                  color: Colors.black),
                            )
                          ],
                        )),
                    Expanded(child: Text(''), flex: 1),
                    Expanded(
                      child: SizedBox(child: TextFormField(
                        textAlign: TextAlign.center,
                        controller: memoController,
                        readOnly: true,
                        maxLines: 1,
                        decoration: InputDecoration(
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Color(0xff78849e)),
                          ),
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Color(0xff78849e))),
                        ),
                        // decoration: InputDecoration(
                        //   border: OutlineInputBorder(
                        //       borderRadius: BorderRadius.circular(32.0)),
                        //   // labelText: '',
                        // ),
                        style: TextStyle(fontSize: 13.0, height: 1.5),),height: getUiSize(25),),
                      flex: 20,
                    ),
                    Expanded(child: Text(''), flex: 2),
                    GestureDetector(
                      child: Container(
                        padding: EdgeInsets.only(left: 0, top: getUiSize(10), right: 0, bottom: 0),
                        child: Image.asset(
                          'images/note_pencil_icon.png',
                          height: getUiSize(25),
                          width: getUiSize(25),
                        ),
                      ),
                      onTap: () {
                        print('클릭>>>>>>>>${data.id}');
                        if(data.id! > 0){
                          detailPageClick.call(data);
                        }else{
                          selfPageClick.call();
                        }
                      },
                    )
                  ],
                )),
            // Expanded(child: Text(''), flex: 1),
            SizedBox(height: 20,),
          ],
        ),
      ),
    );
  }
}
