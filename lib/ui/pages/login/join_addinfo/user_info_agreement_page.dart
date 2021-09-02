import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'user_info_agreement_controller.dart';

class UserInfoAgreementPage extends StatelessWidget {
  const UserInfoAgreementPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<UserInfoAgreementController>(builder: (controller) {
      return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: Icon(Icons.arrow_back, color: Colors.black),
          ),
          title: Text(
            controller.title,
            style: TextStyle(color: Colors.black),
          ),
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
        ),
        body: Text('개인정보 취급 방침 내용이 나옵니다. 개인정보 취급 방침 내용이 나옵니다. 개인정보 취급 방침 내용이 나옵니다. '
            '개인정보 취급 방침 내용이 나옵니다. 개인정보 취급 방침 내용이 나옵니다. 개인정보 취급 방침 내용이 나옵니다. '
            '개인정보 취급 방침 내용이 나옵니다. 개인정보 취급 방침 내용이 나옵니다. 개인정보 취급 방침 내용이 나옵니다. '
            '개인정보 취급 방침 내용이 나옵니다. 개인정보 취급 방침 내용이 나옵니다. 개인정보 취급 방침 내용이 나옵니다. '
            '개인정보 취급 방침 내용이 나옵니다. 개인정보 취급 방침 내용이 나옵니다. 개인정보 취급 방침 내용이 나옵니다. '),
      );
    });
  }
}
