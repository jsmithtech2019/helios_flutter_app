import 'package:flutter/material.dart';
import 'package:HITCH/screens/testing_trailer.dart';
import 'package:HITCH/screens/testing_truck.dart';
import 'package:HITCH/models/database.dart';
import 'package:HITCH/utils/database_helper.dart';

// Define a custom Form widget.
class MyCustomForm extends StatefulWidget {
  @override
  MyCustomFormState createState() {
    return MyCustomFormState();
  }
}

// Define a corresponding State class.
// This class holds data related to the form.
class MyCustomFormState extends State<MyCustomForm> {
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  //
  // Note: This is a `GlobalKey<FormState>`,
  // not a GlobalKey<MyCustomFormState>.
  final _formKey = GlobalKey<FormState>();

  final DatabaseHelper helper = DatabaseHelper();

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
                    helper.initializeDatabase().then((onValue){print("Done initializing");});
                    helper.insertCustomerData(custData);
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
                    helper.insertCustomerData(custData);
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

