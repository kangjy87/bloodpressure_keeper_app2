import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'BaseScaffoldController.dart';

class BaseScaffold extends StatelessWidget {

  AppBar? appBar;
  Widget? body;
  Color? backgroundColor;
  VoidCallback? onBackgroundTab;
  Widget? bottomNavigationBar;
  Widget? floatingActionButton ;
  BaseScaffold ({
    this.appBar,
    this.body,
    this.backgroundColor,
    this.onBackgroundTab,
    this.bottomNavigationBar,
    this.floatingActionButton
  });

  //프로그레스 뷰
  Widget _getProgressView (BaseScaffoldController controller) {
    return

      controller.isLoading == true ? Stack (
        children: [
          Container (
            width: double.maxFinite,
            height: Get.height,
            color: Colors.black54,
          ),

          Center (
            child: CircularProgressIndicator(color: Colors.white,),
          )
        ],
      ) : Container ();
  }


  @override
  Widget build(BuildContext context) {
    return GetBuilder<BaseScaffoldController>(
      init: BaseScaffoldController (),
      builder: (controller) => Obx (() {
        return Stack (
          children: [
            Scaffold(
              floatingActionButton :  floatingActionButton,
              bottomNavigationBar: bottomNavigationBar,
              appBar: appBar,
              body: Stack (
                children: [
                  GestureDetector(
                    child: body!,
                    onTap: onBackgroundTab,
                  )
                ],
              ),
              backgroundColor: backgroundColor,
            ),
            _getProgressView (controller)
          ],
        );
      }),
    );
  }

}