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
    /*

     */
    // Generate Singleton GetIt for usage on all Sheets
    GetIt getIt = GetIt.asNewInstance();

    // Create Singletons that will be registered on GetIt

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


/*

Use this for cool animated things
  AnimatedContainer(
    duration: Duration(seconds: 2),
    etc
  )

Use this for keeping an image on screen between screen changes without
redrawing
  Hero(

  )

--profile in running app to see the FPS on physical device

Used to show the proper widget based on Android or iOS, can also use adaptive flag
  Platform(
  )

Builders are functions that build widgets
  Use with lists to page things etc

// Statemanagement solutions
get_it
  CREATE GLOBAL SINGLETON -> USE FOR THE DB SINGLETON

provider
  Very good for state management too, can be accessed with a bunch
  of other pages etc

// Icons
flutter_launcher_icons
  already used, autogens all the icons for Android
  and iOS
*/