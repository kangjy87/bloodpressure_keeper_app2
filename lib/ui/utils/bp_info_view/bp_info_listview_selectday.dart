import 'package:bloodpressure_keeper_app/model/blood_pressure_item.dart';
import 'package:bloodpressure_keeper_app/model/bp_standard_model.dart';
import 'package:flutter/material.dart';
import 'bp_info_view_selectday.dart';

class BpInfoListviewSelectDay extends StatelessWidget {
  final List<BloodPressureItem> selectDayInfoList ;
  final int lastPage ;
  final PageController pageController ;
  final String beforeBtnImg ;
  final String afterBtnImg ;
  final int position ;
  final BPStandardModel bpRiskLevel ;
  final Function(BloodPressureItem data) detailPageClick;
  final Function() selfPageClick;
  final Function(String btn, int index,int lastIndex) setonclicked;
  BpInfoListviewSelectDay({
    Key? key,
    required this.selectDayInfoList,
    required this.lastPage,
    required this.pageController,
    required this.beforeBtnImg,
    required this.afterBtnImg,
    required this.setonclicked,
    required this.position,
    required this.detailPageClick,
    required this.selfPageClick,
    required this.bpRiskLevel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final PageController pageController = PageController(
      initialPage: 0,
    );
    return Column(
      children: [
        /**
         * 선택일 혈압지수
         */
        Container(
          height: 50,
          width: double.infinity,
          color: bpRiskLevel.colorCode,
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 130,
                  height: 30,
                  // padding: const EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(7.0),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        bpRiskLevel.bpSituation,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontFamily: 'NanumRoundEB',
                            fontSize: 14,
                            color: bpRiskLevel.colorCode),
                      )
                    ],
                  ),
                ),
                SizedBox(width: 8,),
                Text(
                  bpRiskLevel.situationMsg,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontFamily: 'NanumRoundEB',
                      fontSize: 12,
                      color: Colors.white),
                )
              ],
            ),
            // child: Text(
            //   bpRiskLevel.bpSituation,
            //   textAlign: TextAlign.center,
            //   style: TextStyle(
            //       fontFamily: 'NanumRoundL',
            //       fontSize: 20,
            //       color: Colors.white),
            // ),
          ),
        ),
        Container(
          // padding: EdgeInsets.fromLTRB(25, 0, 25, 25),
          width: double.infinity,
          height: 340.0,
          child: Row(
            children: [
              SizedBox(width: 10,),
              GestureDetector(
                child: Image.asset(beforeBtnImg,
                  height: 70,
                  width: 40,
                ),
                onTap: (){
                  setonclicked.call("B",position, lastPage);
                },
              ),
              Expanded(
                child: PageView.builder(
                  physics: new NeverScrollableScrollPhysics(),
                  controller: pageController,
                  itemCount: selectDayInfoList.length,
                  itemBuilder: (context, index) {
                    pageController.animateToPage(position, duration: Duration(milliseconds: 300), curve: Curves.ease);

                    return new Center(
                        child: BpInfoViewSelectDay(
                          data: selectDayInfoList[index],
                          bpRiskLevel: bpRiskLevel,
                          detailPageClick: (data){
                            detailPageClick.call(data);
                          },
                          selfPageClick: (){
                            selfPageClick.call();
                          },
                        )
                    );
                  },
                ),
                flex: 1,),
              GestureDetector(
                child: Image.asset(afterBtnImg,
                  height: 70,
                  width: 40,
                ),
                onTap: (){
                  setonclicked.call("A", position, lastPage);
                },
              ),
              SizedBox(width: 10,),
            ],
          ),
        )
      ],
    );
  }
}

