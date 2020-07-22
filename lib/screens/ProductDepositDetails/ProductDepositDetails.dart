import 'dart:convert';

import 'package:ecommerce_app/API/CallAPI.dart';
import 'package:ecommerce_app/screens/ProductWeb/ProductWeb.dart';
import 'package:ecommerce_app/screens/webview.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:flutter/material.dart';

import '../../main.dart';

class ProductDepositDetails extends StatefulWidget {
  final newProduct;
  final number;

  ProductDepositDetails(this.newProduct, this.number);

  @override
  _ProductDepositDetailsState createState() => _ProductDepositDetailsState();
}

class _ProductDepositDetailsState extends State<ProductDepositDetails> {
  double percentage = 0.0, deposit = 0.0, depoAmt = 0.0;
  bool _isLoading = false;
  var userInfo, body;

  @override
  void initState() {
    _getUserInfo();
    String amt = widget.number == 1
        ? widget.newProduct.product.price
        : widget.newProduct.productwithpromo.price;
    depoAmt = double.parse(amt);
    var depo = widget.newProduct.depositAmount;
    print(depo);
    if (depo != null) {
      deposit = double.parse(widget.newProduct.depositAmount.toString());
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
    body = res.body;

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
          widget.number == 1
              ? 'Back to Deposited product'
              : 'Back to My Deals',
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
                  widget.number == 1
                      ? widget.newProduct.product.productName
                      : widget.newProduct.productwithpromo.productName,
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
                      widget.number == 1
                          ? 'http://nasuha.appifylab.com/' +
                              widget.newProduct.product.image
                          : 'http://nasuha.appifylab.com/' +
                              widget.newProduct.productwithpromo.image,
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
                    Text(
                        widget.number == 1
                            ? widget.newProduct.product.productName
                            : widget.newProduct.productwithpromo.productName,
                        style: TextStyle(
                          color: Colors.black87,
                          fontSize: 18,
                        )
                        // fontWeight: FontWeight.w500),
                        ),
                    Text(
                      widget.number == 1
                          ? '\$${widget.newProduct.product.price}'
                          : '\$${widget.newProduct.productwithpromo.price}',
                      style: TextStyle(
                        color: Colors.black45,
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.only(left: 15, right: 15, top: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                      child: Row(
                        children: <Widget>[
                          Container(
                            child: Text(
                              "Product URL: ",
                              style: TextStyle(
                                  color: Colors.black87, fontSize: 14),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ProductWeb(widget
                                          .newProduct
                                          .productwithpromo
                                          .product_url)));
                            },
                            child: Container(
                              padding:
                                  EdgeInsets.only(top: 5, bottom: 5, right: 5),
                              child: Text(
                                //widget.newProduct.productwithpromo.product_url,
                                widget.number == 1
                                    ? '${widget.newProduct.product.product_url}'
                                    : '${widget.newProduct.productwithpromo.product_url}',
                                style: TextStyle(
                                    color: appBlueShade,
                                    fontSize: 14,
                                    decoration: TextDecoration.underline,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              widget.number == 1
                  ? Container()
                  : Container(
                      padding: EdgeInsets.only(left: 15, right: 15, top: 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Container(
                            child: Row(
                              children: <Widget>[
                                Container(
                                  child: Text(
                                    "Promo Code: ",
                                    style: TextStyle(
                                        color: Colors.black87, fontSize: 14),
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.only(
                                      top: 5, bottom: 5, right: 5),
                                  child: Text(
                                    //widget.newProduct.productwithpromo.product_url,
                                    widget.number == 1
                                        ? '${widget.newProduct.product.offer_promo}'
                                        : '${widget.newProduct.productwithpromo.offer_promo}',
                                    style: TextStyle(
                                        color: Colors.grey,
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
              Container(
                padding: EdgeInsets.only(left: 15, right: 15, top: 10),
                child: Text(
                  widget.number == 1
                      ? widget.newProduct.product.description
                      : widget.newProduct.productwithpromo.description,
                  style: TextStyle(color: Colors.black87, fontSize: 14),
                ),
              ),
              // Container(
              //   margin: EdgeInsets.only(
              //       right: 15.0, left: 15.0, top: 20.0, bottom: 10.0),
              //   child: RaisedButton(
              //     onPressed: () {
              //       if (_isLoading == false) {
              //         _handleSubmit();
              //       }
              //       // Navigator.push(
              //       //   context,
              //       //   MaterialPageRoute(builder: (context) => Webview()),
              //       // );
              //     },
              //     shape: RoundedRectangleBorder(
              //       borderRadius: BorderRadius.circular(8.0),
              //     ),
              //     color:
              //         _isLoading ? Colors.grey : Theme.of(context).accentColor,
              //     elevation: 3.0,
              //     child: Padding(
              //       padding: const EdgeInsets.all(15.0),
              //       child: Text(
              //         _isLoading
              //             ? 'Please wait...'
              //             : widget.newProduct.depositAmount == null ||
              //                     widget.newProduct.depositAmount == 0
              //                 ? 'Make \$0 Deposit'
              //                 : 'Make \$${widget.newProduct.depositAmount} Deposit',
              //         style: TextStyle(
              //           color: Colors.white,
              //           fontWeight: FontWeight.w300,
              //           fontSize: 18.0,
              //         ),
              //       ),
              //     ),
              //   ),
              // ),
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
      "productId": widget.newProduct.productwithpromo.id,
      "totalAmount": widget.newProduct.productwithpromo.price,
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
