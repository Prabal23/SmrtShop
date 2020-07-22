import 'dart:async';
import 'dart:convert';

import 'package:ecommerce_app/screens/home_page.dart';
import 'package:ecommerce_app/screens/orderPage.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:webview_flutter/webview_flutter.dart';

class Webview extends StatefulWidget {
  final orderID;
  Webview(this.orderID);
  @override
  _WebviewState createState() => _WebviewState();
}

class _WebviewState extends State<Webview> {
  final Completer<WebViewController> _controller =
      Completer<WebViewController>();

  bool _isLoading = true;
  var userInfo, body;

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
      });

      print(userInfo);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Paypal Payment',
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
      ),
      body: Stack(
        children: <Widget>[
          WebView(
            initialUrl:
                'http://nasuha.appifylab.com/payment/add-funds/paypal/${widget.orderID}',
            javascriptMode: JavascriptMode.unrestricted,
            onWebViewCreated: (WebViewController webViewController) {
              _controller.complete(webViewController);
              print(webViewController.currentUrl());
            },
            onPageFinished: (value) {
              setState(() {
                print(value);
                if (value == "http://nasuha.appifylab.com/payment_success") {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => HomePage(0)));
                }if (value == "http://nasuha.appifylab.com/payment_failed") {
                  Navigator.pop(context);
                }
                _isLoading = false;
              });
            },
            onPageStarted: (value) {
              setState(() {
                _isLoading = true;
              });
            },
          ),
          _isLoading ? Center(child: CircularProgressIndicator()) : Container()
        ],
      ),
    );
  }
}
