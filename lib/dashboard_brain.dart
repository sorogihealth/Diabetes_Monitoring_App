import 'package:flutter/material.dart';

import 'constants.dart';

String getBGMessage(String bloodGlucose) {
  print('Updating UI');
  String result = 'Getting Readings...';
  try {
    int bG = int.parse(bloodGlucose);
    if (bG < 70) {
      result = 'Low';
    } else if (bG < 130) {
      result = 'Normal';
    } else if (bG < 180) {
      result = 'Elevated';
    } else {
      result = 'FHS staff will be in contact';
    }
  } on FormatException {}
  return result;
}

String getBPMessage(String bloodPressure) {
  print('Updating UI');
  String result = 'Getting Readings...';
  try {
    int bP = int.parse(bloodPressure);
    if (bP < 50) {
      result = 'Low';
    } else if (bP < 120) {
      result = 'Normal';
    } else if (bP < 129) {
      result = 'Elevated BP';
    } else if (bP < 139) {
      result = 'Stage 1';
    } else if (bP < 179) {
      result = 'Stage 2';
    } else {
      result = 'Hypertensive ';
    }
  } on FormatException {}
  return result;
}

String getO2Message(String bloodOxygen) {
  print('Updating UI');
  String result = 'Getting Readings...';
  try {
    int o2 = int.parse(bloodOxygen);
    if (o2 < 90) {
      result = 'Low';
    } else if (o2 < 95) {
      result = 'Normal';
    } else {
      result = 'Borderline';
    }
  } on FormatException {}
  return result;
}

String getWSMessage(String weight) {
  print('Updating UI');
  String result = 'Getting Readings...';
  /* Since the BMI function is not implemented this method was not completed */

  // try {
  //   int wS = int.parse(weight);
  //
  // } on FormatException {
  // }
  return result;
}

Color getBGColor(String bloodGlucose) {
  print('Updating UI');
  Color result = Colors.grey;
  try {
    int bG = int.parse(bloodGlucose);
    if (bG < 70) {
      result = kSecondaryColor;
    } else if (bG < 130) {
      result = kGreen;
    } else if (bG < 180) {
      result = kYellow;
    } else {
      result = kSecondaryColor;
    }
  } on FormatException {}
  return result;
}

Color getBPColor(String bloodPressure) {
  Color result = Colors.grey;
  try {
    int bP = int.parse(bloodPressure);
    if (bP < 50) {
      result = kSecondaryColor;
    } else if (bP < 120) {
      result = kGreen;
    } else if (bP < 129) {
      result = kYellow;
    } else if (bP < 139) {
      result = kYellow;
    } else if (bP < 179) {
      result = kSecondaryColor;
    } else {
      result = kSecondaryColor;
    }
  } on FormatException {}
  return result;
}

Color getO2Color(String bloodOxygen) {
  print('Updating UI');
  Color result = Colors.grey;
  try {
    int o2 = int.parse(bloodOxygen);
    if (o2 < 90) {
      result = kSecondaryColor;
    } else if (o2 < 95) {
      result = kGreen;
    } else {
      result = kYellow;
    }
  } on FormatException {}
  return result;
}

Color getWSColor(String weight) {
  print('Updating UI');
  Color result = Colors.grey;
  /* Since the BMI function is not implemented this method was not completed */

  // try {
  //   int wS = int.parse(weight);
  //
  // } on FormatException {
  // }
  return result;
}
