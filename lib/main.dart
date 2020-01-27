// Flutter Packages
import 'package:flutter/material.dart';
//import 'package:flutter_blue/flutter_blue.dart';
import 'package:get_it/get_it.dart';
import 'package:logger/logger.dart';

// Models

// Screens

// Utils
import 'package:HITCH/utils/database_helper.dart';
import 'package:HITCH/utils/home_widget.dart';


///#############################################################################
///                            MAIN.dart
/// Boilerplate page that initializes the entire application, is called on
/// application opening and then passes all navigation and drawing to the
/// Home widget from home_widget.dart.
///
/// Initializes:
/// - GetIt Singleton
/// - DatabaseHelper Singleton
/// - BluetoothHelper Singleton
/// - Logger Singleton
///#############################################################################

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
    // Generate Singleton GetIt for usage on all Sheets
    GetIt getIt = GetIt.asNewInstance();

    // Generated and register Singletons into GetIt instance
    getIt.registerSingleton<DatabaseHelper>(DatabaseHelper());
    getIt.registerSingleton<Logger>(Logger());
    // TODO: enable the bluetooth singleton
    //getIt.registerSingleton<BluetoothHelper>(BluetoothHelper());

    // Get DatabaseHelper Singleton
    var dbHelper = GetIt.instance<DatabaseHelper>();

    // Initialize the database on the device
    dbHelper.initializeDatabase().then((onValue){print("Done initializing");});

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
