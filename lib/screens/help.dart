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
  final String setUp = "\nTo setup the module first enroll an employee in the "
    "central server using the website interface. This will allow test results to "
    "post results to DUET and be available on both local and server storage. "
    "Next simply select 'pair a device' from the settings page (after powering on "
    "a HITCH module) and pair the device via bluetooth. You are now ready to begin "
    "testing!";

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
  final String testingUsage = "\nThe module will guide you through the testing "
    "for the truck as well as the trailer in real time. After connecting the "
    "truck to the module, begin the truck test and follow the instructions on "
    "the interface. They will drop through in the following order:\n1) Left Turn Signal"
    "\n2) Right Turn Signal\n3) Tail Lights\n4) Break Lights\nWhen each instruction "
    "is activated perform the necessary action to enable that component. \nPlease note: "
    "the truck must not be fully powered on while connected, it should run in "
    "Auxillary power only!";

  /// Debugging bad readings help string
  final String badReadings = "\nIf the HITCH module is consistently giving bad readings "
    "there are a few possibilities that can be addressed:\n1) Ensure the module is "
    "fully charged and has not sustained damage from water or shock.\n2) Check that "
    "there is no debris or buildup on the HITCH connectors or the truck/trailer pins "
    "as this could lead to faulty connection.\n3) Check that there are no loose or "
    "disconnected cables in the modules internals or that nothing has broken loose.\n"
    "If none of these have occurred consider contacting us with the issue you are having.";

  /// Locating past tests help string
  final String testHistory = "\nPreviously run tests can be accessed from the results "
    "page. Select a customer from the drop down menu and then the results box will "
    "fill with avaiable tests run for that customer. Note that these results are "
    "only for tests that have been run on this controller app and do not include "
    "results that are stored from other applications in the cloud. These results "
    "can be viewed from the results page of the website";

  /// Deleting old tests
  final String removingTestHistory = "\nTo remove test results from the application "
    "simply delete the application and reinstall it on the device. A word of "
    "caution: deleting the app will also remove all existing admin profiles.";

  /// Connecting with duet help string
  final String duetConnection = "\nIf you are seeing errors with results uploads "
    "ensure that all information in the employee console is correct. You will "
    "need to validate that the employee, dealership and module are all enrolled "
    "on the webserver and that there is an internet connection for the device to "
    "transmit the results to the server.\nAlso ensure that all tests have completed "
    "successfully as failed tests could lead to broken uploads.";

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