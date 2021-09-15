import 'package:get/get.dart';

class AppTranslation extends Translations {

  static const tab_title_1 = "tab_title_1";
  static const tab_title_2 = "tab_title_2";
  static const tab_title_3 = "tab_title_3";
  static const tab_title_4 = "tab_title_4";

  static const alert_label_ok = "alert_label_ok";
  static const lbl_no_title = "lbl_no_title";

  static const title_login_page = "title_login_page";
  static const btn_label_kakao_login = "btn_label_kakao_login";
  static const btn_label_google_login = "btn_label_google_login";
  static const btn_label_apple_login = "btn_label_apple_login";
  static const btn_label_common_login = "btn_label_common_login";

  static const home_hotclip_main_title = "home_hotclip_main_title";
  static const home_hotclip_sub_title = "hotclip_sub_title";
  static const home_feed_main_title = "home_feed_main_title";
  static const home_feed_sub_title = "home_feed_sub_title";
  static const home_ticketing_main_title = "home_ticketing_main_title";
  static const home_ticketing_sub_title = "home_ticketing_sub_title";
  static const mypage_main_title = "mypage_main_title";
  static const mypage_sub_title = "mypage_sub_title";


  static const user_agreements_greetings_title = "user_agreements_greetings";
  static const user_agreements_greetings_description = "user_agreements_greetings_description";
  static const terms_of_use_title = "terms_of_use_title";
  static const privacy_policy_title = "privacy_policy_title";
  static const btn_label_agree = "btn_label_agree";

  static const join_form_title = "join_form_title";
  static const join_form_description = "join_form_description";

  static const btn_label_visit = "btn_label_visit";

  static const btn_label_stop_posting = "btn_label_stop_posting";
  static const btn_label_share = "btn_label_share";
  static const btn_label_cancel = "btn_label_cancel";

  static const title_request_stop_posting = "title_request_stop_posting";
  static const description_request_stop_posting = "description_request_stop_posting";
  static const btn_label_violant_or_sexual = "btn_label_violant_or_sexual";
  static const btn_label_invalid_copyright = "btn_label_invalid_copyright";
  static const btn_label_etc = "btn_label_etc";
  static const btn_label_confirm = "btn_label_confirm";

  static const desc_request_success = "desc_request_success";


  @override
  Map<String, Map<String, String>> get keys => {
    'en': {
      tab_title_1 : "Home",
      tab_title_2 : "Ticketing",
      tab_title_3 : "Feed",
      tab_title_4 : "Hot clip",

      alert_label_ok : "OK",
      lbl_no_title : "Untitled",

      title_login_page : "Sign up",
      btn_label_kakao_login : "Sign in with Kakao",
      btn_label_google_login : "Sign in with Google",
      btn_label_apple_login : "Sign in with Apple",
      btn_label_common_login : "Common sign in",

      home_hotclip_main_title : "Hot clips",
      home_hotclip_sub_title : "VIDEO CLIP",
      home_feed_main_title : "Feed",
      home_feed_sub_title : "FEED",
      home_ticketing_main_title : "Ticketing",
      home_ticketing_sub_title : "TICKETING",

      mypage_main_title : "My page",
      mypage_sub_title : "MY AGE",

      user_agreements_greetings_title : "Welcome to ticket booth",
      user_agreements_greetings_description : "These are conditions for joyful with application and ticketing. Please read carefully and confirm checkbox. :)",
      terms_of_use_title : "Terms of user",
      privacy_policy_title : "Privacy policy",
      btn_label_agree : "Agree",
      join_form_title : "Let us know you",
      join_form_description : "bla bla bla...",

      btn_label_visit : "Visit original",
      btn_label_stop_posting : "Request stop posting",
      btn_label_share : "Share",
      btn_label_cancel : "Cancel",

      title_request_stop_posting : "Request stop posting",
      description_request_stop_posting : "Don't be lie to us or kill you.",
      btn_label_violant_or_sexual : "So violant or sexual",
      btn_label_invalid_copyright : "Invalid copyright",
      btn_label_etc : "Etc.",
      btn_label_confirm : "Confirm",

      desc_request_success : "Request complete."

    },
    'ko': {
      tab_title_1 : "홈",
      tab_title_2 : "공연예매",
      tab_title_3 : "피드",
      tab_title_4 : "핫클립",

      alert_label_ok : "확인",
      lbl_no_title : "제목없음",

      title_login_page : "회원가입",
      btn_label_kakao_login : "카카오로 시작하기",
      btn_label_google_login : "구글로 시작하기",
      btn_label_apple_login : "애플로 시작하기",
      btn_label_common_login : "일반 로그인",

      home_hotclip_main_title : "핫클립",
      home_hotclip_sub_title : "VIDEO CLIP",
      home_feed_main_title : "피드",
      home_feed_sub_title : "FEED",
      home_ticketing_main_title : "공연예매",
      home_ticketing_sub_title : "TICKETING",


      mypage_main_title : "마이페이지",
      mypage_sub_title : "MY AGE",

      user_agreements_greetings_title : "매표소에 오신것을 환영합니다.",
      user_agreements_greetings_description : "즐거운 매표소 이용과\n원활한 티켓 예매를 위한 약관입니다.\n꼼꼼히 읽어보시고 동의해주세요 :)",
      terms_of_use_title : "이용약관",
      privacy_policy_title : "개인정보 처리 방침",
      btn_label_agree : "동의",
      join_form_title : "당신을 알려주세요.",
      join_form_description : "티켓 예매 시 사용되는 정보입니다.\n정확하게 입력해주세요 :)",

      btn_label_visit : "방문하기",
      btn_label_stop_posting : "게시중단",
      btn_label_share : "공유",
      btn_label_cancel : "취소",

      title_request_stop_posting : "게시중단 요청",
      description_request_stop_posting : "* 허위로 게시중단을 요청하는 경우 서비스 이용이 제한 될 수 있습니다.",
      btn_label_violant_or_sexual : "선정적이거나 폭력적인 게시물",
      btn_label_invalid_copyright : "저작권이 침해된 게시물",
      btn_label_etc : "기타",
      btn_label_confirm : "확인",

      desc_request_success : "요청하신 사항이 잘 접수 되었습니다."
    },
  };
}
