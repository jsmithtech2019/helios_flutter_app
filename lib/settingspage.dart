import 'package:flutter/material.dart';

class SettingsPage extends StatelessWidget {
  @override
  Widget build (BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Settings"),
      ),
      body: Center(
        child: Container(
          child: Column(
            children: <Widget>[
              Text("Hello",
                style: DefaultTextStyle.of(context).style.apply(fontSizeFactor: 3.0),
              ),
              Text("World!",
                style: DefaultTextStyle.of(context).style.apply(fontSizeFactor: 3.0),
              ),
            ],
          ),
        ),
      ),
    );
  }
}