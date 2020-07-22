import 'dart:convert';

import 'package:ecommerce_app/API/CallAPI.dart';
import 'package:ecommerce_app/screens/orderPage.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../main.dart';
import './sign_in.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  TextEditingController emailFieldController = new TextEditingController();
  TextEditingController passwordFieldController = new TextEditingController();
  TextEditingController nameFieldController = new TextEditingController();
  TextEditingController addressFieldController = new TextEditingController();
  TextEditingController phoneFieldController = new TextEditingController();

  bool _isLoading = false;
  var userInfo, body;
  String name = "", address = "", email = "", phone = "", password = "";

  @override
  void initState() {
    _getUserInfo();
    super.initState();
  }

  void _getUserInfo() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var user = localStorage.getString('user');
    var users = json.decode(user);
    if (users != null) {
      setState(() {
        userInfo = users;
        nameFieldController.text = userInfo['name'];
        name = userInfo['name'];
        addressFieldController.text = userInfo['address'];
        address = userInfo['address'];
        emailFieldController.text = userInfo['email'];
        email = userInfo['email'];
        phoneFieldController.text = userInfo['phone'];
        phone = userInfo['phone'];
      });

      print(userInfo);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellowAccent[50],
      appBar: AppBar(
        //automaticallyImplyLeading: false,
        title: Text(
          'Profile',
          style: TextStyle(
              color: Colors.black54, fontSize: 14, fontWeight: FontWeight.w400),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.black54,
            size: 18,
          ),
        ),
        actions: <Widget>[
          GestureDetector(
            onTap: () {
              logout();
            },
            child: Container(
                padding: EdgeInsets.all(20), child: Icon(Icons.exit_to_app)),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
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
            //     keyboardType: TextInputType.emailAddress,
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
                    _isLoading ? 'Please wait...' : 'Change Email',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w300,
                      fontSize: 16.0,
                    ),
                  ),
                ),
              ),
            ),
            // Container(
            //   margin: EdgeInsets.only(
            //       right: 20.0, left: 20.0, top: 0.0, bottom: 25.0),
            //   child: RaisedButton(
            //     onPressed: () {
            //       Navigator.push(context,
            //           MaterialPageRoute(builder: (context) => OrderPage()));
            //     },
            //     shape: RoundedRectangleBorder(
            //       borderRadius: BorderRadius.circular(8.0),
            //     ),
            //     color: Colors.white,
            //     elevation: 3.0,
            //     child: Padding(
            //       padding: const EdgeInsets.all(15.0),
            //       child: Text(
            //         'Order List',
            //         style: TextStyle(
            //           color: Theme.of(context).primaryColor,
            //           fontWeight: FontWeight.bold,
            //           fontSize: 16.0,
            //         ),
            //       ),
            //     ),
            //   ),
            // ),
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
    } else {
      var data = {
        "id": userInfo['id'],
        // "name": name,
        // "address": address,
        "email": email,
        //"phone": phone
      };

      setState(() {
        _isLoading = true;
      });

      var res = await CallApi().postData(data, 'api/editUser');

      body = json.decode(res.body);
      print(body);

      if (res.statusCode == 200) {
        //print(user['id']);
        //print(body['token']);
        setState(() {
          _isLoading = false;
          userInfo['name'] = name;
          userInfo['address'] = address;
          userInfo['email'] = email;
          userInfo['phone'] = phone;
          storeData();
        });
        _showRegisterAlert("Profile updated successfully!");
        // Navigator.push(
        //     context, MaterialPageRoute(builder: (context) => SignIn()));
      } else {
        setState(() {
          _showErrorAlert("Something went wrong");
          _isLoading = false;
        });
      }
    }
  }

  Future<void> storeData() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    localStorage.setString('user', json.encode(userInfo));
  }

  _showRegisterAlert(String msg) {
    Fluttertoast.showToast(
        msg: msg,
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

  Future logout() async {
    Navigator.of(context).pop();
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    localStorage.remove('user');
    _showRegisterAlert("Logged out successfully!");
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SignIn()),
    );
  }
}
