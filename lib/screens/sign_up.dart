import 'dart:convert';

import 'package:ecommerce_app/API/CallAPI.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:core';
import 'dart:math';
import '../main.dart';
import './sign_in.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController emailFieldController;
  TextEditingController passwordFieldController;
  TextEditingController nameFieldController;
  TextEditingController addressFieldController;
  TextEditingController phoneFieldController;

  bool _isLoading = false;

  String name = "",
      address = "",
      email = "",
      phone = "",
      password = "",
      key = "";
  var deviceToken;
  var chars = "abcdefghijklmnopqrstuvwxyz0123456789";
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

  @override
  void initState() {
    generateKey();
    _firebaseMessaging.getToken().then((token) async {
      print("Notification token");
      print(token);

      setState(() {
        deviceToken = token;
      });
    });
    super.initState();
  }

  void generateKey() {
    Random rnd = new Random(new DateTime.now().millisecondsSinceEpoch);
    for (var i = 0; i < 8; i++) {
      key += chars[rnd.nextInt(chars.length)];
    }

    print("key");
    print(key);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellowAccent[50],
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Container(
              height: MediaQuery.of(context).size.height / 2.25,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(85.0),
                ),
                image: DecorationImage(
                  image: AssetImage('assets/images/ecom_bg.jpg'),
                  fit: BoxFit.cover,
                  colorFilter: ColorFilter.mode(
                      Colors.grey.withOpacity(0.5), BlendMode.dstATop),
                ),
              ),
              child: Stack(
                children: <Widget>[
                  Positioned(
                    top: MediaQuery.of(context).size.height / 5,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.only(left: 15.0),
                              child: Icon(
                                Icons.ac_unit,
                                color: Colors.yellow,
                                size: 35,
                              ),
                            ),
                            Container(
                              child: Text(
                                "smrtshop",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 35,
                                    fontWeight: FontWeight.bold,
                                    shadows: [
                                      Shadow(
                                        blurRadius: 10.0,
                                        color: Colors.black87,
                                        offset: Offset(2.0, 3.0),
                                      ),
                                    ]),
                              ),
                            ),
                          ],
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 20.0, top: 10.0),
                          child: Text(
                            "Discovery and deal by the people for ",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 20.0),
                          child: Text(
                            "the people",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            // Container(
            //   padding: EdgeInsets.only(left: 20.0, right: 20.0, top: 10.0),
            //   child: TextField(
            //     controller: nameFieldController,
            //     decoration: InputDecoration(
            //       labelText: 'Name',
            //       labelStyle: TextStyle(
            //         color: Colors.black26,
            //         fontSize: 15.0,
            //       ),
            //       focusedBorder: UnderlineInputBorder(
            //         borderSide: BorderSide(color: Colors.black26),
            //       ),
            //     ),
            //     onChanged: (value) {
            //       setState(() {
            //         name = value;
            //       });
            //     },
            //   ),
            // ),
            // Container(
            //   padding: EdgeInsets.only(left: 20.0, right: 20.0),
            //   child: TextField(
            //     controller: addressFieldController,
            //     keyboardType: TextInputType.emailAddress,
            //     decoration: InputDecoration(
            //       labelText: 'Address',
            //       labelStyle: TextStyle(
            //         color: Colors.black26,
            //         fontSize: 15.0,
            //       ),
            //       focusedBorder: UnderlineInputBorder(
            //         borderSide: BorderSide(color: Colors.black26),
            //       ),
            //     ),
            //     onChanged: (value) {
            //       setState(() {
            //         address = value;
            //       });
            //     },
            //   ),
            // ),
            Container(
              padding: EdgeInsets.only(left: 20.0, right: 20.0),
              child: TextField(
                controller: emailFieldController,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  labelText: 'Email',
                  labelStyle: TextStyle(
                    color: Colors.black26,
                    fontSize: 15.0,
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.black26),
                  ),
                ),
                onChanged: (value) {
                  setState(() {
                    email = value;
                  });
                },
              ),
            ),
            // Container(
            //   padding: EdgeInsets.only(left: 20.0, right: 20.0),
            //   child: TextField(
            //     controller: phoneFieldController,
            //     keyboardType: TextInputType.number,
            //     decoration: InputDecoration(
            //       labelText: 'Phone no.',
            //       labelStyle: TextStyle(
            //         color: Colors.black26,
            //         fontSize: 15.0,
            //       ),
            //       focusedBorder: UnderlineInputBorder(
            //         borderSide: BorderSide(color: Colors.black26),
            //       ),
            //     ),
            //     onChanged: (value) {
            //       setState(() {
            //         phone = value;
            //       });
            //     },
            //   ),
            // ),
            Container(
              padding: EdgeInsets.only(left: 20.0, right: 20.0),
              margin: EdgeInsets.only(bottom: 10.0),
              child: TextField(
                controller: passwordFieldController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Password',
                  labelStyle: TextStyle(
                    color: Colors.black26,
                    fontSize: 15.0,
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.black26),
                  ),
                ),
                onChanged: (value) {
                  setState(() {
                    password = value;
                  });
                },
              ),
            ),
            Container(
              margin: EdgeInsets.only(
                  right: 20.0, left: 20.0, top: 20.0, bottom: 25.0),
              child: RaisedButton(
                onPressed: _isLoading ? null : _handleRegister,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                color: Theme.of(context).primaryColor,
                elevation: 3.0,
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Text(
                    _isLoading ? 'Please wait...' : 'Sign Up',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w300,
                      fontSize: 16.0,
                    ),
                  ),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 25.0, bottom: 40.0),
              child: RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: 'Have an account?  ',
                      style: TextStyle(
                        color: Colors.black26,
                        fontSize: 15.0,
                      ),
                    ),
                    TextSpan(
                      text: 'Log In',
                      style: TextStyle(
                        color: Theme.of(context).accentColor,
                        fontSize: 15.0,
                        decoration: TextDecoration.underline,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          // navigate to desired screen
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => SignIn()),
                          );
                        },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _handleRegister() async {
    if (email == "") {
      _showErrorAlert("Email field is empty");
    } else if (!email.contains('@') || !email.contains('.')) {
      _showErrorAlert("Email is invalid");
    } else if (password == "") {
      _showErrorAlert("Password field is empty");
    } else {
      var data = {
        //"name": name,
        //"address": address,
        "email": email,
        //"phone": phone,
        "password": password,
        "app_token": deviceToken,
      };

      setState(() {
        _isLoading = true;
      });

      var res = await CallApi().postData(data, 'api/registration');

      var body = json.decode(res.body);
      print(body);

      if (res.statusCode == 200) {
        //print(user['id']);
        //print(body['token']);
        setState(() {
          _isLoading = false;
        });
        _showRegisterAlert();
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => SignIn()));
      } else {
        setState(() {
          _showErrorAlert("Something went wrong");
          _isLoading = false;
        });
      }
    }
  }

  _showRegisterAlert() {
    Fluttertoast.showToast(
        msg: "Account created successfully!",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIos: 1,
        backgroundColor: appBlueShade.withOpacity(0.9),
        textColor: Colors.white,
        fontSize: 13.0);
  }

  _showErrorAlert(String msg) {
    Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIos: 1,
        backgroundColor: Colors.redAccent.withOpacity(0.9),
        textColor: Colors.white,
        fontSize: 13.0);
  }
}
