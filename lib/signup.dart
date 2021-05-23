import 'package:flexcare/roundedbutton.dart';
import 'package:flutter/material.dart';
import 'package:flexcare/login.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'BLE_connection.dart';
import 'constants.dart';

void main() {
  runApp(SignUp());
}

class SignUp extends StatelessWidget {
// This widget is the root of your application.

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final formKey = GlobalKey<FormState>();
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  TextEditingController fullnameController = TextEditingController();
  String email = '';
  String pass = '';
  String fullName = '';
  int counter = 1;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(),
      home: Scaffold(
          appBar: AppBar(
            backgroundColor: kMainThemeColor,
            title: Text('Sorogi Account Sign up'),
          ),
          body: Form(
              key: formKey,
              child: Padding(
                padding: EdgeInsets.only(left: 20.0, right: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Flexible(
                      child: Hero(
                          tag: 'icon',
                          child: Image.asset('assets/sorogiLogo.png')),
                    ),
                    TextFormField(
                      controller: fullnameController,
                      decoration: kTextFieldDecoration.copyWith(
                        hintText: 'Full Name',
                      ),
                      validator: (value) {
                        if (value.trim().isEmpty) {
                          return "Full Name is required";
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    TextFormField(
                      controller: emailController,
                      decoration: kTextFieldDecoration.copyWith(
                        hintText: 'Email',
                      ),
                      validator: (value) {
                        if (value.trim().isEmpty) {
                          return "Email is required";
                        }
                        if (!value.trim().contains('@') ||
                            !value.trim().contains('.com')) {
                          return "Email address is not valid";
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
                        if (value.trim().length < 6)
                          return "Password length cannot be less than 6 characters";
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
                            email = emailController.text.trim(),
                            pass = passController.text.trim(),
                            fullName = fullnameController.text.trim(),
                            registerAccount(context),
                          },
                      },
                      label: 'Create Account',
                      color: kMainThemeColor,
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    RoundedButton(
                      onPressed: () {
                        Navigator.of(context).push(
                            MaterialPageRoute(builder: (context) => Login()));
                      },
                      label: 'Login',
                      color: kPrimaryColor,
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                  ],
                ),
              )),
          key: _scaffoldKey),
    );
  }

  void registerAccount(BuildContext context) async {
    try {
      final User user = (await _auth.createUserWithEmailAndPassword(
              email: email, password: pass))
          .user;

      if (user != null) {
        if (!user.emailVerified) {
          await user.sendEmailVerification();
        }

        await user.updateProfile(displayName: fullName);
        final user1 = _auth.currentUser;
      }

      _scaffoldKey.currentState.showSnackBar(
          SnackBar(content: Text('Account created successfully!')));

      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => FlutterBlueApp(user)));
    } catch (e) {
      _scaffoldKey.currentState
          .showSnackBar(SnackBar(content: Text('Account already exist!')));
    }
  }
}
