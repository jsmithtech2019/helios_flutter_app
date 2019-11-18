import 'package:flutter/material.dart';
class HelpPage extends StatelessWidget {
  @override
  Widget build (BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          title: new Text("Help Page"),
        ),
        body: Text("Help Page!"),
    );
  }
}