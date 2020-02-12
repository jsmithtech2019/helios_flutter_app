// Flutter Packages
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:HITCH/models/forms.dart';

// Utils
import 'package:HITCH/utils/database_helper.dart';

// Models
import 'package:HITCH/models/seperator.dart';

///#############################################################################
///                            settings.dart
///#############################################################################

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
    dropDownValue = "Choose Employee";
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
                    child: PrintDatabaseResponses(dbHelper,
                        'SELECT name FROM ADMIN_DATA ORDER BY id DESC LIMIT 1',
                        'Employee Name', 17),
                  ),
                  SizedBox(height: 5),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: PrintDatabaseResponses(dbHelper,
                        'SELECT email FROM ADMIN_DATA ORDER BY id DESC LIMIT 1',
                        'Employee Name', 17),
                  ),
                  SizedBox(height: 5),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: PrintDatabaseResponses(dbHelper,
                        'SELECT dealership FROM ADMIN_DATA ORDER BY id DESC LIMIT 1',
                        'Dealership', 17),
                  ),
                  SizedBox(height: 5),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: PrintDatabaseResponses(dbHelper,
                        'SELECT dealer_uuid FROM ADMIN_DATA ORDER BY id DESC LIMIT 1',
                        'Dealership UUID', 17),
                  ),
                  SizedBox(height: 5),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: PrintDatabaseResponses(dbHelper,
                        'SELECT moduleID FROM ADMIN_DATA ORDER BY id DESC LIMIT 1',
                        'Paired Module', 17),
                  ),
                  SizedBox(height: 20),
                ],
              ),
            ),
            new SeparatorBox("Choose Existing Configuration"),
            new FutureBuilder<List<String>>(
                future: dbHelper.getEmployeeNamesList(),
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

                        if (dropDownValue == "Choose Employee"){
                          this.names.add(dropDownValue);
                        }
                        return DropdownButton<String>(
                          value: dropDownValue,
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

