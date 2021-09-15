import 'package:bloodpressure_keeper_app/model/blood_pressure_item.dart';
import 'package:bloodpressure_keeper_app/utils/blood_pressure_local_db.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:fluttertoast/fluttertoast.dart';

class BpDetailInfoController extends GetxController {
  TextEditingController resultSys = TextEditingController() ;
  TextEditingController resultDia = TextEditingController() ;
  FocusNode focusDia = FocusNode();
  TextEditingController resultPul = TextEditingController() ;
  FocusNode focusPul = FocusNode();
  TextEditingController resultMemo = TextEditingController();
  FocusNode focusMemo = FocusNode();
  BloodPressureItem data = BloodPressureItem();

  @override
  void onInit() {
    super.onInit();
     resultSys = TextEditingController() ;
     resultDia = TextEditingController() ;
     focusDia = FocusNode();
     resultPul = TextEditingController() ;
     focusPul = FocusNode();
     resultMemo = TextEditingController();
     focusMemo = FocusNode();
     data = BloodPressureItem();
    dataSetting();
  }
  dataSetting(){
    data = Get.arguments;
    print('!!!!!!!!!!!!!!!>>>>>>>>>>>>>>${data.memo}');
    resultSys.text = "${data.systolic}" ;
    resultDia.text = "${data.diastole}";
    resultPul.text = "${data.pulse}";
    resultMemo.text = "${data.memo}" ;
    update();
  }

  bool saveCheck(){
    if(resultSys.text == ''){
      Fluttertoast.showToast(
          msg: "수축기 혈압을 입력해주세요.",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Color(0xff454f63),
          textColor: Colors.red,
          fontSize: 16.0
      );
      return false ;
    }
    if(resultDia.text == ""){
      Fluttertoast.showToast(
          msg: "이완기 혈압을 입력해주세요.",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Color(0xff454f63),
          textColor: Colors.red,
          fontSize: 16.0
      );
      return false ;
    }
    if(resultPul.text == ""){
      Fluttertoast.showToast(
          msg: "심박수을 입력해주세요.",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Color(0xff454f63),
          textColor: Colors.red,
          fontSize: 16.0
      );
      return false ;
    }
    if(int.parse(resultSys.text) > 200){
      Fluttertoast.showToast(
          msg: "수축기 혈압이 비정상적 입니다.",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Color(0xff454f63),
          textColor: Colors.red,
          fontSize: 16.0
      );
      return false ;
    }
    if(int.parse(resultDia.text) > 200){
      Fluttertoast.showToast(
          msg: "이완기 혈압이 비정상적 입니다.",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Color(0xff454f63),
          textColor: Colors.red,
          fontSize: 16.0
      );
      return false ;
    }
    if(int.parse(resultPul.text) > 200){
      Fluttertoast.showToast(
          msg: "심박수가 비정상적 입니다.",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Color(0xff454f63),
          textColor: Colors.red,
          fontSize: 16.0
      );
      return false ;
    }
    return true ;
  }

  Future<void> localDbInsert(Function saved)async {
    if(saveCheck()){
      data.systolic = int.parse(resultSys.text) ;
      data.diastole = int.parse(resultDia.text);
      data.pulse = int.parse(resultPul.text);
      data.memo = resultMemo.text ;
      update();

      BloodPressureLocalDB db = BloodPressureLocalDB();
      db.database ;
      await db.selectMemoUpset(data).then((value){
        saved.call();
      });
    }
  }
}