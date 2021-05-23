import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {
  final Color color;
  final String label;
  final Function onPressed;

  RoundedButton(
      {@required this.color, @required this.label, @required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Material(
      // elevation: 5.0,
      color: color,
      borderRadius: BorderRadius.circular(12.5),
      child: MaterialButton(
        height: 45.0,
        onPressed: onPressed,
        child: Text(
          label,
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
