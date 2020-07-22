import 'dart:convert';

import 'package:ecommerce_app/API/CallAPI.dart';
import 'package:ecommerce_app/main.dart';
import 'package:ecommerce_app/screens/home_page.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SubmitProduct extends StatefulWidget {
  @override
  _SubmitProductState createState() => _SubmitProductState();
}

class _SubmitProductState extends State<SubmitProduct> {
  TextEditingController submitFieldController = new TextEditingController();
  bool _isLoading = false;
  var userInfo, body;
  String url = "";

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

  Future<void> prevURL(url) async {
    var res = await CallApi().prevURL(url);
    body = json.decode(res.body);

    print(body);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            color: Colors.white,
            padding: EdgeInsets.all(20.0),
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(left: 15.0),
                      child: Icon(
                        Icons.ac_unit,
                        color: Colors.yellow,
                        size: 40,
                      ),
                    ),
                    Container(
                      child: Text(
                        "smrtshop",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 40,
                            fontWeight: FontWeight.bold,
                            shadows: [
                              Shadow(
                                blurRadius: 10.0,
                                color: Colors.black87,
                                offset: Offset(2.0, 3.0),
                              ),
                            ]),
                      ),
                    ),
                  ],
                ),
                Container(
                  margin: EdgeInsets.only(left: 20.0, top: 25.0, bottom: 30.0),
                  child: Text(
                    "Submit Product",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 25,
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.topLeft,
                  // margin: EdgeInsets.only(left: 20.0),
                  child: Text(
                    "Enter your product URL below",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 25, bottom: 10),
                  child: TextField(
                    controller: submitFieldController,
                    decoration: InputDecoration(
                      hintText: 'http://www.example product.com',
                      // contentPadding: EdgeInsets.all(15.0),
                      focusedBorder: OutlineInputBorder(
                          // borderSide:
                          // /BorderSide(color: Theme.of(context).primaryColor),
                          ),
                      enabledBorder: OutlineInputBorder(
                          // borderSide:
                          //     BorderSide(color: Theme.of(context).primaryColor),
                          ),
                      disabledBorder: OutlineInputBorder(
                          // borderSide:
                          //     BorderSide(color: Theme.of(context).primaryColor),
                          ),
                    ),
                    onChanged: (value) {
                      url = value;
                      //prevURL(url);
                    },
                  ),
                ),
                // Container(
                //   width: MediaQuery.of(context).size.width,
                //   padding: EdgeInsets.all(15),
                //   decoration: BoxDecoration(
                //       color: Colors.white,
                //       boxShadow: [
                //         BoxShadow(
                //           color: Colors.grey[300],
                //           blurRadius: 12,
                //         )
                //       ],
                //       borderRadius: BorderRadius.circular(10)),
                //   child: Column(
                //       crossAxisAlignment: CrossAxisAlignment.start,
                //       children: [
                //         Container(
                //           alignment: Alignment.center,
                //           child: Image.network('${body['image']}',
                //               width: MediaQuery.of(context).size.width,
                //               height: 200,
                //               fit: BoxFit.fill),
                //         ),
                //         Container(
                //             margin: EdgeInsets.only(top: 10),
                //             child: Text(
                //               "${body['title']}",
                //               maxLines: 1,
                //               overflow: TextOverflow.ellipsis,
                //               style: TextStyle(fontWeight: FontWeight.bold),
                //             )),
                //         Container(
                //             margin: EdgeInsets.only(top: 10),
                //             child: Text(
                //               "${body['description']}",
                //               maxLines: 3,
                //               overflow: TextOverflow.ellipsis,
                //               style: TextStyle(
                //                   fontWeight: FontWeight.normal, fontSize: 12),
                //             ))
                //       ]),
                // ),
                Container(
                  alignment: Alignment.centerLeft,
                  margin: EdgeInsets.only(top: 25.0, bottom: 25.0),
                  child: RaisedButton(
                    onPressed: () {
                      if (_isLoading == false) {
                        _handleSubmit();
                      }
                    },
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    color: _isLoading
                        ? Colors.grey
                        : Theme.of(context).accentColor,
                    elevation: 3.0,
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Text(
                        _isLoading ? 'Please wait...' : 'Submit Product',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w300,
                          fontSize: 16.0,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _handleSubmit() async {
    if (url == "") {
      _showErrorAlert("URL field is empty");
    } else {
      var data = {
        "userId": userInfo['id'],
        "url": url,
        "deal_percentage": null,
        "promo_code": null,
      };

      setState(() {
        _isLoading = true;
      });

      var res = await CallApi().postData(data, 'api/storeProductUrl');

      body = json.decode(res.body);
      print(body);

      if (res.statusCode == 200) {
        //print(user['id']);
        //print(body['token']);
        setState(() {
          _isLoading = false;
          submitFieldController.text = "";
          url = "";
        });
        _showRegisterAlert("URL submitted successfully!");
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => HomePage(2)));
      } else {
        setState(() {
          _showErrorAlert("Something went wrong");
          _isLoading = false;
        });
      }
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
