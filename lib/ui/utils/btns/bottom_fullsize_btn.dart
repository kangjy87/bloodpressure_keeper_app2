import 'package:flutter/material.dart';

class BottomFullSizeBtn extends StatelessWidget {
  final String text ;
  final Color textColor ;
  final Color backgroundColor ;
  final VoidCallback setonclicklistener;
  const BottomFullSizeBtn({
    Key? key,
    required this.text,
    required this.textColor,
    required this.backgroundColor,
    required this.setonclicklistener,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 50.0,
      child: ElevatedButton(
          child: Text(
              text.toUpperCase(),
              style: TextStyle(fontSize: 14)
          ),
          style: ButtonStyle(
              foregroundColor: MaterialStateProperty.all<Color>(textColor),
              backgroundColor: MaterialStateProperty.all<Color>(backgroundColor),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(0.0),
                      side: BorderSide(color:backgroundColor)
                  )
              )
          ),
          onPressed: setonclicklistener
      )
    );
  }
}
