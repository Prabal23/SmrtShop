import 'dart:convert';

import 'package:ecommerce_app/API/CallAPI.dart';
import 'package:ecommerce_app/Models/ProductModel/ProductModel.dart';
import 'package:ecommerce_app/screens/profile.dart';
import 'package:ecommerce_app/screens/sign_up.dart';
import 'package:ecommerce_app/screens/submit_product.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../main.dart';
import './deposit.dart';
import './sign_in.dart';

class SearchProducts extends StatefulWidget {
  @override
  _SearchProductsState createState() => _SearchProductsState();
}

class _SearchProductsState extends State<SearchProducts> {
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
  var body, newProduct;
  bool _isLoading = true;
  TextEditingController search = new TextEditingController();
  String srcText = "";

  @override
  void initState() {
    _showProductlist(srcText);
    super.initState();
  }

  Future<void> _showProductlist(srcText) async {
    var res = await CallApi().getData('api/showProducts?str=$srcText');
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
    var newProductList = ProductModel.fromJson(body);
    if (!mounted) return;
    setState(() {
      newProduct = newProductList.product;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(top: 20.0, left: 10.0, right: 10.0),
        color: Colors.white,
        child: Column(
          children: <Widget>[
            Container(
              child: Row(
                children: <Widget>[
                  Flexible(
                    child: Container(
                      child: TextField(
                        controller: search,
                        autofocus: false,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Search products',
                          hintStyle: TextStyle(color: Colors.black26),
                          prefixIcon: Icon(
                            Icons.search,
                            color: Colors.black54,
                          ),
                          suffixIcon: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Profile()));
                            },
                            child: Container(
                              child: Icon(
                                Icons.account_circle,
                                color: Colors.black87,
                                size: 30,
                              ),
                            ),
                          ),
                        ),
                        onChanged: (value) {
                          _showProductlist(value);
                        },
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      logout();
                    },
                    child: Container(
                        padding: EdgeInsets.all(10),
                        child: Icon(Icons.exit_to_app)),
                  )
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 20.0, left: 5.0, bottom: 15.0),
              alignment: Alignment.centerLeft,
              child: Text(
                'Trending products',
                // textAlign: TextAlign.left,
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w400,
                  color: Colors.black87,
                ),
              ),
            ),
            _isLoading
                ? Expanded(
                    child: Container(
                        child: Center(child: CircularProgressIndicator())))
                : newProduct == null
                    ? Container()
                    : Expanded(
                        child: Container(
                          child: GridView.builder(
                            shrinkWrap: true,
                            itemCount: newProduct.length,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
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
                                                  Deposit(newProduct[index])),
                                        );
                                      },
                                      child: Container(
                                        height:
                                            MediaQuery.of(context).size.height,
                                        width:
                                            MediaQuery.of(context).size.width,
                                        child: Image.network(
                                          'http://nasuha.appifylab.com/' +
                                              newProduct[index].image,
                                          //fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                  ),
                                  // Flexible(
                                  //   child:
                                  Container(
                                    alignment: Alignment.centerLeft,
                                    margin: EdgeInsets.only(
                                        top: 10.0, bottom: 15.0),
                                    child: Text(newProduct[index].productName),
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
    );
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
}
