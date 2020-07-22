import 'package:ecommerce_app/main.dart';
import 'package:ecommerce_app/screens/MyDeals/MyDeals.dart';
import 'package:ecommerce_app/screens/MyList/MyList.dart';
import 'package:ecommerce_app/screens/orderPage.dart';
import 'package:ecommerce_app/screens/profile.dart';
import 'package:flutter/services.dart';

import './search_products.dart';
import 'package:flutter/material.dart';
import './sign_in.dart';
import './sign_up.dart';
import './submit_product.dart';

class HomePage extends StatefulWidget {
  final index;
  HomePage(this.index);
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentTabIndex = 0;

  @override
  initState() {
    setState(() {
      currentTabIndex = widget.index;
    });
    super.initState();
  }

  onTapped(int index) {
    setState(() {
      currentTabIndex = index;
    });
  }

  final tabs = [
    SearchProducts(),
    SubmitProduct(),
    MyList(),
    MyDeals(),
  ];

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        SystemChannels.platform.invokeMethod('SystemNavigator.pop');
      },
      child: SafeArea(
        child: Scaffold(
          body: tabs[currentTabIndex],
          bottomNavigationBar: BottomNavigationBar(
              currentIndex: currentTabIndex,
              //onTap: onTapped,
              backgroundColor: Colors.white,
              type: BottomNavigationBarType.fixed,
              selectedItemColor: appBlueShade,
              unselectedItemColor: Colors.grey,
              onTap: (int index) {
                setState(() {
                  currentTabIndex = index;
                });
              },
              items: [
                BottomNavigationBarItem(
                    icon: Icon(Icons.home),
                    title: Text(
                      "Browse",
                      style: TextStyle(fontSize: 11),
                    )),
                BottomNavigationBarItem(
                    icon: Icon(Icons.search),
                    title: Text(
                      "Submit Product",
                      style: TextStyle(fontSize: 11),
                    )),
                BottomNavigationBarItem(
                    icon: Icon(Icons.list),
                    title: Text(
                      "My List",
                      style: TextStyle(fontSize: 11),
                    )),
                BottomNavigationBarItem(
                    icon: Icon(Icons.label_important),
                    title: Text(
                      "My Deals",
                      style: TextStyle(fontSize: 11),
                    ))
              ]),
        ),
      ),
    );
  }
}
