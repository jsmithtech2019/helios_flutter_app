import 'package:flutter/material.dart';
//import 'package:flutter_blue/flutter_blue.dart';
import 'home_widget.dart';


void main() => runApp(HeliosApp());

class HeliosApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'HITCH Controller Application',
      home: Home(),
      theme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.blueGrey,
      ),
    );
  }
//  @override
//  State<StatefulWidget> createState() {
//    // TODO: implement createState
//    TextEditingController testController = new TextEditingController();
//    return null;
//  }
}

