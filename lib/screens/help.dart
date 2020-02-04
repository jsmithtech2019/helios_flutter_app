// Flutter Packages
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

// Models

// Screens
import 'package:HITCH/screens/contact.dart';

// Utils
import 'package:HITCH/utils/database_helper.dart';


///#############################################################################
///
///#############################################################################

class HelpPage extends StatelessWidget {
  // Pull GetIt Singleton and create pointers to Singleton Helpers
  final DatabaseHelper dbHelper = GetIt.instance<DatabaseHelper>();

  final String lorem = "Lorem ipsum dolor sit amet, consectetur adipiscing elit,"
      " sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut "
      "enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut "
      "aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit "
      "in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur"
      " sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt"
      " mollit anim id est laborum.";

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
              new ExpandablePanel(
                header: Text("Setting up",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30)),
                expanded: Text(lorem, softWrap: true),
                tapHeaderToExpand: true,
                hasIcon: true,
                iconColor: Colors.white,
              ),
              SizedBox(height: 30),
              new ExpandablePanel(
                header: Text("Bluetooth Pairing",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30)),
                expanded: Text(lorem, softWrap: true),
                tapHeaderToExpand: true,
                hasIcon: true,
                iconColor: Colors.white,
              ),
              SizedBox(height: 30),
              new ExpandablePanel(
                header: Text("Testing",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30)),
                expanded: Text(lorem, softWrap: true),
                tapHeaderToExpand: true,
                hasIcon: true,
                iconColor: Colors.white,
              ),
              SizedBox(height: 30),
              new ExpandablePanel(
                header: Text("Bad Test Readings",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30)),
                expanded: Text(lorem, softWrap: true),
                tapHeaderToExpand: true,
                hasIcon: true,
                iconColor: Colors.white,
              ),
              SizedBox(height: 30),
              new ExpandablePanel(
                header: Text("Module Not Connecting",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30)),
                expanded: Text(lorem, softWrap: true),
                tapHeaderToExpand: true,
                hasIcon: true,
                iconColor: Colors.white,
              ),
              SizedBox(height: 30),
              new ExpandablePanel(
                header: Text("Connecting to Main Server",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30)),
                expanded: Text(lorem, softWrap: true),
                tapHeaderToExpand: true,
                hasIcon: true,
                iconColor: Colors.white,
              ),
              SizedBox(height: 30),
              new ExpandablePanel(
                header: Text("Searching Past Tests",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30)),
                expanded: Text(lorem, softWrap: true, ),
                tapHeaderToExpand: true,
                hasIcon: true,
                iconColor: Colors.white,
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