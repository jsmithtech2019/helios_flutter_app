import 'package:HITCH/utils/database_helper.dart';
import 'package:flutter/material.dart';
import 'package:HITCH/utils/home_widget.dart';
import 'package:HITCH/models/database.dart';
//import 'package:flutter_blue/flutter_blue.dart';

void main() => runApp(HeliosApp());

class HeliosApp extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return HeliosAppStateful();
  }
}

class HeliosAppStateful extends State<HeliosApp> {
  @override
  Widget build(BuildContext context) {
    DatabaseHelper helper = DatabaseHelper();
    helper.initializeDatabase().then((onValue){print("Done initializing");});
    return MaterialApp(
      title: 'HITCH Controller Application',
      home: Home(),
      theme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.blueGrey,
      ),
    );
  } // Build
} // Class