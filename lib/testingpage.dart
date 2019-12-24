import 'package:flutter/material.dart';

class TestingPage extends StatelessWidget {
  @override
  Widget build (BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Testing Page"),
      ),
      body: Center(
        child: Container(
          child: Column(
            children: <Widget>[
              Text("Testing Text",
                style: DefaultTextStyle.of(context).style.apply(fontSizeFactor: 3.0),
              ),
            ],
          ),
        ),
      ),
    );
  }
}