import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:bloodpressure_keeper_app/ui/pages/feed/config/config.dart';
import 'package:bloodpressure_keeper_app/ui/pages/feed/utils/GeneralUtils.dart';

//버튼 타입  1
class AppMaterialButton extends StatelessWidget {

  Widget? icon;
  Widget? label;
  Color? color;
  double? height;
  double? elevation;
  VoidCallback? onPressed;

  AppMaterialButton ({
    this.icon,
    this.label,
    this.color,
    this.height = 0,
    this.elevation = 2.0,
    this.onPressed
  });

  @override
  Widget build(BuildContext context) {

    return ElevatedButton (
      onPressed: onPressed,
      child: Container (
        width: double.maxFinite,
        height: height! > 0 ? height : getUiSize(32.5),
        child: Stack (
          alignment: Alignment.center,
          children: [
            Positioned(
                left: 20,
                child: Container (
                  child: icon,
                )
            ),
            Center (
              child: Container (
                child: label,
              ),
            )
          ],
        ),
      ),
      style: ElevatedButton.styleFrom(
          primary: color,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8)
          ),
          elevation: elevation
      ),
    );
  }
}



//파티션 뷰
class Partition extends StatelessWidget {

  final double weight;
  Color? color;

  Partition({
    Key? key,
    required this.weight,
    this.color
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container (
      width: double.maxFinite,
      height: getUiSize(weight),
      color: color ?? Color (0xFFc2c2c2),
    );
  }

}