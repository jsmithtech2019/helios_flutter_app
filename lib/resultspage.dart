import 'package:flutter/material.dart';
class ResultsPage extends StatelessWidget {
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
                style: DefaultTextStyle.of(context).style.apply(fontSizeFactor: 3.0),
              ),
            ],
          ),
        ),
      ),
    );
  }
}