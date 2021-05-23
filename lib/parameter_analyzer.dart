import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'dart:core';

class PA extends StatefulWidget {
  final String parameter;

  const PA({Key key, this.parameter}) : super(key: key);

  @override
  _PAState createState() => _PAState();
}

class _PAState extends State<PA> {
  var test;
  final databaseReference = FirebaseDatabase.instance.reference();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      home: Scaffold(
        appBar: AppBar(
          title: Text(widget.parameter + ' Analysis'),
        ),
        body: Column(
          children: <Widget>[
            RaisedButton(
                onPressed: () => {
                      myFunc(),
                    })
          ],
        ),
      ),
    );
  }

  void myFunc() {
    databaseReference.once().then((DataSnapshot snapshot) {
      //print('Data : ${snapshot.value}');
      var x = databaseReference.orderByChild('email').equalTo('test@gmail.com');
      print(x);
    });
  }
}
