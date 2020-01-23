import 'package:flutter/material.dart';
import 'home_widget.dart';
//import 'dart:async';
//import 'package:path/path.dart';
//import 'package:sqflite/sqflite.dart';
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