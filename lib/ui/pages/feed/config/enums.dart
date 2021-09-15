/** SNS type -- platform */
enum SnsType {
  youtube,
  instagram,
  channel
}

/** Feed media type */
enum MediaType {
  video,
  image,
}

enum AccountProviderType {
  kakao,
  google,
  apple,
  naver,
  facebook
}

/** access token type */
enum TokenType {
  Bearer
}


/** topper icon menu selected */
enum TopperIconMenu {
  event,
  notice,
  mypage,
  none
}

enum TopperIconBacgroundMode {
  bright,
  dark
}

/** 게시중단 요청 사유 과련 */
enum StopPostingReason {
  none,
  violant_and_sexual,
  invalid_copyright,
  etc
}


/** String to enum */
T enumFromString<T>(List<T> values, String value) {
  return values.firstWhere((v) => v.toString().split('.')[1] == value);
}