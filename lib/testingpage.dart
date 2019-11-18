import 'package:flutter/material.dart';
class TestingPage extends StatelessWidget {
  @override
  Widget build (BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("H.I.T.C.H. Testing"),
      ),
      body: Column(
        children: <Widget>[
          new TextField(
            decoration: InputDecoration(
              hintText: 'Enter a search term'
            ),
          ),
          new Text("Testing Text"),
        ],
      )
    );
  }
}