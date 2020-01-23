import 'package:HITCH/trailertestingpage.dart';
import 'package:flutter/material.dart';
import 'package:HITCH/datastorage.dart';

class TruckTestingPage extends StatelessWidget {
  final CustomerData customerData;

  TruckTestingPage({this.customerData});

  @override
  Widget build (BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Truck Testing"),
      ),
      body: Center(
        child: Container(
          child: Column(
            children: <Widget>[
              Text('Customer Name: ${customerData.custName}'),
              Text('Customer Phone: ${customerData.custPhoneNumber}'),
              Text('Customer Email: ${customerData.custEmail}'),
              Text('Customer Address Line 1: ${customerData.custAddressLine1}'),
              Text('Customer Address Line 2: ${customerData.custAddressLine2}'),
              Text('Customer City: ${customerData.custCity}'),
              Text('Customer State: ${customerData.custState}'),
              Text('Customer Zip Code: ${customerData.custZipCode}'),
              Text('Truck License Plate: ${customerData.truckLicensePlate}'),
              Text('Trailer License Plate: ${customerData.trailerLicensePlate}'),
              RaisedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => TrailerTestingPage(
                        customerData: customerData,
                      ),
                    ),
                  );
                }, // onPressed
                child: Text('Begin Trailer Testing'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}