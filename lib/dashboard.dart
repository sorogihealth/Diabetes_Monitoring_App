import 'dart:async';
import 'dart:convert' show utf8;
import 'package:auto_size_text/auto_size_text.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flexcare/tile_button.dart';
import 'package:flexcare/tile_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'bottom_button.dart';
import 'constants.dart';
import 'dashboard_brain.dart';

class Dashboard extends StatefulWidget {
  final User user;

  const Dashboard({Key key, this.device, this.user}) : super(key: key);
  final BluetoothDevice device;

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  final String serviceUUID = "4fafc201-1fb5-459e-8fcc-c5c9c331914b";
  final String characteristicUUID = "beb5483e-36e1-4688-b7f5-ea07361b26a8";
  final databaseReference = FirebaseDatabase.instance.reference();
  bool isReady;
  Stream<List<int>> stream;
  List<double> traceDust = List();
  String bloodPressure = "";
  String bloodGlucose = "";
  String weight = "";
  String oxygen = "";
  String firstName = '';
  var currentValue;

  @override
  void initState() {
    super.initState();
    isReady = false;
    connectToDevice();
  }

  connectToDevice() async {
    if (widget.device == null) {
      _screenPop();
      return;
    }

    new Timer(const Duration(seconds: 15), () {
      if (!isReady) {
        disconnectFromDevice();
        _screenPop();
      }
    });

    await widget.device.connect();
    discoverServices();
  }

  disconnectFromDevice() {
    if (widget.device == null) {
      _screenPop();
      return;
    }

    widget.device.disconnect();
  }

  discoverServices() async {
    if (widget.device == null) {
      _screenPop();
      return;
    }

    List<BluetoothService> services = await widget.device.discoverServices();
    services.forEach((service) {
      if (service.uuid.toString() == serviceUUID) {
        service.characteristics.forEach((characteristic) {
          if (characteristic.uuid.toString() == characteristicUUID) {
            characteristic.setNotifyValue(!characteristic.isNotifying);
            stream = characteristic.value;

// Here you can write your code

            setState(() {
              // Here you can write your code for open new view
              isReady = true;
            });
          }
        });
      }
    });

    if (!isReady) {
      _screenPop();
    }
  }

  Future<bool> _onWillPop() {
    return showDialog(
        context: context,
        builder: (context) =>
            new AlertDialog(
              title: Text('Are you sure?'),
              content: Text('Do you want to disconnect device and go back?'),
              actions: <Widget>[
                new FlatButton(
                    onPressed: () => Navigator.of(context).pop(false),
                    child: new Text('No')),
                new FlatButton(
                    onPressed: () {
                      disconnectFromDevice();
                      Navigator.of(context).pop(true);
                    },
                    child: new Text('Yes')),
              ],
            ) ??
            false);
  }

  _screenPop() {
    Navigator.of(context).pop(true);
  }

  String _dataParser(List<int> dataFromDevice) {
    return utf8.decode(dataFromDevice);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        backgroundColor: kMainThemeColor,
        body: Container(
            child: !isReady
                ? Center(
                    child: Text(
                      "Waiting...",
                      style: TextStyle(fontSize: 24, color: Colors.red),
                    ),
                  )
                : Container(
                    child: StreamBuilder<List<int>>(
                      stream: stream,
                      builder: (BuildContext context,
                          AsyncSnapshot<List<int>> snapshot) {
                        if (snapshot.hasError)
                          return Text('Error: ${snapshot.error}');

                        if (snapshot.connectionState ==
                            ConnectionState.active) {
                          Future.delayed(const Duration(milliseconds: 0), () {
// Here you can write your code

                            currentValue = _dataParser(snapshot.data);

                            var tokens = currentValue.split("_");

                            bloodPressure = tokens[0];
                            bloodGlucose = tokens[1];
                            weight = tokens[2];
                            oxygen = tokens[3];

                            // databaseReference.push().set({
                            //   'User_id': widget.user.uid,
                            //   'blood_pressure': blood_pressure,
                            //   'blood_glucose': blood_glucose,
                            //   'weight': weight,
                            //   'oxygen': oxygen,
                            // });

                            print(widget.user.email);
                            print(widget.user.displayName);
                            firstName = getFirstName(widget.user.displayName);
                          });

                          return Column(
                            // crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Expanded(
                                flex: 2,
                                child: Container(
                                  // color: kMainThemeColor,
                                  // padding: EdgeInsets.all(75.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                          child: Column(
                                        children: [
                                          Text(
                                            'Hi, $firstName',
                                            style: kLargeButtonTextStyle,
                                          ),
                                        ],
                                      )),
                                    ],
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 6,
                                child: Container(
                                  width: double.infinity,
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 10.0, vertical: 20.0),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(
                                          screenWidth(context, dividedBy: 15)),
                                      // topRight: Radius.circular(20.0),
                                    ),
                                  ),
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        height: 10.0,
                                      ),
                                      Expanded(
                                        child: Row(
                                          children: [
                                            Expanded(
                                              child: TileButton(
                                                color: Colors.white,
                                                onPressed: () {
                                                  print('button was touched');
                                                },
                                                cardChild: TileContent(
                                                  icon: FontAwesomeIcons.tint,
                                                  label1: 'Blood Glucose',
                                                  label2: '$bloodGlucose mg/dL',
                                                  message: getBGMessage(
                                                      bloodGlucose),
                                                  color:
                                                      getBGColor(bloodGlucose),
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              child: TileButton(
                                                color: Colors.white,
                                                onPressed: () {
                                                  print('button was touched');
                                                },
                                                cardChild: TileContent(
                                                  icon: FontAwesomeIcons
                                                      .heartbeat,
                                                  label1: 'Blood Pressure',
                                                  label2: '$bloodPressure mmHg',
                                                  message: getBPMessage(
                                                      bloodPressure),
                                                  color:
                                                      getBPColor(bloodPressure),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Expanded(
                                        child: Row(
                                          children: [
                                            Expanded(
                                              child: TileButton(
                                                color: Colors.white,
                                                onPressed: () {
                                                  print('button was touched');
                                                },
                                                cardChild: TileContent(
                                                  icon: FontAwesomeIcons.lungs,
                                                  label1: 'Blood Oxygen',
                                                  label2: '$oxygen%',
                                                  message: getO2Message(oxygen),
                                                  color: getO2Color(oxygen),
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              child: TileButton(
                                                color: Colors.white,
                                                onPressed: () {
                                                  print('button was touched');
                                                },
                                                cardChild: TileContent(
                                                  icon: FontAwesomeIcons.weight,
                                                  label1: 'Weight',
                                                  label2: '$weight Kg',
                                                  message: getWSMessage(weight),
                                                  color: getWSColor(weight),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      // RoundedButton(
                                      //   onPressed: () {
                                      //     databaseReference.push().set({
                                      //       'User_id': widget.user.uid,
                                      //       'blood_pressure': bloodPressure,
                                      //       'blood_glucose': bloodGlucose,
                                      //       'weight': weight,
                                      //       'oxygen': oxygen,
                                      //     });
                                      //   },
                                      //   label: 'Upload',
                                      //   color: kPrimaryColor,
                                      // ),

                                      // ElevatedButton(
                                      //   onPressed: () {
                                      //     databaseReference.push().set({
                                      //       'User_id': widget.user.uid,
                                      //       'blood_pressure': bloodPressure,
                                      //       'blood_glucose': bloodGlucose,
                                      //       'weight': weight,
                                      //       'oxygen': oxygen,
                                      //     });
                                      //   },
                                      //   child: Text('Upload'),
                                      // )
                                    ],
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: BottomButton(
                                  onTap: () {
                                    databaseReference.push().set({
                                      'User_id': widget.user.uid,
                                      'blood_pressure': bloodPressure,
                                      'blood_glucose': bloodGlucose,
                                      'weight': weight,
                                      'oxygen': oxygen,
                                    });
                                  },
                                  label: 'Upload',
                                ),
                              )
                            ],
                          );
                        } else {
                          return Text('Check the stream');
                        }
                      },
                    ),
                  )),
      ),
    );
  }

  String getFirstName(String fullName) {
    return fullName.split(" ")[0];
  }
}
