import 'dart:async';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ProductWeb extends StatefulWidget {
  final url;
  ProductWeb(this.url);
  @override
  _ProductWebState createState() => _ProductWebState();
}

class _ProductWebState extends State<ProductWeb> {
  final Completer<WebViewController> _controller =
      Completer<WebViewController>();

  bool _isLoading = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '${widget.url}',
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
            initialUrl: '${widget.url}',
            javascriptMode: JavascriptMode.unrestricted,
            onWebViewCreated: (WebViewController webViewController) {
              _controller.complete(webViewController);
              print(webViewController.currentUrl());
            },
            onPageFinished: (value) {
              setState(() {
                print(value);
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
