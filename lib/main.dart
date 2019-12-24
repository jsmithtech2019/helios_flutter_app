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

//class TestResults {
//  // Object Variable Declarations
//  final int phone;
//  final String name;
//  final int vin;
//  var testResults = new List();
//
//  // Object Constructor
//  TestResults({this.phone, this.name, this.vin, this.testResults});
//}
//
//// Open the database and store the reference.
//final Future<Database> database = openDatabase(
//  // Set the path to the database.
//  join(await getDatabasesPath(), 'doggie_database.db'),
//
//  // When the database is first created, create a table to store dogs.
//  onCreate: (db, version) {
//    // Run the CREATE TABLE statement on the database.
//    return db.execute("CREATE TABLE dogs(phone INTEGER PRIMARY KEY, name TEXT, vin INTEGER)");
//  },
//  // Set the version. This executes the onCreate function and provides a
//  // path to perform database upgrades and downgrades.
//  version: 1,
//);