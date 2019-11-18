import 'package:flutter/material.dart';
import 'package:HITCH/contactpage.dart';

class TestingPage extends StatelessWidget {
  @override
  Widget build (BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("H.I.T.C.H. Testing"),
      ),
      body: Column(
        children: <Widget>[
          new Text(""),
          new Text("Insert Customer Details:",
            style: DefaultTextStyle.of(context).style.apply(fontSizeFactor: 2.0),
          ),
          new Text(""),
          new TextField(
            decoration: InputDecoration(
              hintText: '    Customer Name'
            ),
          ),
          new TextField(
            decoration: InputDecoration(
                hintText: '    Customer Phone Number'
            ),
          ),
          new TextField(
            decoration: InputDecoration(
                hintText: '    Customer Truck License Plate'
            ),
          ),
          new TextField(
            decoration: InputDecoration(
                hintText: '    Trailer License Plate'
            ),
          ),
          new Text(""),
          new SizedBox(
            width: 200,
            height: 50,
            child: RaisedButton(
              child: Text("Begin Testing!"),
              onPressed: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ContactPage()),
                );
              },
            ),
          ),
        ],
      )
    );
  }
}