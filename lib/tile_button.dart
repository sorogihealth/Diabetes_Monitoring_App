import 'package:flutter/material.dart';

class TileButton extends StatelessWidget {
  final Color color;
  final Widget cardChild;
  final Function onPressed;

  TileButton({@required this.color, this.cardChild, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(15.0),
      child: Material(
        elevation: 5.0,
        color: color,
        borderRadius: BorderRadius.circular(12.5),
        child: MaterialButton(
          onPressed: onPressed,
          child: Container(
            child: cardChild,
            margin: EdgeInsets.all(15.0),
          ),
        ),
      ),
    );
  }
}
