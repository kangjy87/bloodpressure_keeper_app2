import 'package:bloodpressure_keeper_app/model/client_credentials_grant_dto.dart';
import 'package:bloodpressure_keeper_app/ui/pages/dashboard/dashboard_page.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:flutter_kakao_login/flutter_kakao_login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'dart:io' show Platform;
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:bloodpressure_keeper_app/retrofit/blood_pressure_server.dart';
import 'package:bloodpressure_keeper_app/model/users_dto.dart';
import 'package:bloodpressure_keeper_app/retrofit/tdi_servers.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:bloodpressure_keeper_app/ui/routes/app_routes.dart';
import 'package:bloodpressure_keeper_app/utils/shared_preferences_info/get_client_credentials_grant.dart';
import 'package:bloodpressure_keeper_app/utils/shared_preferences_info/login_info.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
class LoginController extends GetxController {
  final String title = '로그인';
  static final FlutterKakaoLogin kakaoSignIn = FlutterKakaoLogin();
  @override
  void onInit() {
    super.onInit();
    kakaoLoad();
    googleLoad();
  }

  /**
   * !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
   * 카카오 로그인
   */
  void kakaoLoad() async {
    // Kakao SDK Init (Set NATIVE_APP_KEY)
    await kakaoSignIn.init('3dd289ed266b87ad48dde9538fc876b0');
    // For Android
    //final hashKey = await kakaoSignIn.hashKey;
    //print('>>>>>>>>>>>>>>>!!!!!!!!!!!!!!!!!!!!!!!!!!!!!hashKey: $hashKey');
    update();
  }

  Future<Null> kakaoLogin() async {
    try {
      EasyLoading.show();
      final result = await kakaoSignIn.logIn();
      processLoginResult(result);
    } on PlatformException catch (e) {
      EasyLoading.dismiss();
      print('>>>>>>>>>>>>>>에러코드>>>>>>>>>>${e.message}');
    }
    update();
  }

  void processLoginResult(KakaoLoginResult result) {
    switch (result.status) {
      case KakaoLoginStatus.loggedIn:
        getAccountInfo();
        break;
      case KakaoLoginStatus.loggedOut:
        break;
      case KakaoLoginStatus.unlinked:
        break;
    }
  }

  Future<Null> getAccountInfo() async {
    try {
      final result = await kakaoSignIn.getUserMe();
      final account = result.account;
      _processAccountResult(account);
    } on PlatformException catch (e) {}
  }

  void _processAccountResult(KakaoAccountResult? account) {
    if (account != null) {
      final userID = (account.userID == null) ? 'None' : account.userID;
      final userEmail =
          (account.userEmail == null) ? 'None' : account.userEmail;
      final userPhoneNumber =
          (account.userPhoneNumber == null) ? 'None' : account.userPhoneNumber;
      final userDisplayID =
          (account.userDisplayID == null) ? 'None' : account.userDisplayID;
      final userNickname =
          (account.userNickname == null) ? 'None' : account.userNickname;
      final userGender =
          (account.userGender == null) ? 'None' : account.userGender;
      final userAgeRange =
          (account.userAgeRange == null) ? 'None' : account.userAgeRange;
      final userBirthyear =
          (account.userBirthyear == null) ? 'None' : account.userBirthyear;
      final userBirthday =
          (account.userBirthday == null) ? 'None' : account.userBirthday;
      final userProfileImagePath = (account.userProfileImagePath == null)
          ? 'None'
          : account.userProfileImagePath;
      final userThumbnailImagePath = (account.userThumbnailImagePath == null)
          ? 'None'
          : account.userThumbnailImagePath;

      userGubun(userID, userEmail! ,'kakao');
      String strData = '- ID is $userID\n'
          '- Email is $userEmail\n'
          '- PhoneNumber is $userPhoneNumber\n'
          '- DisplayID is $userDisplayID\n'
          '- Nickname is $userNickname\n'
          '- Gender is $userGender\n'
          '- Age is $userAgeRange\n'
          '- Birthyear is $userBirthyear\n'
          '- Birthday is $userBirthday\n'
          '- ProfileImagePath is $userProfileImagePath\n'
          '- ThumbnailImagePath is $userThumbnailImagePath';

      print('>>>>>>>>>>>>>>>>>>>>>>>>>>>$strData');
    }
  }

  /**
   * !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
   *
   * 구글로그
   */
  void googleLoad() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
  }

  void googleLogin() async {
    EasyLoading.show();
    User? user = await currentUser();
    print('!!!!!!!!!!!!!!!!!${user!.displayName}>>>>>>>>>>>>>>>${user.email}');

    userGubun(user.uid, user.email! ,'google');
  }

  Future<User?> currentUser() async {
    GoogleSignIn googleSignIn = GoogleSignIn();
    final GoogleSignInAccount? account = await googleSignIn.signIn();
    if(account == null){
      EasyLoading.dismiss();
    }
    final GoogleSignInAuthentication authentication =
        await account!.authentication;

    final OAuthCredential credential = GoogleAuthProvider.credential(
        idToken: authentication.idToken,
        accessToken: authentication.accessToken);

    final UserCredential authResult =
        await FirebaseAuth.instance.signInWithCredential(credential);
    final User? user = authResult.user;
    return user;
  }

  /**
   * !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
   *
   * 애플로그인
   */
  void appleLogin()async{
    UserCredential  getLogin = await  appleLoginGo();
    User? data = getLogin.user ;
    print('>>>>>>>>>>>>>${data!.email}');
    userGubun(data.uid, data.email.toString() ,'apple');
  }
  Future<UserCredential> appleLoginGo() async {
    final credential = await SignInWithApple.getAppleIDCredential(
      scopes: [
        AppleIDAuthorizationScopes.email,
        AppleIDAuthorizationScopes.fullName,
      ],
      webAuthenticationOptions: WebAuthenticationOptions(
        clientId: "bloodpressureKeeperApp.appkeeper.com",
        redirectUri: Uri.parse(
            "https://infrequent-glacier-cauliflower.glitch.me/callbacks/sign_in_with_apple"),
      ),
    );
    print('!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!');
    print('!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!${credential.authorizationCode}');
      final oauthCredential = OAuthProvider("apple.com").credential(
        idToken: credential.identityToken,
        accessToken: credential.authorizationCode,
      );
    return await FirebaseAuth.instance.signInWithCredential(oauthCredential);
    // if (Platform.isIOS) {
    //   final credential = await SignInWithApple.getAppleIDCredential(
    //     scopes: [
    //       AppleIDAuthorizationScopes.email,
    //       AppleIDAuthorizationScopes.fullName,
    //     ],
    //   );
    //   print(credential);
    //   userGubun(credential.identityToken, AppleIDAuthorizationScopes.email.toString() ,'apple');
    //   final oauthCredential = OAuthProvider("apple.com").credential(
    //     idToken: credential.identityToken,
    //     accessToken: credential.authorizationCode,
    //   );
    //   await FirebaseAuth.instance.signInWithCredential(oauthCredential);
    // } else {
    //   Get.toNamed(AppRoutes.JoinAddInfo);
    // }
  }
  void userGubun(String? uuid, String email, String provider) async{
    GetClientCredentialsGrantDto gcDto = await getClientCredentiaksGrant();
    String appKey = "Bearer ${gcDto.access_token}" ;
    print('서버키 !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!${appKey}');
    await FirebaseMessaging.instance.getToken().then((token){
      setUserInfo(uuid, email, provider, (){
        // getClientCredentiaksGrant() ;
        TdiServers(bloodPressureServer: (BloodPressureServer bps) async {
          UsersDto task = UsersDto();
          task.uuid = uuid ;
          task.email = email ;
          task.provider = provider ;
          task.fcm_token = token ;
          final resp = await bps.UsersInfo(appKey, task);
          print('저장된값>>>>>>>>>>>${resp.data!.age}>>>>>>>>>>>>>>${resp.data!.nickname}');
          EasyLoading.dismiss();
          if(resp.data != null && resp.data!.nickname != null && resp.data!.nickname != ""){
            setUserAddInfo(resp.data!.nickname, resp.data!.gender, resp.data!.age, (){
              // Get.offAll(DashboardPage(),transition: Transition.rightToLeft);
              Get.offAllNamed(AppRoutes.DASHBOARD);
            });
          }else{
            Get.offAllNamed(AppRoutes.JoinAddInfo);
          }
        });
      });
    });
  }
}
