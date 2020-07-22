import 'package:flutter/material.dart';

class ProductSale extends StatefulWidget {
  @override
  _ProductSaleState createState() => _ProductSaleState();
}

class _ProductSaleState extends State<ProductSale> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Back to Submit product',
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
                padding: EdgeInsets.only(left:15, top: 5, bottom: 20),
                child: Text(
                  'MacBook',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 22,),
                ),
              ),
              Stack(
                children: <Widget>[
                  Container(
                    child: Image.asset(
                      'assets/images/macbook.jpg',
                      fit: BoxFit.cover,
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'MacBook',
                      style: TextStyle(
                          color: Colors.black87,
                          fontSize: 18,)
                          // fontWeight: FontWeight.w500),
                    ),
                    Column(
                     crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.only(bottom: 2),
                          child: Text(
                            '\$3000.00',
                            style: TextStyle(
                              color: Theme.of(context).accentColor,
                              fontSize: 18,
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(left:10, right: 10, top: 2, bottom: 2),
                          decoration: BoxDecoration(
                            color: Colors.red,
                             borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          ) ,
                          
                          child: Text(
                            '10% off',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.only(left: 15, right: 15, top: 5),
                child: Text(
                  'The MacBook is a discontinued Macintosh portable computer developed and sold by Apple Inc. In Apple\'s product line it was considered a more premium device compared to the MacBook Air, and sat below the performance range MacBook Pro. It was introduced in March 2015.',
                  style: TextStyle(color: Colors.black87, fontSize: 14),
                ),
              ),
              Container(
                padding:
                    EdgeInsets.only(left: 15, right: 15, top: 20, bottom: 15),
                child: Text(
                  'MacOS is the operating system that powers every Mac. It lets you do thing you simply can\'t with other computers. That\'s because it\'s designed specifically for the hardware it runs on - and vice versa.',
                  style: TextStyle(color: Colors.black87, fontSize: 14),
                ),
              ),
              Container(
                margin: EdgeInsets.only(
                    right: 15.0, left: 15.0, top: 20.0, bottom: 35.0),
                child: RaisedButton(
                  onPressed: () {},
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  color: Theme.of(context).primaryColor,
                  elevation: 3.0,
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Text(
                      'Go to Deals',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w300,
                        fontSize: 18.0,
                      ),
                    ),
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
