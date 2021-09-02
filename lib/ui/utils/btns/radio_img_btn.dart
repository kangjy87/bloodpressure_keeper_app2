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
              height: 155,
              width: 155,
            ),
            SizedBox(height : 20),
            Text(
              title,
              style: TextStyle(
                  fontFamily: 'NanumRoundB',
                  fontSize: 13.8,
                  color: Color(0xff454f63)),
            )
          ],
        ),
      ),
    );
  }
}
