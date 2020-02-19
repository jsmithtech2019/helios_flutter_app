// Flutter Packages
//import 'dart:io';

import 'package:HITCH/models/global.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

// Models
import 'package:HITCH/models/database.dart';

// Screens
import 'package:HITCH/screens/testing_trailer.dart';
import 'package:HITCH/screens/testing_truck.dart';

// Utils
import 'package:HITCH/utils/database_helper.dart';
import 'package:HITCH/utils/home_widget.dart';

// Define a custom Form widget.
class CustomerForm extends StatefulWidget {
  @override
  CustomerFormState createState() {
    return CustomerFormState();
  }
}

// Define a corresponding State class.
// This class holds data related to the form.
class CustomerFormState extends State<CustomerForm> {
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  //
  // Note: This is a `GlobalKey<FormState>`,
  // not a GlobalKey<MyCustomFormState>.
  final _formKey = GlobalKey<FormState>();

  // Pull GetIt Singleton and create pointers to Singleton Helpers
  final DatabaseHelper dbHelper = GetIt.instance<DatabaseHelper>();
  final GlobalHelper globalHelper = GetIt.instance<GlobalHelper>();

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    TextEditingController custNameController = new TextEditingController();
    TextEditingController custPhoneController = new TextEditingController();
    TextEditingController custEmailController = new TextEditingController();
    TextEditingController custAddressLine1Controller = new TextEditingController();
    TextEditingController custAddressLine2Controller = new TextEditingController();
    TextEditingController custCityController = new TextEditingController();
    TextEditingController custStateController = new TextEditingController();
    TextEditingController custZipCodeController = new TextEditingController();
    TextEditingController truckLicensePlateController = new TextEditingController();
    TextEditingController trailerLicensePlateController = new TextEditingController();

    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          new TextFormField(
            controller: custNameController,
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
          ),
          new TextFormField(
            controller: custPhoneController,
            textAlign: TextAlign.left,
//            validator: (value) {
//              if (value.isEmpty) {
//                return 'Please provide Customer Phone Number';
//              }
//              return null;
//            },
            decoration: InputDecoration(
              contentPadding: EdgeInsets.all(20),
              hintText: 'Customer Phone Number',
              hintStyle: TextStyle(color: Colors.grey),
            ),
          ),
          new TextFormField(
            controller: custEmailController,
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
          ),
          new TextFormField(
            controller: custAddressLine1Controller,
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
          ),
          new TextFormField(
            controller: custAddressLine2Controller,
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
          ),
          new TextFormField(
            controller: custCityController,
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
          ),
          new TextFormField(
            controller: custStateController,
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
          ),
          new TextFormField(
            controller: custZipCodeController,
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
          ),
          new TextFormField(
            controller: truckLicensePlateController,
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
          ),
          new TextFormField(
            controller: trailerLicensePlateController,
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
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              RaisedButton(
                onPressed: () {
                  // Validate returns true if the form is valid, or false
                  // otherwise.
                  if (_formKey.currentState.validate()) {
                    // If the form is valid, display a Snackbar.
                    final custData = CustomerData(
                        custNameController.text,
                        custPhoneController.text,
                        custEmailController.text,
                        custAddressLine1Controller.text,
                        custAddressLine2Controller.text,
                        custCityController.text,
                        custStateController.text,
                        int.tryParse(custZipCodeController.text),
                        truckLicensePlateController.text,
                        trailerLicensePlateController.text
                    );
                    // dbHelper.insertCustomerData(custData);
                    Scaffold.of(context)
                        .showSnackBar(SnackBar(content: Text('Processing Data')));
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => TruckTestingPage(
                            custData: custData,
                          )
                      ),
                    );
                  } // if
                }, // onPressed
                child: Text('Begin Full Test'),
              ),
              RaisedButton(
                onPressed: () {
                  // Validate returns true if the form is valid, or false
                  // otherwise.
                  if (_formKey.currentState.validate()) {
                    // If the form is valid, display a Snackbar.
                    final custData = CustomerData(
                        custNameController.text,
                        custPhoneController.text,
                        custEmailController.text,
                        custAddressLine1Controller.text,
                        custAddressLine2Controller.text,
                        custCityController.text,
                        custStateController.text,
                        int.tryParse(custZipCodeController.text),
                        truckLicensePlateController.text,
                        trailerLicensePlateController.text
                    );
                    dbHelper.insertCustomerData(custData);
                    Scaffold.of(context)
                        .showSnackBar(SnackBar(content: Text('Processing Data')));
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => TrailerTestingPage(
                            custData: custData,
                          )
                      ),
                    );
                  } // if
                }, // onPressed
                child: Text('Begin Trailer Testing'),
              ),
            ],
          )
        ],
      ),
    );
  }
}

// Define a custom Form widget.
class EmployeeForm extends StatefulWidget {
  @override
  EmployeeFormState createState() {
    return EmployeeFormState();
  }
}

// Define a corresponding State class.
// This class holds data related to the form.
class EmployeeFormState extends State<EmployeeForm> {
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  //
  // Note: This is a `GlobalKey<FormState>`,
  // not a GlobalKey<MyCustomFormState>.
  final _formKey = GlobalKey<FormState>();

  // Pull GetIt Singleton and create pointers to Singleton Helpers
  final DatabaseHelper dbHelper = GetIt.instance<DatabaseHelper>();

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    TextEditingController employeeNameController = new TextEditingController();
    TextEditingController employeePhoneNumberController = new TextEditingController();
    TextEditingController employeeEmailController = new TextEditingController();
    TextEditingController employeePassController = new TextEditingController();
    TextEditingController moduleID = new TextEditingController();
    TextEditingController dealership = new TextEditingController();
    TextEditingController dealershipUUID = new TextEditingController();
    TextEditingController employeeUUIDController = new TextEditingController();

    return Form(
        key: _formKey,
        child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          new TextFormField(
            controller: employeeNameController,
            textAlign: TextAlign.left,
//            validator: (value) {
//              if (value.isEmpty) {
//                return 'Please provide Trailer License Plate';
//              }
//              return null;
//            },
            decoration: InputDecoration(
              contentPadding: EdgeInsets.all(20),
              hintText: 'Employee Name',
              hintStyle: TextStyle(color: Colors.grey),
            ),
          ),
          new TextFormField(
            controller: employeePhoneNumberController,
            textAlign: TextAlign.left,
//            validator: (value) {
//              if (value.isEmpty) {
//                return 'Please provide Trailer License Plate';
//              }
//              return null;
//            },
            decoration: InputDecoration(
              contentPadding: EdgeInsets.all(20),
              hintText: 'Employee Phone Number',
              hintStyle: TextStyle(color: Colors.grey),
            ),
          ),
          new TextFormField(
            controller: employeeEmailController,
            textAlign: TextAlign.left,
//            validator: (value) {
//              if (value.isEmpty) {
//                return 'Please provide Trailer License Plate';
//              }
//              return null;
//            },
            decoration: InputDecoration(
              contentPadding: EdgeInsets.all(20),
              hintText: 'Employee Email',
              hintStyle: TextStyle(color: Colors.grey),
            ),
          ),
          new TextFormField(
            controller: employeePassController,
            textAlign: TextAlign.left,
//            validator: (value) {
//              if (value.isEmpty) {
//                return 'Please provide Trailer License Plate';
//              }
//              return null;
//            },
            obscureText: true,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.all(20),
              hintText: 'Employee Password',
              hintStyle: TextStyle(color: Colors.grey),
            ),
          ),
          new TextFormField(
            controller: moduleID,
            textAlign: TextAlign.left,
//            validator: (value) {
//              if (value.isEmpty) {
//                return 'Please provide Trailer License Plate';
//              }
//              return null;
//            },
            decoration: InputDecoration(
              contentPadding: EdgeInsets.all(20),
              hintText: 'Module ID',
              hintStyle: TextStyle(color: Colors.grey),
            ),
          ),
          new TextFormField(
            controller: dealership,
            textAlign: TextAlign.left,
//            validator: (value) {
//              if (value.isEmpty) {
//                return 'Please provide Trailer License Plate';
//              }
//              return null;
//            },
            decoration: InputDecoration(
              contentPadding: EdgeInsets.all(20),
              hintText: 'Dealership',
              hintStyle: TextStyle(color: Colors.grey),
            ),
          ),
          new TextFormField(
            controller: dealershipUUID,
            textAlign: TextAlign.left,
//            validator: (value) {
//              if (value.isEmpty) {
//                return 'Please provide Trailer License Plate';
//              }
//              return null;
//            },
            decoration: InputDecoration(
              contentPadding: EdgeInsets.all(20),
              hintText: 'Dealership UUID',
              hintStyle: TextStyle(color: Colors.grey),
            ),
          ),
          new TextFormField(
            controller: employeeUUIDController,
            textAlign: TextAlign.left,
//            validator: (value) {
//              if (value.isEmpty) {
//                return 'Please provide Trailer License Plate';
//              }
//              return null;
//            },
            decoration: InputDecoration(
              contentPadding: EdgeInsets.all(20),
              hintText: 'Employee UUID',
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
                  moduleID.text,
                  dealership.text,
                  dealershipUUID.text,
                );

                // Update global singleton
                GlobalHelper globalHelper = GetIt.instance<GlobalHelper>();
                globalHelper.dealership = dealership.text;
                globalHelper.dealershipUUID = dealershipUUID.text;
                globalHelper.employeeEmail = employeeEmailController.text;
                globalHelper.employeePhone = employeePhoneNumberController.text;
                globalHelper.employeeName = employeeNameController.text;
                globalHelper.employeeUUID = employeeUUIDController.text;

                //dbHelper.initializeDatabase().then((onValue){print("Done initializing");});
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
    );
  }
}