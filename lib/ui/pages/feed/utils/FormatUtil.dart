import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class FormatUtil {

  static String printTwoDigit(int n) {
    return NumberFormat("00").format(n);
  }

  static String numberWithComma(int param){
    return new NumberFormat('###,###,###,###').format(param).replaceAll(' ', '');
  }

  /// Currency

  static String printPriceWon(int price) {
    if (price == null) return "";
    return "${numberWithComma(price)}원";
  }

  static String printPriceDollar(int price) {
    if (price == null) return "";
    return "${numberWithComma(price)} USD";
  }

  /// Size

  // M,W,K ---> MEN, WOMEN, KIDS
  static String printSizeCode(String sizeCode){
    switch (sizeCode) {
      case "M":
        return "MEN";
      case "W":
        return "WOMEN";
      default: //kids 값은 현재 마이페이지 수정 시 이상하게(ex.Nike.cb) 내려오므로 default
        return "KIDS";
    }
  }

  /// DateTime

  // Duration ---> "dd일 HH:MM:SS"
  static String printReleaseDuration(Duration duration) {
//    String days = (duration.inDays > 0) ? "${printTwoDigit(duration.inDays)}일" : "";
    String twoDigitHours = printTwoDigit(duration.inHours);
    String twoDigitMinutes = printTwoDigit(duration.inMinutes.remainder(60));
    String twoDigitSeconds = printTwoDigit(duration.inSeconds.remainder(60));
    return "$twoDigitHours:$twoDigitMinutes:$twoDigitSeconds";
  }

  // Duration ---> "dd일 HH:MM:SS"
  static String printPhoneDuration(Duration duration) {
    String twoDigitMinutes = printTwoDigit(duration.inMinutes.remainder(60));
    String twoDigitSeconds = printTwoDigit(duration.inSeconds.remainder(60));
    return "$twoDigitMinutes:$twoDigitSeconds";
  }

  // String ---> DateTime
  static DateTime? getDateTimeFromString(String date, {String? format}) {

    /*
     * Format Example
     * - yyyyMMdd
     * - yyyy.MM.dd
     * - yyyyMMddHHmmss
     * - yyyy-MM-dd          //이 포맷은 format 지정할 필요 없음
     * - yyyy-MM-dd HH:mm:ss //이 포맷은 format 지정할 필요 없음
     */

    if (date == null || date.isEmpty) return null;

    if (format == null || format == "yyyyMMdd")
      return DateTime.parse(date);
    else if (format == "yyyyMMddHHmmss")
      return DateTime.parse(date.substring(0, 8) + "T" + date.substring(8));

    return DateFormat(format).parse(date);
  }

  // DateTime ---> String
  static String printDateTime(DateTime date, {String? format}) {
    if (date == null) return "";
    return DateFormat(format).format(date);
  }

  /// json

  static bool getBoolFromValue(dynamic value) {
    if (value == 1 || value == "1" || value == true)
      return true;
    else
      return false;
  }

  static bool isJsonObjectEmpty(dynamic value) {
    if (value == null) return true;
    else if (value == "") return true;
    return false;
  }

  /// enum

  static String enumToString (t) {
    return t.toString().split(".")[1];
  }

  /// NO USE

  static String getTimeString (int time) {
    int min = (time / 60).floor ();
    int sec = time % 60;

    return min.toString() + "분 " + sec.toString() + "초";
  }
}


/// 입찰가격 입력 시 천단위 콤마 찍어주는 formatter
class CurrencyInputFormatter extends TextInputFormatter {

  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {

    if(newValue.selection.baseOffset == 0){
      debugPrint(true.toString());
      return newValue;
    }

    double value = double.parse(newValue.text);
    final formatter = NumberFormat.currency(name: "", decimalDigits: 0);
    String newText = formatter.format(value);

    return newValue.copyWith(
        text: newText,
        selection: new TextSelection.collapsed(offset: newText.length));
  }
}

extension EnumTransform on List {
  String? string<T>(T value) {
    if (value == null || (isEmpty)) return null;
    var occurence = singleWhere(
            (enumItem) => enumItem.toString() == value.toString(),
        orElse: () => null);
    if (occurence == null) return null;
    return occurence.toString().split('.').last;
  }

  T enumFromString<T>(String value) {
    return firstWhere((type) => type.toString().split('.').last == value,
        orElse: () => null);
  }
}