/*
 * Texas A&M University
 * Electronic Systems Engineering Technology
 * ESET-420 Engineering Technology Senior Design II
 * File: main.dart
 * Author: Jack Smith (john.d.smitherton@tamu.edu)
 */

// Flutter Packages
import 'package:HITCH/models/bluetooth.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:logger/logger.dart';

// Models
import 'package:HITCH/models/global.dart';

// Utils
import 'package:HITCH/utils/database_helper.dart';
import 'package:HITCH/utils/home_widget.dart';

/// Provision a [GetIt] singleton for entire application stack
/// 
/// Used to add members to the singleton instances that can be accessed from
/// every page without allowing [async] access to the same protected members
/// or resources.
GetIt sl = GetIt.instance;

/// # Boilerplate page that initializes the entire application, is called on
/// application opening and then passes all navigation and drawing to the
/// Home widget from home_widget.dart.
///
/// This class starts all beginner singletons at instantiation, can be used to
/// preload development data into the [SQLite] database and provisions the 
/// database if one has not yet be generated.
///
/// Initializes:
/// - GetIt Singleton
/// - DatabaseHelper Singleton
/// - GlobalHelper Singleton
/// - Logger Singleton
/// - Starts the application
void main() async {
  /// Wait until ASYNC calls are completed before starting the application
  WidgetsFlutterBinding.ensureInitialized();

  /// Generated and register Singletons into GetIt instance
  sl.registerSingleton<Logger>(
    Logger(
      printer: PrettyPrinter(
        methodCount: 0,
        errorMethodCount: 8,
        lineLength: 100,
        colors: true,
        printEmojis: false,
      )
    )
  );
  sl.registerSingleton<DatabaseHelper>(DatabaseHelper());
  sl.registerSingleton<GlobalHelper>(GlobalHelper());
  // Write a default constructor for bluetooth device
  //sl.registerSingleton<BluetoothDevice>(BluetoothDevice());

  /// Get instances of [DatabaseHelper], [Logger] and [GlobalHelper] singletons
  var dbHelper = GetIt.instance<DatabaseHelper>();
  var logHelper = GetIt.instance<Logger>();
  var globalHelper = GetIt.instance<GlobalHelper>();

  /// Initialize the application database. Does not recreate if one has been
  /// provisioned previously by the application.
  await dbHelper.initializeDatabase();
  logHelper.d("Database has been initialized!");

  /// Only seed test data once, if data exists do not write again
  var count = await dbHelper.executeRawQuery("SELECT count(id) FROM CUSTOMER_DATA");
  if (count[0].values.toList()[0].toString() == "0"){
    seedDatabase();
  }

  /// Get the most recent employee from database for usage
  var employeeInfo = await dbHelper.executeRawQuery('SELECT * FROM ADMIN_DATA ORDER BY id DESC LIMIT 1');

  /// Seed [GlobalHelper] singleton with Admin values
  globalHelper.adminData.employeeName = employeeInfo[0]['name'];
  globalHelper.adminData.employeeUUID = employeeInfo[0]['employee_uuid'];
  globalHelper.adminData.employeePhoneNumber = employeeInfo[0]['phone'];
  globalHelper.adminData.employeeEmail = employeeInfo[0]['email'];
  globalHelper.adminData.dealership = employeeInfo[0]['dealership'];
  globalHelper.adminData.dealershipUUID = employeeInfo[0]['dealer_uuid'];
  globalHelper.adminData.moduleUUID = employeeInfo[0]['moduleID'];

  /// Get the most recent Customer added to the database
  var custInfo = await dbHelper.executeRawQuery('SELECT id FROM CUSTOMER_DATA ORDER BY ID DESC LIMIT 1');
  globalHelper.customerData.customerId = custInfo[0]['id'];
  globalHelper.lastTestId = custInfo[0]['id'];

  /// Start the application
  runApp(HeliosApp());
}

/// Stateful widget for the main framework of the application.
/// 
/// Generates a statebased application.
class HeliosApp extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return HeliosAppStateful();
  }
}

/// Initializes the main context of the application.
/// 
/// Sets the [ThemeData] to use dark theme and a [blueGrey] color scheme over
/// the course of the application. Also titles the main name of the application
/// and the home page in [Home] which is set as the [TestingPage] to allow for 
/// immediate insertion of customer details.
class HeliosAppStateful extends State<HeliosApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'HITCH Controller Application',
      home: Home(0),
      theme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.blueGrey,
      ),
    );
  }
}

/// Used to seed testing data into the [SQLite] database
/// 
/// This creates dummy truck, trailer, customer and admin data that is then
/// inserted into the database and used by the controller application for
/// development purposes.
/// 
/// TODO: remove before becoming a release candidate.
void seedDatabase(){
  Logger logHelper = GetIt.instance<Logger>();
  final DatabaseHelper dbHelper = GetIt.instance<DatabaseHelper>();
  // Dummy Truck Test Data
  dbHelper.executeRawQuery('INSERT INTO TRUCK_TEST_DATA '
      '(customerid, test1_result, test1_current, test2_result, test2_current, '
      'test3_result, test3_current, test4_result, test4_current) '
      'VALUES (1, 0, 21.0, 1, 1.24, 0, 13.9, 1, .98)');

  // Dummy Trailer Test Data
  dbHelper.executeRawQuery('INSERT INTO TRAILER_TEST_DATA '
      '(customerid, test1_result, test1_current, test2_result, test2_current, '
      'test3_result, test3_current, test4_result, test4_current) '
      'VALUES (1, 0, 21.0, 1, 1.24, 0, 13.9, 1, .98)');

  // Dummy Customer Data
  dbHelper.executeRawQuery('INSERT INTO CUSTOMER_DATA (name, phone, email, '
      'addr1, addr2, city, state, zip, truckplate, trailerplate) VALUES ('
      '"Jack Smith", "3038018528", "dummy@gmail.com", "addr1", "addr2", "cstat", '
      '"tx", "7777", "246-ZLF", "ZLF-246")');

  // Dummy Employee Data
  dbHelper.executeRawQuery('INSERT INTO ADMIN_DATA (name, phone, email, pass, '
      'moduleID, dealership, dealer_uuid, employee_uuid) VALUES ("Christian Ledgard", '
      '"7138983810", "christianledgard@tamu.edu", '
      '"password", "c1cde887-51e2-11ea-8777-0242c0a83004", "Helios", "c1cde81b-51e2-11ea-8777-0242c0a83004", "c1cde8fc-51e2-11ea-8777-0242c0a83004")');

  dbHelper.executeRawQuery('INSERT INTO ADMIN_DATA (name, phone, email, pass, '
      'moduleID, dealership, dealer_uuid, employee_uuid) VALUES ("Christian Ledgard", '
      '"303", "test@mail", '
      '"pass", "34cdcaf4-5e2d-11ea-bd80-0242ac180004", "Helios", "34cdcad7-5e2d-11ea-bd80-0242ac180004", "34cdcb1a-5e2d-11ea-bd80-0242ac180004")');
  
  logHelper.d("Database has been seeded with test data.");
}