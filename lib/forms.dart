import 'package:flutter/material.dart';
import 'package:HITCH/trucktestingpage.dart';
import 'package:HITCH/datastorage.dart';

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
          ),
          new TextFormField(
            controller: custEmailController,
            textAlign: TextAlign.left,
            validator: (value) {
              if (value.isEmpty) {
                return 'Please provide Customer Email';
              }
              return null;
            },
            decoration: InputDecoration(
              contentPadding: EdgeInsets.all(20),
              hintText: 'Customer Email',
              hintStyle: TextStyle(color: Colors.grey),
            ),
          ),
          new TextFormField(
            controller: custAddressLine1Controller,
            textAlign: TextAlign.left,
            validator: (value) {
              if (value.isEmpty) {
                return 'Please provide Customer Address Line 1';
              }
              return null;
            },
            decoration: InputDecoration(
              contentPadding: EdgeInsets.all(20),
              hintText: 'Customer Address Line 1',
              hintStyle: TextStyle(color: Colors.grey),
            ),
          ),
          new TextFormField(
            controller: custAddressLine2Controller,
            textAlign: TextAlign.left,
            validator: (value) {
              if (value.isEmpty) {
                return 'Please provide Customer Address Line 2';
              }
              return null;
            },
            decoration: InputDecoration(
              contentPadding: EdgeInsets.all(20),
              hintText: 'Customer Address Line 2',
              hintStyle: TextStyle(color: Colors.grey),
            ),
          ),
          new TextFormField(
            controller: custCityController,
            textAlign: TextAlign.left,
            validator: (value) {
              if (value.isEmpty) {
                return 'Please provide Customer City';
              }
              return null;
            },
            decoration: InputDecoration(
              contentPadding: EdgeInsets.all(20),
              hintText: 'Customer City',
              hintStyle: TextStyle(color: Colors.grey),
            ),
          ),
          new TextFormField(
            controller: custStateController,
            textAlign: TextAlign.left,
            validator: (value) {
              if (value.isEmpty) {
                return 'Please provide Customer State';
              }
              return null;
            },
            decoration: InputDecoration(
              contentPadding: EdgeInsets.all(20),
              hintText: 'Customer State',
              hintStyle: TextStyle(color: Colors.grey),
            ),
          ),
          new TextFormField(
            controller: custZipCodeController,
            textAlign: TextAlign.left,
            validator: (value) {
              if (value.isEmpty) {
                return 'Please provide Customer Zip Code';
              }
              return null;
            },
            decoration: InputDecoration(
              contentPadding: EdgeInsets.all(20),
              hintText: 'Customer Zip Code',
              hintStyle: TextStyle(color: Colors.grey),
            ),
          ),
          new TextFormField(
            controller: truckLicensePlateController,
            textAlign: TextAlign.left,
            validator: (value) {
              if (value.isEmpty) {
                return 'Please provide Truck License Plate';
              }
              return null;
            },
            decoration: InputDecoration(
              contentPadding: EdgeInsets.all(20),
              hintText: 'Truck License Plate',
              hintStyle: TextStyle(color: Colors.grey),
            ),
          ),
          new TextFormField(
            controller: trailerLicensePlateController,
            textAlign: TextAlign.left,
            validator: (value) {
              if (value.isEmpty) {
                return 'Please provide Trailer License Plate';
              }
              return null;
            },
            decoration: InputDecoration(
              contentPadding: EdgeInsets.all(20),
              hintText: 'Trailer License Plate',
              hintStyle: TextStyle(color: Colors.grey),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: RaisedButton(
              onPressed: () {
                // Validate returns true if the form is valid, or false
                // otherwise.
                if (_formKey.currentState.validate()) {
                  // If the form is valid, display a Snackbar.
                  final customerData = CustomerData(
                    custName: custNameController.text,
                    custPhoneNumber: custPhoneController.text,
                    custEmail: custEmailController.text,
                    custAddressLine1: custAddressLine1Controller.text,
                    custAddressLine2: custAddressLine2Controller.text,
                    custCity: custCityController.text,
                    custState: custStateController.text,
                    custZipCode: custZipCodeController.text,
                    truckLicensePlate: truckLicensePlateController.text,
                    trailerLicensePlate: trailerLicensePlateController.text
                  );
                  Scaffold.of(context)
                      .showSnackBar(SnackBar(content: Text('Processing Data')));
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => TruckTestingPage(
                        customerData: customerData,
                      )
                    ),
                  );
                } // if
              }, // onPressed
              child: Text('Begin Testing'),
            ),
          ),
        ],
      ),
    );
  }
}

