import 'package:flexcare/roundedbutton.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flexcare/signup.dart';
import 'package:flexcare/dashboard.dart';
import 'package:flexcare/BLE_connection.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'constants.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  FirebaseAuth _auth = FirebaseAuth.instance;
  final formKey = GlobalKey<FormState>();
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  String email = '';
  String pass = '';
  bool flag = false;

  @override
  Widget build(BuildContext context) {
    // readData();

    return Scaffold(
      appBar: AppBar(
        title: Text('Log into your Sorogi Account'),
        backgroundColor: kMainThemeColor,
      ),
      body: Center(
          child: Padding(
        padding: EdgeInsets.only(left: 20.0, right: 20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Flexible(
              child: Hero(
                tag: 'icon',
                child: Image.asset('assets/sorogiLogo.png'),
              ),
            ),
            Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  TextFormField(
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: kTextFieldDecoration.copyWith(
                      hintText: 'Enter Email',
                    ),
                    validator: (value) {
                      if (value.trim().isEmpty) {
                        return "Email is required";
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  TextFormField(
                    obscureText: true,
                    controller: passController,
                    decoration: kTextFieldDecoration.copyWith(
                      hintText: 'Password',
                    ),
                    validator: (value) {
                      if (value.trim().isEmpty) return "Password is required";
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  RoundedButton(
                    onPressed: () => {
                      if (formKey.currentState.validate())
                        {
                          print('The form is valid'),
                          email = emailController.text,
                          pass = passController.text,
                          signInWithEmailPassword(),
                        }
                    },
                    label: 'Login',
                    color: kMainThemeColor,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            RoundedButton(
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => SignUp()));
              },
              label: 'Sign Up',
              color: kPrimaryColor,
            ),
            SizedBox(
              height: 10.0,
            ),
          ],
        ),
      )), //center
      key: _scaffoldKey,
    );
  }

  void signInWithEmailPassword() async {
    try {
      final User user =
          (await _auth.signInWithEmailAndPassword(email: email, password: pass))
              .user;

      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => FlutterBlueApp(user)));
    } catch (e) {
      _scaffoldKey.currentState.showSnackBar(SnackBar(
          content: Text("Failed to sign in with this email and password")));
    }
  }
}
