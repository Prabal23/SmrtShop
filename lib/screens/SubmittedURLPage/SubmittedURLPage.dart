import 'dart:convert';

import 'package:ecommerce_app/API/CallAPI.dart';
import 'package:ecommerce_app/Models/SubmittedURLModel/SubmittedURLModel.dart';
import 'package:ecommerce_app/main.dart';
import 'package:ecommerce_app/screens/ProductWeb/ProductWeb.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../deposit.dart';

class SubmittedURLPage extends StatefulWidget {
  @override
  _SubmittedURLPageState createState() => _SubmittedURLPageState();
}

class _SubmittedURLPageState extends State<SubmittedURLPage> {
  var productList = [
    {
      "name": "Macbook Pro",
      "picture": "assets/images/grid_img1.jpg",
      "price": 85,
    },
    {
      "name": "Apple Watch",
      "picture": "assets/images/grid_img2.jpg",
      "price": 50,
    },
    {
      "name": "AirPods",
      "picture": "assets/images/grid_img3.png",
      "price": 85,
    },
    {
      "name": "Laptop Bag",
      "picture": "assets/images/grid_img4.jpg",
      "price": 50,
    },
    {
      "name": "HomePod",
      "picture": "assets/images/grid_img5.jpg",
      "price": 85,
    },
    {
      "name": "Bluetooth Speaker",
      "picture": "assets/images/grid_img6.jpg",
      "price": 50,
    },
  ];
  var body, newProduct, userInfo;
  bool _isLoading = true;

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
        await CallApi().getData('api/showUserProductUrl/${userInfo['id']}');
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
    var newProductList = SubmittedURLModel.fromJson(body);
    if (!mounted) return;
    setState(() {
      newProduct = newProductList.productUrl;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _isLoading
          ? Container(child: Center(child: CircularProgressIndicator()))
          : newProduct.length == 0
              ? Center(
                  child: Container(
                    child: Text("No submitted product yet!"),
                  ),
                )
              : Container(
                  padding: EdgeInsets.only(left: 15, right: 15),
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: newProduct.length,
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      ProductWeb(newProduct[index].url)));
                        },
                        child: Container(
                          child: Column(
                            children: <Widget>[
                              Container(
                                width: MediaQuery.of(context).size.width,
                                padding: EdgeInsets.all(15),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey[300],
                                        blurRadius: 12,
                                      )
                                    ],
                                    borderRadius: BorderRadius.circular(10)),
                                alignment: Alignment.centerLeft,
                                margin: EdgeInsets.only(top: 5.0, bottom: 5.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Text(
                                      "#${index + 1}",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15),
                                    ),
                                    Expanded(
                                      child: Container(
                                        child: Text(
                                          newProduct[index].url,
                                          textAlign: TextAlign.end,
                                          style: TextStyle(
                                              color: appBlueShade,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 15),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
    );
  }
}
