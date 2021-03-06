/*
 * Texas A&M University
 * Electronic Systems Engineering Technology
 * ESET-420 Engineering Technology Senior Design II
 * File: settings.dart
 * Author: Jack Smith (john.d.smitherton@tamu.edu)
 */

// Flutter Packages
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

// Utils
import 'package:HITCH/utils/database_helper.dart';
import 'package:HITCH/utils/home_widget.dart';

// Models
import 'package:HITCH/models/seperator.dart';
import 'package:HITCH/models/admin_data.dart';
import 'package:HITCH/models/bluetooth.dart';
import 'package:HITCH/models/global.dart';

/// Settings page stateful object
class SettingsPage extends StatefulWidget{
  /// [GetIt] instance of [GlobalHelper]
  final GlobalHelper globalHelper = GetIt.instance<GlobalHelper>();

  @override
  State<StatefulWidget> createState() {
    return SettingsPageState();
  }
}

/// State of Settings Page
/// 
/// Used for display and update of settings page and [GlobalHelper] admin data
class SettingsPageState extends State<SettingsPage> {
  /// Get [DatabaseHelper] singleton
  final DatabaseHelper dbHelper = GetIt.instance<DatabaseHelper>();
  
  /// Create list of menus that allow input
  List<DropdownMenuItem<String>> menuItems = new List<DropdownMenuItem<String>>();
  
  /// Initialize empty list of names
  List<String> names = new List<String>();
  
  /// String that stores the dropdown list selected name, initially null
  String dropDownValue;

  /// Create a global key that uniquely identifies the Form widget
  /// and allows validation of the form.
  final _formKey = GlobalKey<FormState>();
  final _key2 = GlobalKey<FormState>();

  /// [TextEditingController] for website name
  TextEditingController websiteAddressName = new TextEditingController();

  /// [TextEditingController] for Employee Name
  TextEditingController employeeNameController = new TextEditingController();

  /// [TextEditingController] for Employee Phone Number
  TextEditingController employeePhoneNumberController = new TextEditingController();

  /// [TextEditingController] for Employee Email
  TextEditingController employeeEmailController = new TextEditingController();

  /// [TextEditingController] for Employee Pass
  TextEditingController employeePassController = new TextEditingController();

  /// [TextEditingController] for Module UUID
  TextEditingController moduleID = new TextEditingController();

  /// [TextEditingController] for Dealership
  TextEditingController dealership = new TextEditingController();

  /// [TextEditingController] for Dealership UUID
  TextEditingController dealershipUUID = new TextEditingController();

  /// [TextEditingController] for Employee UUID
  TextEditingController employeeUUIDController = new TextEditingController();

  /// Update the [AdminData] object used by the app from the dropdown list
  void updateAdmin(String name) async {
    var employeeInfo = await dbHelper.executeRawQuery('SELECT * FROM ADMIN_DATA WHERE name="$name" LIMIT 1');
    globalHelper.adminData.employeeName = employeeInfo[0]['name'];
    globalHelper.adminData.employeePhoneNumber = employeeInfo[0]['phone'];
    globalHelper.adminData.employeeEmail = employeeInfo[0]['email'];
    globalHelper.adminData.employeeUUID = employeeInfo[0]['employee_uuid'];
    globalHelper.adminData.moduleUUID = employeeInfo[0]['moduleID'];
    globalHelper.adminData.dealership = employeeInfo[0]['dealership'];
    globalHelper.adminData.dealershipUUID = employeeInfo[0]['dealer_uuid'];
  }

  /// Initialize the state of the page to null
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
            // Create current configuration block
            new SeparatorBox("Current Configuration"),
            Container(
              margin: EdgeInsets.fromLTRB(24, 0, 24, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(height: 15),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text('Employee Name: ${globalHelper.adminData.employeeName}', style: TextStyle(fontSize: 17)),
                  ),
                  SizedBox(height: 5),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text('Employee Email: ${globalHelper.adminData.employeeEmail}', style: TextStyle(fontSize: 17)),
                  ),
                  SizedBox(height: 5),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text('Dealership: ${globalHelper.adminData.dealership}', style: TextStyle(fontSize: 17)),
                  ),
                  SizedBox(height: 5),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text('Employee UUID: ${globalHelper.adminData.employeeUUID}', style: TextStyle(fontSize: 17)),
                  ),
                  SizedBox(height: 5),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text('Dealership UUID: ${globalHelper.adminData.dealershipUUID}', style: TextStyle(fontSize: 17)),
                  ),
                  SizedBox(height: 5),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text('DUET Address: http://duet.${globalHelper.websiteAddress}.com', style: TextStyle(fontSize: 17)),
                  ),
                  SizedBox(height: 20),
                ],
              ),
            ),
            // Create dropdown for existing configurations
            new SeparatorBox("Choose Existing Admin"),
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
                            updateAdmin(newVal);
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
            new SeparatorBox("Choose Existing Admin"),
            Container(
              margin: EdgeInsets.fromLTRB(24, 0, 24, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Form(
                    key: _key2,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        new TextFormField(
                          controller: websiteAddressName,
                          textAlign: TextAlign.left,
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Please provide a valid name';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.all(20),
                            hintText: 'Website name',
                            hintStyle: TextStyle(color: Colors.grey),
                          ),
                        ),
                        RaisedButton(
                          onPressed: () {
                            // Validate returns true if the form is valid, or false
                            // otherwise.
                            if (_key2.currentState.validate()) {
                              setState(() {
                                // Update global singleton
                                widget.globalHelper.websiteAddress = websiteAddressName.text;
                              });
                            } // if
                          }, // onPressed
                          child: Text('Update Admin Configuration'),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            // Create the device pair button
            SizedBox(height: 20),
            new SeparatorBox("Pair Device"),
            (widget.globalHelper.bluetoothDevice == null) ? 
              Column(
                children: <Widget>[
                  SizedBox(height: 10),
                  RaisedButton(
                    child: Text('Find Available Devices'),
                     onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => BluetoothPage(),
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
                  new Text('${widget.globalHelper.adminData.moduleUUID}',
                    style: TextStyle(fontSize: 15),
                  ),
                  SizedBox(height: 10),
                  RaisedButton(
                    child: Text('Pair Another Devices'),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => BluetoothPage(),
                        ),
                      );
                    },
                  ),
                ],
              ),
            SizedBox(height: 20),
            // Create the add config input step
            new SeparatorBox("Add Configuration"),
            Container(
              margin: EdgeInsets.fromLTRB(24, 0, 24, 0),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Form(
                      key: _formKey,
                      child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        new TextFormField(
                          controller: employeeNameController,
                          textAlign: TextAlign.left,
                         validator: (value) {
                           if (value.isEmpty) {
                             return 'Please provide employee name';
                           }
                           return null;
                         },
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.all(20),
                            hintText: 'Employee Name',
                            hintStyle: TextStyle(color: Colors.grey),
                          ),
                        ),
                        new TextFormField(
                          controller: employeePhoneNumberController,
                          textAlign: TextAlign.left,
                         validator: (value) {
                           if (value.isEmpty) {
                             return 'Please provide employee phone number';
                           }
                           return null;
                         },
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.all(20),
                            hintText: 'Employee Phone Number',
                            hintStyle: TextStyle(color: Colors.grey),
                          ),
                        ),
                        new TextFormField(
                          controller: employeeEmailController,
                          textAlign: TextAlign.left,
                         validator: (value) {
                           if (value.isEmpty) {
                             return 'Please provide Employee Email';
                           }
                           return null;
                         },
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.all(20),
                            hintText: 'Employee Email',
                            hintStyle: TextStyle(color: Colors.grey),
                          ),
                        ),
                        new TextFormField(
                          controller: employeePassController,
                          textAlign: TextAlign.left,
                         validator: (value) {
                           if (value.isEmpty) {
                             return 'Please provide Employee Password';
                           }
                           return null;
                         },
                          obscureText: true,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.all(20),
                            hintText: 'Employee Password',
                            hintStyle: TextStyle(color: Colors.grey),
                          ),
                        ),
                        new TextFormField(
                          controller: dealership,
                          textAlign: TextAlign.left,
                         validator: (value) {
                           if (value.isEmpty) {
                             return 'Please provide Dealership name';
                           }
                           return null;
                         },
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.all(20),
                            hintText: 'Dealership',
                            hintStyle: TextStyle(color: Colors.grey),
                          ),
                        ),
                        new TextFormField(
                          controller: employeeUUIDController,
                          textAlign: TextAlign.left,
                         validator: (value) {
                           if (value.isEmpty) {
                             return 'Please provide Employee UUID';
                           }
                           return null;
                         },
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.all(20),
                            hintText: 'Employee UUID',
                            hintStyle: TextStyle(color: Colors.grey),
                          ),
                        ),
                        new TextFormField(
                          controller: moduleID,
                          textAlign: TextAlign.left,
                         validator: (value) {
                           if (value.isEmpty) {
                             return 'Please provide Module UUID';
                           }
                           return null;
                         },
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.all(20),
                            hintText: 'Module UUID',
                            hintStyle: TextStyle(color: Colors.grey),
                          ),
                        ),
                        new TextFormField(
                          controller: dealershipUUID,
                          textAlign: TextAlign.left,
                         validator: (value) {
                           if (value.isEmpty) {
                             return 'Please provide Dealership UUID';
                           }
                           return null;
                         },
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.all(20),
                            hintText: 'Dealership UUID',
                            hintStyle: TextStyle(color: Colors.grey),
                          ),
                        ),
                        RaisedButton(
                          onPressed: () {
                            // Validate returns true if the form is valid, or false
                            // otherwise.
                            if (_formKey.currentState.validate()) {
                              // If the form is valid, display a Snackbar.
                              final adminData = AdminData(
                                employeeNameController.text,
                                employeePhoneNumberController.text,
                                employeeEmailController.text,
                                employeePassController.text,
                                employeeUUIDController.text,
                                moduleID.text,
                                dealership.text,
                                dealershipUUID.text,
                              );

                              // Update global singleton
                              widget.globalHelper.adminData = adminData;

                              dbHelper.insertAdminData(adminData);
                              Scaffold.of(context).showSnackBar(SnackBar(content: Text('Processing Data')));
                              Navigator.of(context).pushAndRemoveUntil(
                                  MaterialPageRoute(builder: (context) => Home(2)),
                                  (Route<dynamic> route) => false);
                            } // if
                          }, // onPressed
                          child: Text('Update Admin Configuration'),
                        ),
                      ],
                      ),
                  ),
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

