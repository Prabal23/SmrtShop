import 'package:ecommerce_app/screens/home_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import './screens/deposit.dart';
import './screens/search_products.dart';
import 'package:flutter/material.dart';
import './screens/sign_up.dart';
import './screens/submit_product.dart';
import './screens/product_sale.dart';
import './screens/sign_in.dart';

Color appBlueShade = Color(0xFF04B2EF);
Color appGreenShade = Color(0xFF31BC74);

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  var userInfo, deviceToken;
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

  @override
  void initState() {
    _getUserInfo();
    _firebaseMessaging.getToken().then((token) async {
      print("Notification token");
      print(token);

      setState(() {
        deviceToken = token;
      });
    });
    super.initState();
  }

  void _getUserInfo() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var user = localStorage.getString('user');
    if (user != null) {
      setState(() {
        userInfo = user;
      });

      print(userInfo);
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: appBlueShade,
        accentColor: appGreenShade,
      ),
      home: userInfo == null ? SignIn() : HomePage(0),
      // home: SubmitProduct(),
      // home: SearchProducts(),
      // home: ProductSale(),
    );
  }
}
