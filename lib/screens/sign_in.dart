import 'dart:convert';

import 'package:ecommerce_app/API/CallAPI.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../main.dart';
import '../screens/home_page.dart';
import '../screens/search_products.dart';
import '../screens/submit_product.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import './sign_up.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  TextEditingController emailFieldController;
  TextEditingController passwordFieldController;

  bool _isLoading = false;

  String email = "", password = "";

  var deviceToken;
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

  @override
  void initState() {
    _firebaseMessaging.getToken().then((token) async {
      print("Notification token");
      print(token);

      setState(() {
        deviceToken = token;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        SystemChannels.platform.invokeMethod('SystemNavigator.pop');
      },
      child: Scaffold(
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
              Container(
                padding: EdgeInsets.only(left: 20.0, right: 20.0),
                margin: EdgeInsets.only(top: 30.0),
                child: Text(
                  'Email address',
                  style: TextStyle(
                    color: Colors.black26,
                    fontSize: 15.0,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.only(left: 20.0, right: 20.0),
                child: TextField(
                  controller: emailFieldController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    hintText: 'user@email.com',
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
              Container(
                padding: EdgeInsets.only(left: 20.0, right: 20.0),
                margin: EdgeInsets.only(top: 25.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      'Password',
                      style: TextStyle(
                        color: Colors.black26,
                        fontSize: 15.0,
                      ),
                    ),
                    // Text(
                    //   'Forgot Password?',
                    //   style: TextStyle(
                    //     color: Colors.black54,
                    //     fontSize: 15.0,
                    //   ),
                    // ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.only(left: 20.0, right: 20.0),
                margin: EdgeInsets.only(bottom: 10.0),
                child: TextField(
                  controller: passwordFieldController,
                  obscureText: true,
                  decoration: InputDecoration(
                    hintText: '•••••••••',
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
                  onPressed: _isLoading ? null : _handleLogin,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  color: Theme.of(context).accentColor,
                  elevation: 3.0,
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Text(
                      _isLoading ? 'Please wait...' : 'Login',
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
                child: Text(
                  'New to river?  ',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black26,
                    fontSize: 15.0,
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(
                  top: 10.0,
                  // left: 35.0,
                  bottom: 40.0,
                ),
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SignUp()),
                    );
                  },
                  child: Text(
                    'Create Account Here',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Theme.of(context).accentColor,
                      fontSize: 16.0,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _handleLogin() async {
    if (email == "") {
      _showErrorAlert("Email field is empty");
    } else if (!email.contains('@') || !email.contains('.')) {
      _showErrorAlert("Email is invalid");
    } else if (password == "") {
      _showErrorAlert("Password field is empty");
    } else {
      var data = {
        "email": email,
        "password": password,
        "app_token": deviceToken,
      };

      setState(() {
        _isLoading = true;
      });

      var res = await CallApi().postData(data, 'api/login');

      var body = json.decode(res.body);
      print(body);

      if (res.statusCode == 200) {
        //print(user['id']);
        //print(body['token']);
        SharedPreferences localStorage = await SharedPreferences.getInstance();
        localStorage.setString('user', json.encode(body['user']));
        setState(() {
          _isLoading = false;
        });
        _showLoginAlert();
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => HomePage(0)));
      } else {
        setState(() {
          _showErrorAlert(body['message']);
          _isLoading = false;
        });
      }
    }
  }

  _showLoginAlert() {
    Fluttertoast.showToast(
        msg: "Logged in successfully!",
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
