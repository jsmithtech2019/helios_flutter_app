/*
 * Texas A&M University
 * Electronic Systems Engineering Technology
 * ESET-420 Engineering Technology Senior Design II
 * File: testing_truck.dart
 * Author: Jack Smith (john.d.smitherton@tamu.edu)
 */

// Flutter Packages
import 'dart:io';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:get_it/get_it.dart';

// Models
import 'package:HITCH/models/customer_data.dart';
import 'package:HITCH/models/global.dart';
import 'package:HITCH/models/truck_data.dart';

// Screens
import 'package:HITCH/screens/testing_complete.dart';
import 'package:HITCH/screens/testing_trailer.dart';

// Utils
import 'package:HITCH/utils/database_helper.dart';

/// Create a stateful Truck Page
class TruckTestingPage extends StatefulWidget{
  /// Create singleton instance of [DatabaseHelper]
  final DatabaseHelper dbHelper = GetIt.instance<DatabaseHelper>();

  /// Create singleton instance of [GlobalHelper]
  final GlobalHelper globalHelper = GetIt.instance<GlobalHelper>();

  /// Create singleton instance of [BluetoothDevice]
  final BluetoothDevice device = GetIt.instance<BluetoothDevice>();

  /// Initialize a customer data object
  final CustomerData custData;

  /// Initialize empty [TruckTestData] object
  TruckTestData truckData = new TruckTestData.emptyConst();

  /// Default constructor
  TruckTestingPage({this.custData});

  @override
  State<StatefulWidget> createState() {
    return TruckTestingPageState();
  }
}

class TruckTestingPageState extends State<TruckTestingPage>{
  Future leftTurnSignal, rightTurnSignal, tailLights, reverseLights;
  @override
  void initState() {
    super.initState();
    leftTurnSignal = _getLeftTurnSignal();
    rightTurnSignal = _getRightTurnSignal();
    tailLights = _getTailLights();
    reverseLights = _getReverseLights();
  }

  /// Specify async object waiting for left turn signal result
  /// 
  /// Will draw the right turn signal instruction after receiving result.
  _getLeftTurnSignal() async {
    var services = await widget.device.discoverServices();
    var initial = await services[1].characteristics[0].read();
    await services[1].characteristics[0].write([Random().nextInt(3), Random().nextInt(255)]);

    for(int i = 0; i < 200; i++){
      var resp = await services[1].characteristics[0].read();
      if(initial[1] != resp[1]){
        print('Resp[0]: ${resp[0]}\nResp[1]: ${resp[1]}');
        var firsthalf = resp[0].toString();
        var secondhalf = resp[1].toString();

        // The doubles are split in half so combine them
        var combined = double.parse('$firsthalf.$secondhalf');
        widget.truckData.truckTest1Current = combined;
        if(combined >= 1.5 || combined < .5){
          widget.truckData.truckTest1Result = 0;
          return 'Result: Fail\nCurrent: ${combined}A';
        }
        widget.truckData.truckTest1Result = 1;
        return 'Result: Pass\nCurrent: ${combined}A';
      }
      sleep(Duration(microseconds: 100));
    }
    return 'Error Retrieving Data';
  }

  /// Specify async object waiting for right turn signal result
  /// 
  /// Will draw the tail lights instruction after receiving result.
  _getRightTurnSignal() async {
    var services = await widget.device.discoverServices();
    var initial = await services[1].characteristics[1].read();
    await services[1].characteristics[1].write([Random().nextInt(3), Random().nextInt(255)]);

    for(int i = 0; i < 200; i++){
      var resp = await services[1].characteristics[1].read();

      if(initial[1] != resp[1]){
        var firsthalf = resp[0].toString();
        var secondhalf = resp[1].toString();

        // The doubles are split in half so combine them
        var combined = double.parse('$firsthalf.$secondhalf');
        widget.truckData.truckTest2Current = combined;
        if(combined >= 1.5 || combined < .5){
          widget.truckData.truckTest2Result = 0;
          return 'Result: Fail\nCurrent: ${combined}A';
        }
        widget.truckData.truckTest2Result = 1;
        return 'Result: Pass\nCurrent: ${combined}A';
      }
      sleep(Duration(microseconds: 100));
    }
    return 'Error Retrieving Data';
  }

  /// Specify async object waiting for tail lights result
  /// 
  /// Will draw the reverse lights instruction after receiving result.
  _getTailLights() async {
    var services = await widget.device.discoverServices();
    var initial = await services[1].characteristics[2].read();
    await services[1].characteristics[2].write([Random().nextInt(3), Random().nextInt(255)]);

    for(int i = 0; i < 200; i++){
      var resp = await services[1].characteristics[2].read();
      if(initial[1] != resp[1]){
        print('Resp[0]: ${resp[0]}\nResp[1]: ${resp[1]}');
        var firsthalf = resp[0].toString();
        var secondhalf = resp[1].toString();

        // The doubles are split in half so combine them
        var combined = double.parse('$firsthalf.$secondhalf');
        widget.truckData.truckTest3Current = combined;
        if(combined >= 1.5 || combined < .5){
          widget.truckData.truckTest3Result = 0;
          return 'Result: Fail\nCurrent: ${combined}A';
        }
        widget.truckData.truckTest3Result = 1;
        return 'Result: Pass\nCurrent: ${combined}A';
      }
      sleep(Duration(microseconds: 100));
    }
    return 'Error Retrieving Data';
  }

  /// Specify async object waiting for reverse lights result
  /// 
  /// Will draw the testing complete continue button after receiving result.
  _getReverseLights() async {
    var services = await widget.device.discoverServices();
    var initial = await services[1].characteristics[3].read();
    await services[1].characteristics[3].write([Random().nextInt(3), Random().nextInt(255)]);

    for(int i = 0; i < 200; i++){
      var resp = await services[1].characteristics[3].read();
      if(initial[1] != resp[1]){
        print('Resp[0]: ${resp[0]}\nResp[1]: ${resp[1]}');
        var firsthalf = resp[0].toString();
        var secondhalf = resp[1].toString();

        // The doubles are split in half so combine them
        var combined = double.parse('$firsthalf.$secondhalf');
        widget.truckData.truckTest4Current = combined;
        if(combined >= 1.5 || combined < .5){
          widget.truckData.truckTest4Result = 0;
          return 'Result: Fail\nCurrent: ${combined}A';
        }
        widget.truckData.truckTest4Result = 1;
        return 'Result: Pass\nCurrent: ${combined}A';
      }
      sleep(Duration(microseconds: 100));
    }
    return 'Error Retrieving Data';
  }

  @override
  Widget build (BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Truck Testing"),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            margin: EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text("Testing for customer: ${widget.globalHelper.customerData.customerName}", 
                  style: TextStyle(
                    fontSize: 20,
                    fontStyle: FontStyle.italic
                  )
                ),
                SizedBox(height: 10),
                Divider(
                  thickness: 5,
                  color: Colors.grey,
                ),
                SizedBox(height: 10),
                Text('Please press the brakes\n(Left Turn Signal)',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold
                  )
                ),
                SizedBox(height: 10),
                FutureBuilder(
                  future: leftTurnSignal,
                  builder: (context, snapshot) {
                    if (! snapshot.hasData){
                      return Text('');
                    } else {
                      var resultcolor = Colors.white;
                      if (snapshot.data.toString().contains('Fail')) {
                        resultcolor = Colors.red;
                      }
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text('${snapshot.data}',
                            style: TextStyle(
                              fontSize: 20,
                              color: resultcolor,
                              fontStyle: FontStyle.italic
                            ),
                          ),
                          SizedBox(height: 10),
                          Divider(
                            thickness: 2,
                            color: Colors.grey,
                          ),
                          SizedBox(height: 10),
                          Text('Please press the brakes\n(Right Turn Signal)',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold
                            )
                          ),
                          SizedBox(height: 10),
                        ],
                      );
                    }
                  }
                ),
                FutureBuilder(
                  future: rightTurnSignal,
                  builder: (context, snapshot) {
                    if (! snapshot.hasData){
                      return Text('');
                    } else {
                      var resultcolor = Colors.white;
                      if (snapshot.data.toString().contains('Fail')) {
                        resultcolor = Colors.red;
                      }
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text('${snapshot.data}',
                            style: TextStyle(
                              fontSize: 20,
                              color: resultcolor,
                              fontStyle: FontStyle.italic
                            ),
                          ),
                          SizedBox(height: 10),
                          Divider(
                            thickness: 2,
                            color: Colors.grey,
                          ),
                          SizedBox(height: 10),
                          Text('Please turn on the headlights\n(Tail Lights)',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold
                            )
                          ),
                          SizedBox(height: 10),
                        ],
                      );
                    }
                  }
                ),
                FutureBuilder(
                  future: tailLights,
                  builder: (context, snapshot) {
                    if (! snapshot.hasData){
                      return Text('');
                    } else {
                      var resultcolor = Colors.white;
                      if (snapshot.data.toString().contains('Fail')) {
                        resultcolor = Colors.red;
                      }
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text('${snapshot.data}',
                            style: TextStyle(
                              fontSize: 20,
                              color: resultcolor,
                              fontStyle: FontStyle.italic
                            ),
                          ),
                          SizedBox(height: 10),
                          Divider(
                            thickness: 2,
                            color: Colors.grey,
                          ),
                          SizedBox(height: 10),
                          Text('Please shift into reverse\n(Reverse Lights)',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold
                            )
                          ),
                          SizedBox(height: 10),
                        ],
                      );
                    }
                  }
                ),
                FutureBuilder(
                  future: reverseLights,
                  builder: (context, snapshot) {
                    if (! snapshot.hasData){
                      return Text('');
                    } else {
                      var resultcolor = Colors.white;
                      if (snapshot.data.toString().contains('Fail')) {
                        resultcolor = Colors.red;
                      }
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text('${snapshot.data}',
                            style: TextStyle(
                              fontSize: 20,
                              color: resultcolor,
                              fontStyle: FontStyle.italic
                            ),
                          ),
                          SizedBox(height: 10),
                          Divider(
                            thickness: 2,
                            color: Colors.grey,
                          ),
                          SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              RaisedButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => TrailerTestingPage(
                                        widget.custData,
                                        widget.truckData
                                      ),
                                    ),
                                  );
                                }, // onPressed
                                child: Text('Begin Trailer Testing'),
                              ),
                              RaisedButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => TestingCompletePage(
                                        widget.custData,
                                        widget.truckData
                                      ),
                                    ),
                                  );
                                }, // onPressed
                                child: Text('End Testing'),
                              ),
                            ],
                          )
                        ],
                      );
                    }
                  }
                ),
              ],
            ),
          ),
        ),
      )
    );
  }
}
