import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

const kMainThemeColor = Color(0xFF0369C7);
const kPrimaryColor = Color(0xFF2C9FB5);
const kSecondaryColor = Color(0xFFDB5A67);
const kYellow = Color(0xFFFFC400);
const kTextFieldDecoration = InputDecoration(
  hintText: 'Enter a value',
  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(12.0)),
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: kPrimaryColor, width: 1.0),
    borderRadius: BorderRadius.all(Radius.circular(12.0)),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: kMainThemeColor, width: 2.0),
    borderRadius: BorderRadius.all(Radius.circular(12.0)),
  ),
);
const kLabelTextStyle = TextStyle(
  fontSize: 20.0,
  fontWeight: FontWeight.bold,
  color: kMainThemeColor,
);
const kLargeButtonTextStyle = TextStyle(
  fontSize: 20.0,
  fontWeight: FontWeight.bold,
  color: Colors.white,
);

const kNumberTextStyle = TextStyle(
  fontSize: 15.0,
  color: kPrimaryColor,
);

const kGreen = Color(0xFF9CCC65);

var labelGroup = AutoSizeGroup();
var numberGroup = AutoSizeGroup();
var titleGroup = AutoSizeGroup();

Size screenSize(BuildContext context) {
  return MediaQuery.of(context).size;
}

double screenWidth(BuildContext context, {double dividedBy = 1}) {
  return screenSize(context).shortestSide / dividedBy;
}
// #2C9FB5
// #DB5A67
// #2E77BA
