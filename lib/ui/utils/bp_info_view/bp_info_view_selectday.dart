import 'package:bloodpressure_keeper_app/model/blood_pressure_item.dart';
import 'package:bloodpressure_keeper_app/model/bp_standard_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class BpInfoViewSelectDay extends StatelessWidget {
  final BloodPressureItem data ;
  final BPStandardModel bpRiskLevel ;
  final Function(BloodPressureItem data) detailPageClick;
  const BpInfoViewSelectDay({
    Key? key,
    required this.data,
    required this.bpRiskLevel,
    required this.detailPageClick,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextEditingController memoController = TextEditingController();
    memoController.text = data.memo!;
    return Container(
      // padding: EdgeInsets.fromLTRB(15, 0, 15, 15),
      width: double.infinity,
      height: 280.0,
      child: Container(
        width: double.infinity,
        height: double.infinity,
        // color: Color(0xfff4f7fc),
        child: Column(
          children: [
            // Expanded(child: Text(''), flex: 1),
            SizedBox(height: 19,),
            Container(
              width: 250.0,
              height: 36,
              // padding: const EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                color: Color(0xfff4f7fc),
                borderRadius: BorderRadius.circular(89.0),
              ),
              child: Visibility(
                visible: data.systolic! > 0,
                child: Center(
                  child: Row(
                    children: [
                      Expanded(child: Text(''), flex: data.weatherImg != '' ? 1 : 2),
                      Text(DateFormat('yyyy-MM-dd').format(DateTime.parse(data.saveData!)) == data.rData
                          ?"${DateFormat('yyyy.MM.dd HH시 mm분').format(DateTime.parse(data.saveData!))} "
                          :"${DateFormat('yyyy.MM.dd').format(DateTime.parse(data.rData!))} ",
                        style: TextStyle(
                            fontFamily: 'NanumRoundB',
                            fontSize: 12.0,
                            color: Color(0xff78849e)),
                        textAlign: TextAlign.center,),
                      Expanded(child: Text(''), flex: 1),
                      Text("${data.weatherTemp} ",style: TextStyle(
                          fontFamily: 'NanumRoundB',
                          fontSize: 12.0,
                          color: Color(0xff78849e)),
                        textAlign: TextAlign.center,),
                      Visibility(visible: data.weatherImg != '',child: Image.asset(data.weatherImg!, width: 30, height: 30,),),
                      Expanded(child: Text(''), flex: 1),
                    ],
                  ),
                ),
              ),
            ),
            // Expanded(child: Text(''), flex: 1),
            SizedBox(height: 20,),
            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'images/mini_main_sys_icon.png',
                        height: 40,
                        width: 40,
                      ),
                      SizedBox(
                        height: 4,
                      ),
                      Text(
                        '${data.systolic}',
                        style: TextStyle(
                            fontFamily: 'NanumRoundEB',
                            fontSize: 16.0,
                            color: Colors.black),
                      ),
                      SizedBox(
                        height: 4,
                      ),
                      Text(
                        '수축기 혈압\nSYS/mmHg',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'NanumRoundEB',
                          fontSize: 12.0,
                          color: Color(0xff78849e),
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(0, 20, 0, 20),
                  width: 0.5,
                  child: Container(
                    color: Color(0xff78849e),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'images/mini_main_dia_icon.png',
                        height: 40,
                        width: 40,
                      ),
                      SizedBox(
                        height: 4,
                      ),
                      Text(
                        '${data.diastole}',
                        style: TextStyle(
                            fontFamily: 'NanumRoundEB',
                            fontSize: 15.0,
                            color: Colors.black),
                      ),
                      SizedBox(
                        height: 4,
                      ),
                      Text(
                        '이완기 혈압\nDIA/mmHg',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'NanumRoundEB',
                          fontSize: 12.0,
                          color: Color(0xff78849e),
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(0, 20, 0, 20),
                  width: 0.5,
                  child: Container(
                    color: Color(0xff78849e),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'images/mini_main_pul_icon.png',
                        height: 40,
                        width: 40,
                      ),
                      SizedBox(
                        height: 4,
                      ),
                      Text(
                        '${data.pulse}',
                        style: TextStyle(
                            fontFamily: 'NanumRoundEB',
                            fontSize: 15.0,
                            color: Colors.black),
                      ),
                      SizedBox(
                        height: 4,
                      ),
                      Text(
                        '심박수\nPUL/min',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'NanumRoundEB',
                          fontSize: 12.0,
                          color: Color(0xff78849e),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
            // Expanded(child: Text(''), flex: 1),
            SizedBox(height: 20,),
            /**
             * 메모
             */
            Container(
                height: (memoController.text.length > 10) ? 69.0 : 54.0 ,
                // padding: EdgeInsets.fromLTRB(10, 0, 20, 00),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Image.asset(
                      'images/memo_icon.png',
                      height: 30,
                      width: 30,
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
                                  fontSize: 13.0,
                                  color: Colors.black),
                            ),
                            Text(
                              '선택사항',
                              style: TextStyle(
                                fontFamily: 'NanumRoundEB',
                                fontSize: 11.0,
                                color: Color(0xff78849e),
                              ),
                            )
                          ],
                        )),
                    Expanded(child: Text(''), flex: 1),
                    Expanded(
                      child: TextFormField(
                          controller: memoController,
                          readOnly: true,
                          maxLines: 2,
                          //   controller: memo,
                          textAlign: TextAlign.center,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(32.0)),
                            // labelText: '',
                          ),
                      style: TextStyle(fontSize: 13.0),),
                      flex: 17,
                    ),
                    Expanded(child: Text(''), flex: 1),
                    GestureDetector(
                      child: Image.asset(
                        'images/note_pencil_icon.png',
                        height: 35,
                        width: 35,
                      ),
                      onTap: () {
                        print('클릭>>>>>>>>${data.id}');
                        detailPageClick.call(data);
                      },
                    )
                  ],
                )),
            // Expanded(child: Text(''), flex: 1),
            SizedBox(height: 10,),
          ],
        ),
      ),
    );
  }
}
