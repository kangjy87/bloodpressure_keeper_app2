import 'package:flutter/material.dart';

/* Form 형태에서 공통된 라벨 표시하도록 만든 위젯 */

/// HOW TO USE
/// - InpuLabelForm (label)
///    ㄴ ValidatorForm (validator text)
///    ㄴ child

class InputLabelForm extends StatelessWidget {
  String? label;
  FontWeight? labelFontWeight;
  Widget? child;

  InputLabelForm({
    Key? key,
    @required this.label,
    this.labelFontWeight = FontWeight.bold,
    @required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        /* label */
        Container(
          height: 32,
          padding: const EdgeInsets.symmetric(horizontal: 4),
          alignment: Alignment.centerLeft,
          child: Text(label!, style: TextStyle(color: Colors.black, fontSize: 14, fontWeight: labelFontWeight)),
        ),
        /* input */
        child!,
      ],
    );
  }
}
