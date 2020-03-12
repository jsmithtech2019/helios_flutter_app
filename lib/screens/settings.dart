/*
 * Texas A&M University
 * Electronic Systems Engineering Technology
 * ESET-420 Engineering Technology Senior Design II
 * File: settings.dart
 * Author: Jack Smith (john.d.smitherton@tamu.edu)
 */

// Flutter Packages
import 'package:HITCH/models/bluetooth.dart';
import 'package:HITCH/models/print.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:get_it/get_it.dart';
import 'package:HITCH/models/forms.dart';

// Utils
import 'package:HITCH/utils/database_helper.dart';

// Models
import 'package:HITCH/models/seperator.dart';

class SettingsPage extends StatefulWidget{

  @override
  State<StatefulWidget> createState() {
    return SettingsPageState();
  }
}

class SettingsPageState extends State<SettingsPage> {
  // Pull GetIt Singleton and create pointers to Singleton Helpers
  final DatabaseHelper dbHelper = GetIt.instance<DatabaseHelper>();
  List<DropdownMenuItem<String>> menuItems = new List<DropdownMenuItem<String>>();
  List<String> names = new List<String>();
  String dropDownValue;

  @override
  void initState() {
    dropDownValue = null;
    super.initState();
  }

  @override
  Widget build (BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Settings"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            new SeparatorBox("General Inquiries"),
            Container(
              //margin: EdgeInsets.all(24),
              margin: EdgeInsets.fromLTRB(24, 0, 24, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(height: 15),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: PrintDatabaseResponses(
                        'SELECT name FROM ADMIN_DATA ORDER BY id DESC LIMIT 1',
                        'Employee Name', 17),
                  ),
                  SizedBox(height: 5),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: PrintDatabaseResponses(
                        'SELECT email FROM ADMIN_DATA ORDER BY id DESC LIMIT 1',
                        'Employee Name', 17),
                  ),
                  SizedBox(height: 5),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: PrintDatabaseResponses(
                        'SELECT dealership FROM ADMIN_DATA ORDER BY id DESC LIMIT 1',
                        'Dealership', 17),
                  ),
                  SizedBox(height: 5),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: PrintDatabaseResponses(
                        'SELECT dealer_uuid FROM ADMIN_DATA ORDER BY id DESC LIMIT 1',
                        'Dealership UUID', 17),
                  ),
                  SizedBox(height: 5),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: PrintDatabaseResponses(
                        'SELECT moduleID FROM ADMIN_DATA ORDER BY id DESC LIMIT 1',
                        'Paired Module', 17),
                  ),
                  SizedBox(height: 20),
                ],
              ),
            ),
            new SeparatorBox("Choose Existing Configuration"),
            new FutureBuilder<List<String>>(
                future: dbHelper.getEmployeesList('name'),
                builder: (BuildContext context, AsyncSnapshot<List<String>> snapshot) {
                  switch (snapshot.connectionState) {
                    case ConnectionState.none: return new Text("Database Connection Failed!");
                    case ConnectionState.waiting: return new CircularProgressIndicator();
                    case ConnectionState.active: return new CircularProgressIndicator();
                    default:
                      if(snapshot.hasError){
                        return new Text("Error: ${snapshot.error}");
                      } else {
                        this.names = snapshot.data;

                        return DropdownButton<String>(
                          value: dropDownValue,
                          hint: Text('Choose Employee'),
                          items: this.names.map((String val) {
                            return new DropdownMenuItem<String>(
                              value: val,
                              child: new Text(val),
                            );
                          }).toList(),
                          onChanged: (String newVal){
                            // TODO: update the admin configuration to use selected profile
                            setState(() {
                              dropDownValue = newVal;
                            });
                          },
                        );
                      }
                  }
                }
            ),
            SizedBox(height: 20),
            new SeparatorBox("Pair Device"),
            (globalHelper.bluetoothDevice == null) ? 
              Column(
                children: <Widget>[
                  SizedBox(height: 10),
                  RaisedButton(
                    child: Text('Find Available Devices'),
                     onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => FlutterBlueApp(),
                        ),
                      );
                    },
                  )
                ],
              ) : Column(
                children: <Widget>[
                  SizedBox(height: 10),
                  new Text('Paired Module: ',
                    style: TextStyle(fontSize: 20),
                  ),
                  new Text('${globalHelper.adminData.moduleUUID}',
                    style: TextStyle(fontSize: 15),
                  ),
                  SizedBox(height: 10),
                  RaisedButton(
                    child: Text('Pair Another Devices'),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => FlutterBlueApp(),
                        ),
                      );
                    },
                  ),
                ],
              ),
            SizedBox(height: 20),
            new SeparatorBox("Add Configuration"),
            Container(
              margin: EdgeInsets.fromLTRB(24, 0, 24, 0),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    new EmployeeForm(),
                    SizedBox(height: 20),
                  ]
              )
            ),
          ],
        ),
      ),
    );
  }
}

