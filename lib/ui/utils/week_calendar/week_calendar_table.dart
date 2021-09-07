import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';
import 'package:bloodpressure_keeper_app/ui/utils/week_calendar/week_utils.dart';
import 'package:bloodpressure_keeper_app/utils/day_util.dart';
import 'package:fluttertoast/fluttertoast.dart';

class WeekCalendarTable extends StatelessWidget {
  final Function(PageController pageController) pageControllerFunction ;
  final  PageController pageControllers;
  final Function(DateTime focusedDay) onPageChanged ;
  final Function(DateTime selectedDay,DateTime focusedDay) onDaySelected ;
  final DateTime selectedDay;
  final DateTime focusedDay ;
  final Function datePicker ;
  const WeekCalendarTable({
    Key? key,
    required this.pageControllers,
    required this.pageControllerFunction,
    required this.onDaySelected,
    required this.onPageChanged,
    required this.selectedDay,
    required this.focusedDay,
    required this.datePicker,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _CalendarHeader(
          datePicker: (){
            datePicker.call();
          },
          focusedDay: focusedDay,
          onLeftArrowTap: () {
            print('클릭됨!!!!!!1');
            pageControllers.previousPage(
              duration: Duration(milliseconds: 300),
              curve: Curves.easeOut,
            );
          },
          onRightArrowTap: () {
            print('클릭됨!!!!!!2');
            print('${focusedDay}클릭됨!!!!!!2');
            print('클릭됨!!!!!!2');
            /**
             * 현 보고 있는 주가 이번주 인경우 오른쪽 버튼을 클릭할 경우 미래의 날짜를 보는것이기 떄문에
             * 미래의 날짜는 볼수 없습니다.
             */
            if(DateFormat('yyyy-MM-dd').format(DateTime.now()) == DateFormat('yyyy-MM-dd').format(focusedDay)){
              Fluttertoast.showToast(
                  msg: "오늘 이후의 날짜는 선택이 불가능 합니다.",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.BOTTOM,
                  timeInSecForIosWeb: 1,
                  backgroundColor: Color(0xff454f63),
                  textColor: Colors.red,
                  fontSize: 16.0
              );
            }
            pageControllers.nextPage(
              duration: Duration(milliseconds: 300),
              curve: Curves.easeOut,
            );
          },
        ),
        TableCalendar(
          headerVisible: false,
          shouldFillViewport: false,
          firstDay: kFirstDay,
          lastDay: kLastDay,
          startingDayOfWeek: startWeekdaySetting(),
          onCalendarCreated: (controller){
            pageControllerFunction.call(controller);
          },
          focusedDay: focusedDay,
          calendarBuilders: calendarBuilder(),
          calendarFormat: CalendarFormat.week,
          selectedDayPredicate: (day) {
            return isSameDay(this.selectedDay, day);
          },
          onDaySelected: (selectedDay, focusedDay) {
            print('클릭됨!!!!!!3');
            if (!isSameDay(this.selectedDay, selectedDay)) {
              onDaySelected.call(selectedDay,focusedDay);
            }
          },
          onPageChanged: (focusedDay) {
            onPageChanged.call(focusedDay);
          },
        ),
      ],
    );
  }


  /**
   * 요일한글표
   */
  CalendarBuilders calendarBuilder() {
    return CalendarBuilders(dowBuilder: (context, day) {
      String text = '일';
      TextStyle textStyle = TextStyle(color: Colors.black);
      switch (day.weekday) {
        case DateTime.sunday:
          text = '일';
          textStyle = TextStyle(color: Color(0xffa0a5b1));
          break;
        case DateTime.monday:
          text = '월';
          textStyle = TextStyle(color: Color(0xffa0a5b1));
          break;
        case DateTime.tuesday:
          text = '화';
          textStyle = TextStyle(color: Color(0xffa0a5b1));
          break;
        case DateTime.wednesday:
          text = '수';
          textStyle = TextStyle(color: Color(0xffa0a5b1));
          break;
        case DateTime.thursday:
          text = '목';
          textStyle = TextStyle(color: Color(0xffa0a5b1));
          break;
        case DateTime.friday:
          text = '금';
          textStyle = TextStyle(color: Color(0xffa0a5b1));
          break;
        case DateTime.saturday:
          text = '토';
          textStyle = TextStyle(color: Color(0xffa0a5b1));
          break;
      }
      return Center(
        child: Text(
          text,
          style: textStyle,
        ),
      );
    },
    // selectedBuilder: (context, date, _) {
    //   return FadeTransition(
    //       day: date.day.toString(), backColor: DaisyColors.main4Color, opacity: null,);
    // }
    );
  }
}


/**
 * 날짜 선택 해더
 */
class _CalendarHeader extends StatelessWidget {
  final DateTime focusedDay;
  final VoidCallback onLeftArrowTap;
  final VoidCallback onRightArrowTap;
  final Function datePicker ;
  const _CalendarHeader({
    Key? key,
    required this.focusedDay,
    required this.onLeftArrowTap,
    required this.onRightArrowTap,
    required this.datePicker,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final dayText = DateFormat('yyyy년MM월').format(focusedDay);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2.0),
      child: Row(
        children: [
          IconButton(
            icon: Icon(Icons.chevron_left),
            onPressed: onLeftArrowTap,
          ),
          const Spacer(),
          GestureDetector(
            child: SizedBox(
              width: 120.0,
              child: Text(
                dayText,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16.0,),
                // fontFamily: 'NanumRoundB',),
              ),
            ),
            onTap: (){
              datePicker.call();
              // selectDayPicker(context);
            },
          ),
          const Spacer(),
          IconButton(
            icon: Icon(Icons.chevron_right),
            onPressed: onRightArrowTap,
          ),
        ],
      ),
    );
  }
}