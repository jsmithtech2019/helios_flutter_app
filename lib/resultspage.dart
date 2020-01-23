import 'package:flutter/material.dart';
import 'package:HITCH/datastorage.dart';

class ResultsPage extends StatelessWidget {
  final CustomerData customerData;

  ResultsPage({this.customerData});

  @override
  Widget build (BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Test Results"),
      ),
      body: Center(
        child: Container(
          child: Column(
            children: <Widget>[
              Text("Results Text",
                style: DefaultTextStyle.of(context).style.apply(fontSizeFactor: 1.0),
              ),
            ],
          ),
        ),
      ),
    );
  }
}