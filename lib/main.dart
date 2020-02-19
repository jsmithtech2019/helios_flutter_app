// Flutter Packages
import 'package:HITCH/models/global.dart';
import 'package:HITCH/utils/api_helper.dart';
import 'package:flutter/material.dart';
//import 'package:flutter_blue/flutter_blue.dart';
import 'package:get_it/get_it.dart';
import 'package:logger/logger.dart';

// Models
import 'package:HITCH/models/global.dart';

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

void main() async {
  // Wait until ASYNC calls are completed before starting the application
  WidgetsFlutterBinding.ensureInitialized();

  // Generate Singleton GetIt for usage on all Sheets
  GetIt.asNewInstance();

  // Generated and register Singletons into GetIt instance
  sl.registerSingleton<DatabaseHelper>(DatabaseHelper());
  sl.registerSingleton<Logger>(Logger(
      printer: PrettyPrinter(
        methodCount: 0,
        errorMethodCount: 8,
        lineLength: 100,
        colors: true,
        printEmojis: false,
      )
  ));
  sl.registerSingleton<GlobalHelper>(GlobalHelper());
  // TODO: enable the bluetooth singleton
  //getIt.registerSingleton<BluetoothHelper>(BluetoothHelper());

  // Get DatabaseHelper Singleton
  var dbHelper = GetIt.instance<DatabaseHelper>();
  var logHelper = GetIt.instance<Logger>();
  var globalHelper = GetIt.instance<GlobalHelper>();

  // Initialize the database on the device
  // Initialize the database on the device
  // dbHelper.initializeDatabase().then(
  //   (onValue){
  //     logHelper.d("Database has been initialized!");
  //   }
  // );
  var init = await dbHelper.initializeDatabase();
  logHelper.d("Database has been initialized!");

  // TODO: remove test data insertion lines
  // Insert test data for debugging development
  // Dummy Truck Test Data

  // Only seed data once, if data exists do not write again
  var coun = await dbHelper.executeRawQuery("SELECT count(id) FROM CUSTOMER_DATA");
  if (coun[0].values.toList()[0].toString() == "0"){
    seedDatabase();
  }

  // Get the most recent employee from database
  var employeeInfo = await dbHelper.executeRawQuery('SELECT * FROM ADMIN_DATA ORDER BY id DESC LIMIT 1');

  // Seed Global with Admin values
  globalHelper.dealership = employeeInfo[0]['dealership'];
  globalHelper.dealershipUUID = employeeInfo[0]['dealer_uuid'];
  globalHelper.employeeUUID = employeeInfo[0]['employee_uuid'];
  globalHelper.employeePhone = employeeInfo[0]['phone'];
  globalHelper.employeeEmail = employeeInfo[0]['email'];
  globalHelper.moduleUUID = employeeInfo[0]['moduleID'];

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
      home: Home(0),
      theme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.blueGrey,
      ),
    );
  } // Build
} // Class

void seedDatabase(){
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
      '"pass", "c1cde887-51e2-11ea-8777-0242c0a83004", "Helios", "c1cde81b-51e2-11ea-8777-0242c0a83004", "c1cde8fc-51e2-11ea-8777-0242c0a83004")');
  
  logHelper.d("Database has been seeded with test data.");
}