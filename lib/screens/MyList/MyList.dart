import 'package:ecommerce_app/screens/DepositedProduct/DepositedProduct.dart';
import 'package:ecommerce_app/screens/SubmittedURLPage/SubmittedURLPage.dart';
import 'package:flutter/material.dart';

import '../../main.dart';

class MyList extends StatefulWidget {
  @override
  _MyListState createState() => _MyListState();
}

class _MyListState extends State<MyList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.white,
          title: Text(
            'My List',
            style: TextStyle(
                color: Colors.black54,
                fontSize: 17,
                fontWeight: FontWeight.bold),
          ),
        ),
        body: DefaultTabController(
          length: 2,
          child: Column(
            children: <Widget>[
              Container(
                child: new Material(
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.all(0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                    ),
                    child: new TabBar(
                      onTap: (index) {
                        print(index);
                      },
                      labelStyle:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                      tabs: [
                        new Tab(
                          text: "Deposited Product",
                        ),
                        new Tab(
                          text: "Submitted Product",
                        ),
                      ],
                      //isScrollable: true,
                      indicatorColor: appBlueShade,
                      unselectedLabelColor: Colors.black26,
                      unselectedLabelStyle:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                      indicator: UnderlineTabIndicator(
                        borderSide: BorderSide(width: 2.0, color: appBlueShade),
                      ),
                      labelColor: Colors.black,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: TabBarView(
                  children: <Widget>[
                    DepositedProduct(),
                    SubmittedURLPage(),
                  ],
                ),
              )
            ],
          ),
        ));
  }
}
