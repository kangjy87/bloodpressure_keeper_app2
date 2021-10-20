import 'package:bloodpressure_keeper_app/ui/pages/feed/utils/GeneralUtils.dart';
import 'package:flutter/material.dart';

class RadioImgBtn extends StatelessWidget {
  final int index;
  final int nowIndex;
  final String selectImgRoute;
  final String unselectedImgRoute;
  final String title;
  final Function(int index) setonclicked;

  const RadioImgBtn({
    Key? key,
    required this.index,
    required this.nowIndex,
    required this.selectImgRoute,
    required this.unselectedImgRoute,
    required this.title,
    required this.setonclicked,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: GestureDetector(
        onTap: () {
          setonclicked.call(index);
        },
        child: Column(
          children: [
            Image.asset(
              nowIndex == index ? selectImgRoute : unselectedImgRoute,
              height: getUiSize(110),
              width: getUiSize(110),
            ),
            SizedBox(height : getUiSize(16)),
            Text(
              title,
              style: TextStyle(
                  fontFamily: 'NanumRoundB',
                  fontSize: getUiSize(11),
                  color: Color(0xff454f63)),
            )
          ],
        ),
      ),
    );
  }
}
