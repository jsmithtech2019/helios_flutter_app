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

class SettingsPage extends StatelessWidget {
  // Pull GetIt Singleton and create pointers to Singleton Helpers
  final DatabaseHelper dbHelper = GetIt.instance<DatabaseHelper>();

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
            new SeparatorBox("Update Configuration"),
            Container(
              margin: EdgeInsets.fromLTRB(24, 0, 24, 0),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    new EmployeeForm(),
                  ]
              )
            ),
          ],
        ),
      ),
    );
  }
}

