import 'dart:convert';

import 'package:ecommerce_app/API/CallAPI.dart';
import 'package:ecommerce_app/screens/webview.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../main.dart';
import '../screens/product_sale.dart';
import 'package:flutter/material.dart';

class Deposit extends StatefulWidget {
  final newProduct;

  Deposit(this.newProduct);

  @override
  _DepositState createState() => _DepositState();
}

class _DepositState extends State<Deposit> {
  double percentage = 0.0, deposit = 0.0, depoAmt = 0.0;
  bool _isLoading = false, isDone = false;
  var userInfo, body;

  @override
  void initState() {
    _getUserInfo();
    String amt = widget.newProduct.price;
    depoAmt = double.parse(amt);
    var depo = widget.newProduct.deposite;
    print(depo);
    if (depo != null) {
      deposit = double.parse(widget.newProduct.deposite.toString());
      // percentage = (deposit * depoAmt) / 100.0;
      // depoAmt = depoAmt - percentage;
      // print(percentage);
      // print(depoAmt);
    }

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
      _countProductClick(userInfo);
      print(userInfo);
    }
  }

  Future<void> _countProductClick(userInfo) async {
    var res =
        await CallApi().getData('api/productViewCount/${widget.newProduct.id}');
    body = json.decode(res.body);

    print("body");
    print(body);

    if (!mounted) return;
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Back to Submit product',
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
      body: Container(
        color: Colors.white,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(left: 15, top: 5, bottom: 20),
                child: Text(
                  widget.newProduct.productName,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 22,
                  ),
                ),
              ),
              Stack(
                children: <Widget>[
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 250,
                    child: Image.network(
                      'http://nasuha.appifylab.com/' + widget.newProduct.image,
                      //fit: BoxFit.fill,
                    ),
                  ),
                  Positioned(
                      left: MediaQuery.of(context).size.width - 50,
                      child: IconButton(
                          onPressed: () {},
                          icon: Icon(Icons.crop_free, color: Colors.white)))
                ],
              ),
              Container(
                padding: EdgeInsets.all(15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(widget.newProduct.productName,
                        style: TextStyle(
                          color: Colors.black87,
                          fontSize: 18,
                        )
                        // fontWeight: FontWeight.w500),
                        ),
                    Text(
                      '\$${widget.newProduct.price}',
                      style: TextStyle(
                        color: Colors.black45,
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.only(left: 15, right: 15, top: 10),
                child: Text(
                  widget.newProduct.description,
                  style: TextStyle(color: Colors.black87, fontSize: 14),
                ),
              ),
              Container(
                margin: EdgeInsets.only(
                    right: 15.0, left: 15.0, top: 20.0, bottom: 35.0),
                child: RaisedButton(
                  onPressed: () {
                    if (isDone == true) {
                      //_handleSubmit();
                      null;
                    } else if (_isLoading == false) {
                      _handleSubmit();
                    }
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(builder: (context) => Webview()),
                    // );
                  },
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  color: _isLoading || isDone
                      ? Colors.grey
                      : Theme.of(context).accentColor,
                  elevation: 3.0,
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Text(
                      isDone
                          ? 'Order Completed'
                          : _isLoading
                              ? 'Please wait...'
                              : widget.newProduct.deposite == null ||
                                      widget.newProduct.deposite == 0
                                  ? 'Make \$0 Deposit'
                                  : 'Make \$${widget.newProduct.deposite} Deposit',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w300,
                        fontSize: 18.0,
                      ),
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

  void _handleSubmit() async {
    var data = {
      "sellerId": widget.newProduct.sellerId,
      "buyerId": userInfo['id'],
      "productId": widget.newProduct.id,
      "totalAmount": widget.newProduct.price,
      "depositAmount": deposit,
    };
    print(data);

    setState(() {
      _isLoading = true;
    });

    var res = await CallApi().postData(data, 'api/storeOrder');

    body = json.decode(res.body);
    print(body);

    if (res.statusCode == 200) {
      //print(user['id']);
      //print(body['token']);
      setState(() {
        _isLoading = false;
        isDone = true;
        print(body['order']['id']);
      });
      //_showRegisterAlert("URL submitted successfully!");
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => Webview(body['order']['id'])));
    } else {
      setState(() {
        _showErrorAlert("Something went wrong");
        _isLoading = false;
      });
    }
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
}
