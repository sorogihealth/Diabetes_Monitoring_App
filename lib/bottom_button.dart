import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

import 'constants.dart';

class BottomButton extends StatelessWidget {
  final String label;
  final Function onTap;

  const BottomButton({@required this.label, @required this.onTap});

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onTap,
      child: Center(
        child: AutoSizeText(
          label,
          style: kLargeButtonTextStyle,
          group: titleGroup,
        ),
      ),
    );
  }
}
