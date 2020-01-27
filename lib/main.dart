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

GetIt sl = GetIt.instance;

void main() {
  // Generate Singleton GetIt for usage on all Sheets
  GetIt.asNewInstance();

  // Generated and register Singletons into GetIt instance
  sl.registerSingleton<DatabaseHelper>(DatabaseHelper());
  sl.registerSingleton<Logger>(Logger());
  // TODO: enable the bluetooth singleton
  //getIt.registerSingleton<BluetoothHelper>(BluetoothHelper());

  // Get DatabaseHelper Singleton
  var dbHelper = GetIt.instance<DatabaseHelper>();

  // Initialize the database on the device
  dbHelper.initializeDatabase().then((onValue){print("Done initializng");});

  // TODO: remove test data insertion lines
  // Insert test data for debugging development
  // Dummy Truck Test Data
  dbHelper.executeRawQuery('INSERT INTO TRUCK_TEST_DATA '
      '(test1_result, test1_current, '
      'test2_result, test2_current, '
      'test3_result, test3_current, '
      'test4_result, test4_current) '
      'VALUES '
      '(0, 21.0, '
      '1, 1.24, '
      '0, 13.9, '
      '1, .98)');
  // Dummy Trailer Test Data
  dbHelper.executeRawQuery('INSERT INTO TRAILER_TEST_DATA '
      '(test1_result, test1_current, '
      'test2_result, test2_current, '
      'test3_result, test3_current, '
      'test4_result, test4_current) '
      'VALUES '
      '(0, 21.0, '
      '1, 1.24, '
      '0, 13.9, '
      '1, .98)');

  // Dummy User Data
  dbHelper.executeRawQuery('INSERT INTO CUSTOMER_DATA (name, phone, email, addr1, addr2, city, state, zip, truckplate, trailerplate) VALUES ('
      '"Jack Smith", "11111", "dummy@gmail.com", "addr1", "addr2", "cstat", "tx", "7777", "truckplateval", "trailerplateval")');

  runApp(HeliosApp());
}

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
