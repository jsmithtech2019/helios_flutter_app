/*
 * Texas A&M University
 * Electronic Systems Engineering Technology
 * ESET-420 Engineering Technology Senior Design II
 * File: help.dart
 * Author: Jack Smith (john.d.smitherton@tamu.edu)
 */

// Flutter Packages
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

// Screens
import 'package:HITCH/screens/contact.dart';

// Utils
import 'package:HITCH/utils/database_helper.dart';

/// Shows help information and links to contact us page
/// 
/// Displays a series of expandable widgets with titles of what helpful information
/// they contain as well as expanded info that is useful for debugging testing issues.
///
/// Also contains a link to the contact us page that has email/phone numbers
/// of the application developers
class HelpPage extends StatelessWidget {
  /// [GetIt] singleton for [DatabaseHelper]
  final DatabaseHelper dbHelper = GetIt.instance<DatabaseHelper>();

  /// Setup help string
  final String setUp = "\nlol setup";

  /// Pairing with a device help string
  final String bluetoothPairing = "\nIn order to begin testing you will need to "
    "pair a HITCH module with this application. To do so, navigate to the settings "
    "page and select 'Find Available Devices' which will then display available "
    "modules that are powered on and nearby (it will also prompt you to enable "
    "Bluetooth on your phone if it is not already enabled. Select the module you "
    "wish to use and click on the 'Return to Home Page' button. You are now ready "
    "to begin testing.";

  /// Debugging connection failure help string
  final String connectionFailure = "\nThere are a few options to try if a HITCH module "
    "is refusing to connect. The first step is to identify you are attempting to "
    "pair with the proper module by comparing the UUID found on the 'Devices' "
    "page and the UUID printed on the module. If these are the same then a few "
    "options may be useful:\n\n1) Force quit the application and restart before "
    "attempting to pair again.\n\n2) Follow step 1 but also turn off Bluetooth on "
    "the phone for a few seconds then reenable before restarting the app.\n\n3) "
    "Power the HITCH module off for 10 seconds and then attempt to connect again.\n\n "
    "If none of these steps work please consider filing a bug report with us on "
    "the 'Contact Us' page.";

  /// Instructions for testing
  final String testingUsage = "\nHow to test";

  /// Debugging bad readings help string
  final String badReadings = "\nDebug bad readings";

  /// Locating past tests help string
  final String testHistory = "\nAccess old tests";

  /// Deleting old tests
  final String removingTestHistory = "\nDelet this app";

  /// Connecting with duet help string
  final String duetConnection = "\nFiguring out why DUET isn't working";

  @override
  Widget build (BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Help"),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(24),
          child: Column(
            children: <Widget>[
              ExpandablePanel(
                header: Text("Setting up",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30)),
                expanded: Text(setUp, softWrap: true, style: TextStyle(fontSize: 20)),
              ),
              SizedBox(height: 30),
              ExpandablePanel(
                header: Text("Bluetooth Pairing",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30)),
                expanded: Text(bluetoothPairing, softWrap: true, style: TextStyle(fontSize: 20)),
              ),
              SizedBox(height: 30),
              ExpandablePanel(
                header: Text("Module Not Connecting",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30)),
                expanded: Text(connectionFailure, softWrap: true, style: TextStyle(fontSize: 20)),
              ),
              SizedBox(height: 30),
              ExpandablePanel(
                header: Text("Testing",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30)),
                expanded: Text(testingUsage, softWrap: true, style: TextStyle(fontSize: 20)),
              ),
              SizedBox(height: 30),
              ExpandablePanel(
                header: Text("Bad Test Readings",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30)),
                expanded: Text(badReadings, softWrap: true, style: TextStyle(fontSize: 20)),
              ),
              SizedBox(height: 30),
              ExpandablePanel(
                header: Text("Searching Past Tests",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30)),
                expanded: Text(testHistory, softWrap: true, style: TextStyle(fontSize: 20)),
              ),
              SizedBox(height: 30),
              ExpandablePanel(
                header: Text("Removing Old Tests",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30)),
                expanded: Text(removingTestHistory, softWrap: true, style: TextStyle(fontSize: 20)),
              ),
              SizedBox(height: 30),
              ExpandablePanel(
                header: Text("Connecting to Main Server",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30)),
                expanded: Text(duetConnection, softWrap: true, style: TextStyle(fontSize: 20)),
              ),
              SizedBox(height: 30),
              new SizedBox(
                width: 200,
                height: 50,
                child: RaisedButton(
                  child: Text("Contact Us"),
                  onPressed: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ContactPage()),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}