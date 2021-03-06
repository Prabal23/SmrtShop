import 'dart:convert';

import 'package:ecommerce_app/API/CallAPI.dart';
import 'package:ecommerce_app/Models/ProductModel/ProductModel.dart';
import 'package:ecommerce_app/Models/ProductPromoModel/ProductPromoModel.dart';
import 'package:ecommerce_app/main.dart';
import 'package:ecommerce_app/screens/DepositedProduct/DepositedProduct.dart';
import 'package:ecommerce_app/screens/ProductDepositDetails/ProductDepositDetails.dart';
import 'package:ecommerce_app/screens/SubmittedURLPage/SubmittedURLPage.dart';
import 'package:ecommerce_app/screens/deposit.dart';
import 'package:ecommerce_app/screens/profile.dart';
import 'package:ecommerce_app/screens/sign_up.dart';
import 'package:ecommerce_app/screens/submit_product.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyDeals extends StatefulWidget {
  @override
  _MyDealssState createState() => _MyDealssState();
}

class _MyDealssState extends State<MyDeals> {
  var body, newProduct, userInfo;
  bool _isLoading = true;
  TextEditingController search = new TextEditingController();
  String srcText = "";

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
      _showProductlist(userInfo);
      print(userInfo);
    }
  }

  Future<void> _showProductlist(userInfo) async {
    var res =
        await CallApi().getData('api/showOrderListWithPromo/${userInfo['id']}');
    body = json.decode(res.body);

    print(body);

    if (res.statusCode == 200) {
      _newProductlist();
    }
    if (!mounted) return;
    setState(() {
      _isLoading = false;
    });
  }

  void _newProductlist() {
    var newProductList = ProductPromoModel.fromJson(body);
    if (!mounted) return;
    setState(() {
      newProduct = newProductList.allOrders;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        title: Text(
          'My Deals',
          style: TextStyle(
              color: Colors.black54, fontSize: 17, fontWeight: FontWeight.bold),
        ),
      ),
      body: _isLoading
          ? Container(child: Center(child: CircularProgressIndicator()))
          : newProduct.length == 0
              ? Center(
                  child: Container(
                    child: Text("No deposit yet!"),
                  ),
                )
              : Container(
                  padding: EdgeInsets.only(left: 15, right: 15),
                  child: GridView.builder(
                    shrinkWrap: true,
                    itemCount: newProduct.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 4.0,
                    ),
                    itemBuilder: (BuildContext context, int index) {
                      return Column(
                        children: <Widget>[
                          Flexible(
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          ProductDepositDetails(
                                              newProduct[index], 2)),
                                );
                              },
                              child: Container(
                                height: MediaQuery.of(context).size.height,
                                width: MediaQuery.of(context).size.width,
                                child: Image.network(
                                  'http://nasuha.appifylab.com/' +
                                      newProduct[index].productwithpromo.image,
                                  //fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                          // Flexible(
                          //   child:
                          Container(
                            alignment: Alignment.centerLeft,
                            margin: EdgeInsets.only(top: 10.0, bottom: 15.0),
                            child: Text(
                                newProduct[index].productwithpromo.productName),
                          ),
                          // ),
                        ],
                      );
                    },
                  ),
                ),
    );
  }
}
