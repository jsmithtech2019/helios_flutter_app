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

  /// String for information into each help page
  /// TODO: remove and replace with actual help data
  final String lorem = "Lorem ipsum dolor sit amet, consectetur adipiscing elit,"
      " sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut "
      "enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut "
      "aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit "
      "in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur"
      " sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt"
      " mollit anim id est laborum.";

  final String setUp = "";
  final String bluetoothPairing = "";
  final String badReadings = "";
  final String connectionFailur = "";
  final String duetConnection = "";
  final String testHistory = "";
  final String removingTestHistory = "";

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
                expanded: Text(setUp, softWrap: true),
              ),
              SizedBox(height: 30),
              ExpandablePanel(
                header: Text("Bluetooth Pairing",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30)),
                expanded: Text(bluetoothPairing, softWrap: true),
              ),
              SizedBox(height: 30),
              ExpandablePanel(
                header: Text("Testing",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30)),
                expanded: Text(badReadings, softWrap: true),
              ),
              SizedBox(height: 30),
              ExpandablePanel(
                header: Text("Bad Test Readings",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30)),
                expanded: Text(connectionFailur, softWrap: true),
              ),
              SizedBox(height: 30),
              ExpandablePanel(
                header: Text("Module Not Connecting",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30)),
                expanded: Text(duetConnection, softWrap: true),
              ),
              SizedBox(height: 30),
              ExpandablePanel(
                header: Text("Connecting to Main Server",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30)),
                expanded: Text(testHistory, softWrap: true),
              ),
              SizedBox(height: 30),
              ExpandablePanel(
                header: Text("Removing Old Tests",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30)),
                expanded: Text(removingTestHistory, softWrap: true),
              ),
              SizedBox(height: 30),
              ExpandablePanel(
                header: Text("Searching Past Tests",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30)),
                expanded: Text(lorem, softWrap: true, ),
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