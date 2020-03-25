/*
 * Texas A&M University
 * Electronic Systems Engineering Technology
 * ESET-420 Engineering Technology Senior Design II
 * File: testing.dart
 * Author: Jack Smith (john.d.smitherton@tamu.edu)
 */


// Flutter Packages
import 'package:flutter_blue/flutter_blue.dart';
import 'package:get_it/get_it.dart';
import 'package:HITCH/utils/home_widget.dart';
import 'package:flutter/material.dart';

// Models
import 'package:HITCH/models/customer_data.dart';
import 'package:HITCH/models/global.dart';
import 'package:HITCH/models/seperator.dart';

// Screens
import 'package:HITCH/screens/testing_trailer.dart';
import 'package:HITCH/screens/testing_truck.dart';

// Utils
import 'package:HITCH/utils/database_helper.dart';

/// Create the initial state object for Testing
/// 
/// Is a stateful widget so only for initial setup, does not have much
/// functionality outside of creating state object
class TestingPage extends StatefulWidget {
  // Pull GetIt Singleton and create pointers to Singleton Helpers
  final DatabaseHelper dbHelper = GetIt.instance<DatabaseHelper>();
  final GlobalHelper globalHelper = GetIt.instance<GlobalHelper>();

  // Generate an empty CustomerData object
  CustomerData customerData = new CustomerData.emptyConst();

  @override
  _TestingPageState createState() => new _TestingPageState();
}

class _TestingPageState extends State<TestingPage> {
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  //
  // Note: This is a `GlobalKey<FormState>`,
  // not a GlobalKey<MyCustomFormState>.
  final _formKey = GlobalKey<FormState>();

  /// Create  [TextEditingController]s for the fields of customer input
  final TextEditingController _custNameController = new TextEditingController();
  final TextEditingController _custPhoneController = new TextEditingController();
  final TextEditingController _custEmailController = new TextEditingController();
  final TextEditingController _custAddressLine1Controller = new TextEditingController();
  final TextEditingController _custAddressLine2Controller = new TextEditingController();
  final TextEditingController _custCityController = new TextEditingController();
  final TextEditingController _custStateController = new TextEditingController();
  final TextEditingController _custZipCodeController = new TextEditingController();
  final TextEditingController _truckLicensePlateController = new TextEditingController();
  final TextEditingController _trailerLicensePlateController = new TextEditingController();

  /// Remove all of the [TextEditingController]s to save application resources
  /// after they fall out of scope. This is required such that memory does not 
  /// become limited.
  @override
  void dispose() {
    _custNameController.dispose();
    _custPhoneController.dispose();
    _custEmailController.dispose();
    _custAddressLine1Controller.dispose();
    _custAddressLine2Controller.dispose();
    _custCityController.dispose();
    _custStateController.dispose();
    _custZipCodeController.dispose();
    _truckLicensePlateController.dispose();
    _trailerLicensePlateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // If no bluetooth has been initialized, don't allow
    // testing to begin.
    try {
      GetIt.instance<BluetoothDevice>();
    } catch (e) {
      // BLE not initialized, popup error
      return Scaffold(
        appBar: AppBar(
          title: Text("H.I.T.C.H. Testing"),
        ),
        body: AlertDialog(
          title: Text('Bluetooth not initialized!\n\nPlease pair a HITCH module before'
          ' continuing with testing.'),
          actions: <Widget>[
            FlatButton(
              child: Text('Ok'),
              onPressed: () {
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(
                    builder: (context) => Home(2)
                  ),
                  (Route<dynamic> route) => false
                );
              },
            )
          ],
        )
      );
    }

    return Scaffold(
        appBar: AppBar(
          title: Text("H.I.T.C.H. Testing"),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
             SeparatorBox('Insert Customer Details'),
            Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  new TextFormField(
                    controller: _custNameController,
                    textAlign: TextAlign.left,
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please provide Customer Name';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(20),
                      hintText: 'Customer Name',
                      hintStyle: TextStyle(color: Colors.grey),
                    ),
                    onChanged: (text) {
                      widget.customerData.customerName = text;
                    },
                  ),
                  new TextFormField(
                    controller: _custPhoneController,
                    textAlign: TextAlign.left,
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please provide Customer Phone Number';
                    }
                    return null;
                  },
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(20),
                      hintText: 'Customer Phone Number',
                      hintStyle: TextStyle(color: Colors.grey),
                    ),
                    onChanged: (text) {
                      widget.customerData.customerPhoneNumber = text;
                    },
                  ),
                  new TextFormField(
                    controller: _custEmailController,
                    textAlign: TextAlign.left,
        //            validator: (value) {
        //              if (value.isEmpty) {
        //                return 'Please provide Customer Email';
        //              }
        //              return null;
        //            },
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(20),
                      hintText: 'Customer Email',
                      hintStyle: TextStyle(color: Colors.grey),
                    ),
                    onChanged: (text) {
                      widget.customerData.customerEmail = text;
                    },
                  ),
                  new TextFormField(
                    controller: _custAddressLine1Controller,
                    textAlign: TextAlign.left,
        //            validator: (value) {
        //              if (value.isEmpty) {
        //                return 'Please provide Customer Address Line 1';
        //              }
        //              return null;
        //            },
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(20),
                      hintText: 'Customer Address Line 1',
                      hintStyle: TextStyle(color: Colors.grey),
                    ),
                    onChanged: (text) {
                      widget.customerData.customerAddressLine1 = text;
                    },
                  ),
                  new TextFormField(
                    controller: _custAddressLine2Controller,
                    textAlign: TextAlign.left,
        //            validator: (value) {
        //              if (value.isEmpty) {
        //                return 'Please provide Customer Address Line 2';
        //              }
        //              return null;
        //            },
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(20),
                      hintText: 'Customer Address Line 2',
                      hintStyle: TextStyle(color: Colors.grey),
                    ),
                    onChanged: (text) {
                      widget.customerData.customerAddressLine2 = text;
                    },
                  ),
                  new TextFormField(
                    controller: _custCityController,
                    textAlign: TextAlign.left,
        //            validator: (value) {
        //              if (value.isEmpty) {
        //                return 'Please provide Customer City';
        //              }
        //              return null;
        //            },
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(20),
                      hintText: 'Customer City',
                      hintStyle: TextStyle(color: Colors.grey),
                    ),
                    onChanged: (text) {
                      widget.customerData.customerCity = text;
                    },
                  ),
                  new TextFormField(
                    controller: _custStateController,
                    textAlign: TextAlign.left,
        //            validator: (value) {
        //              if (value.isEmpty) {
        //                return 'Please provide Customer State';
        //              }
        //              return null;
        //            },
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(20),
                      hintText: 'Customer State',
                      hintStyle: TextStyle(color: Colors.grey),
                    ),
                    onChanged: (text) {
                      widget.customerData.customerState = text;
                    },
                  ),
                  new TextFormField(
                    controller: _custZipCodeController,
                    textAlign: TextAlign.left,
        //            validator: (value) {
        //              if (value.isEmpty) {
        //                return 'Please provide Customer Zip Code';
        //              }
        //              return null;
        //            },
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(20),
                      hintText: 'Customer Zip Code',
                      hintStyle: TextStyle(color: Colors.grey),
                    ),
                    onChanged: (text) {
                      widget.customerData.customerZipCode = int.tryParse(text);
                    },
                  ),
                  new TextFormField(
                    controller: _truckLicensePlateController,
                    textAlign: TextAlign.left,
        //            validator: (value) {
        //              if (value.isEmpty) {
        //                return 'Please provide Truck License Plate';
        //              }
        //              return null;
        //            },
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(20),
                      hintText: 'Truck License Plate',
                      hintStyle: TextStyle(color: Colors.grey),
                    ),
                    onChanged: (text) {
                      widget.customerData.truckLicensePlate = text;
                    },
                  ),
                  new TextFormField(
                    controller: _trailerLicensePlateController,
                    textAlign: TextAlign.left,
        //            validator: (value) {
        //              if (value.isEmpty) {
        //                return 'Please provide Trailer License Plate';
        //              }
        //              return null;
        //            },
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(20),
                      hintText: 'Trailer License Plate',
                      hintStyle: TextStyle(color: Colors.grey),
                    ),
                    onChanged: (text) {
                      widget.customerData.trailerLicensePlate = text;
                    },
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      RaisedButton(
                        child: Text('Begin Full Test'),
                      onPressed: () {
                          // Validate returns true if the form is valid, or false
                          // otherwise.
                          if (_formKey.currentState.validate()) {
                            // Update global singleton
                            widget.globalHelper.customerData = widget.customerData;

                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => TruckTestingPage(
                                    custData: widget.customerData,
                                  )
                              ),
                            );
                          }
                        }
                      ),
                      RaisedButton(
                        child: Text('Begin Trailer Testing'),
                        onPressed: () {
                          // If no bluetooth has been initialized, don't allow
                          // testing to begin.

                          // Validate returns true if the form is valid, or false
                          // otherwise.
                          if (_formKey.currentState.validate()) {
                            // Update global singleton
                            widget.globalHelper.customerData = widget.customerData;

                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => TrailerTestingPage(
                                  widget.customerData,
                                )
                              ),
                            );
                          }
                        }
                      )
                    ]
                  )
                ]
              )
            )
          ]
        )
      )
    );
  }
}