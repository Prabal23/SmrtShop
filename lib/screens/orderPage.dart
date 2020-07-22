import 'dart:convert';

import 'package:ecommerce_app/API/CallAPI.dart';
import 'package:ecommerce_app/Models/OrderModel/OrderModel.dart';
import 'package:ecommerce_app/Models/ProductModel/ProductModel.dart';
import 'package:ecommerce_app/screens/home_page.dart';
import 'package:ecommerce_app/screens/sign_up.dart';
import 'package:ecommerce_app/screens/submit_product.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import './deposit.dart';
import './sign_in.dart';

class OrderPage extends StatefulWidget {
  @override
  _OrderPageState createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
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
    var res = await CallApi().getData('api/showOrderList/${userInfo['id']}');
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
    var newProductList = OrderModel.fromJson(body);
    if (!mounted) return;
    setState(() {
      newProduct = newProductList.allOrders;
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => HomePage(2)));
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Order List',
            style: TextStyle(
                color: Colors.black54,
                fontSize: 14,
                fontWeight: FontWeight.w400),
          ),
          backgroundColor: Colors.white,
          elevation: 0,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => HomePage(2)));
            },
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.black54,
              size: 18,
            ),
          ),
        ),
        body: Container(
          padding: EdgeInsets.only(top: 20.0, left: 10.0, right: 10.0),
          color: Colors.white,
          child: Column(
            children: <Widget>[
              _isLoading
                  ? Expanded(
                      child: Container(
                          child: Center(child: CircularProgressIndicator())))
                  : Expanded(
                      child: Container(
                        child: ListView.builder(
                          //shrinkWrap: true,
                          itemCount: newProduct.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Column(
                              children: <Widget>[
                                // Flexible(
                                //   child:
                                Container(
                                  padding: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey[300],
                                          blurRadius: 17,
                                        )
                                      ],
                                      borderRadius: BorderRadius.circular(10)),
                                  alignment: Alignment.centerLeft,
                                  margin:
                                      EdgeInsets.only(top: 5.0, bottom: 5.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        "#${index + 1}",
                                        style: TextStyle(
                                          color: Theme.of(context).primaryColor,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16.0,
                                        ),
                                      ),
                                      Text(
                                        "Total Amount : " +
                                            newProduct[index].depositAmount,
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.normal,
                                          fontSize: 16.0,
                                        ),
                                      ),
                                      SizedBox(height: 3),
                                      Text(
                                        "Status : " + newProduct[index].status,
                                        style: TextStyle(
                                          color: Colors.grey,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 13.0,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                // ),
                              ],
                            );
                          },
                        ),
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
