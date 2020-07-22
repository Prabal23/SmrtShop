import 'dart:convert';

import 'package:ecommerce_app/API/CallAPI.dart';
import 'package:ecommerce_app/Models/MyListModel/MyListModel.dart';
import 'package:ecommerce_app/Models/OrderModel/OrderModel.dart';
import 'package:ecommerce_app/Models/ProductModel/ProductModel.dart';
import 'package:ecommerce_app/Models/ProductPromoModel/ProductPromoModel.dart';
import 'package:ecommerce_app/Models/SubmittedURLModel/SubmittedURLModel.dart';
import 'package:ecommerce_app/screens/ProductDepositDetails/ProductDepositDetails.dart';
import 'package:ecommerce_app/screens/orderPage.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../deposit.dart';

class DepositedProduct extends StatefulWidget {
  @override
  _DepositedProductState createState() => _DepositedProductState();
}

class _DepositedProductState extends State<DepositedProduct> {
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
        await CallApi().getData('api/showOrderListWithoutPromo/${userInfo['id']}');
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
    var newProductList = MyListModel.fromJson(body);
    if (!mounted) return;
    setState(() {
      newProduct = newProductList.dpositedProduct;
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
                                          ProductDepositDetails(newProduct[index], 1)),
                                );
                              },
                              child: Container(
                                height: MediaQuery.of(context).size.height,
                                width: MediaQuery.of(context).size.width,
                                child: Image.network(
                                  'http://nasuha.appifylab.com/' +
                                      newProduct[index].product.image,
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
                                newProduct[index].product.productName),
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
