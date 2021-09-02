import 'package:get/get.dart';

class MyTranslations extends Translations {

  static const String BTN_T = "";

  @override
  Map<String, Map<String, String>> get keys => {
    'en': {
      'title': 'Hello World %s',
    },
    'en_US': {
      'title': 'Hello World from US',
    },
    'pt': {
      'title': 'Olá de Portugal',
    },
    'pt_BR': {
      'title': 'Olá do Brasil',
    },
    'ko_KR': {
      'title': '내이름은 %s입니다.',
      BTN_T : "가보자 한번"
    },
  };
}
