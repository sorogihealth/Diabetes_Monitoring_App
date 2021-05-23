import 'package:flutter/material.dart';
import 'constants.dart';
import 'package:auto_size_text/auto_size_text.dart';

class TileContent extends StatelessWidget {
  final IconData icon;
  final String label1;
  final String label2;
  final String message;
  final Color color;

  const TileContent(
      {this.icon, this.label1, this.label2, this.message, this.color});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        AutoSizeText(
          message,
          style: kLabelTextStyle.copyWith(color: color),
          maxLines: 2,
          minFontSize: 8.0,
          group: labelGroup,
          textAlign: TextAlign.center,
        ),
        SizedBox(
          height: 10.0,
        ),
        Icon(
          icon,
          size: screenWidth(context, dividedBy: 12),
          color: color,
        ),
        SizedBox(
          height: 10.0,
        ),
        AutoSizeText(
          label1,
          style: kLabelTextStyle.copyWith(color: color),
          maxLines: 2,
          minFontSize: 8.0,
          group: labelGroup,
          textAlign: TextAlign.center,
        ),
        SizedBox(
          height: 5.0,
        ),
        AutoSizeText(
          label2,
          style: kNumberTextStyle.copyWith(color: color),
          minFontSize: 6.0,
          group: numberGroup,
          textAlign: TextAlign.center,
        ),
        // FittedBox(
        //   fit: BoxFit.contain,
        //   child: Text(
        //     label2,
        //     style: kNumberTextStyle,
        //     textAlign: TextAlign.center,
        //   ),
        // )
      ],
    );
  }
}
