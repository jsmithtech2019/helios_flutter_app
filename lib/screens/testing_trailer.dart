/*
 * Texas A&M University
 * Electronic Systems Engineering Technology
 * ESET-420 Engineering Technology Senior Design II
 * File: testing_trailer.dart
 * Author: Jack Smith (john.d.smitherton@tamu.edu)
 */

// Flutter Packages
import 'dart:io';
import 'dart:math';

import 'package:HITCH/models/customer_data.dart';
import 'package:HITCH/models/global.dart';
import 'package:HITCH/models/trailer_data.dart';
import 'package:HITCH/models/truck_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:get_it/get_it.dart';

// Models
//import 'package:HITCH/models/seperator.dart';

// Screens
import 'package:HITCH/screens/testing_complete.dart';

// Utils
import 'package:HITCH/utils/database_helper.dart';

/// Create a stateful Trailer Page
class TrailerTestingPage extends StatefulWidget {
  /// Create singleton instance of [DatabaseHelper]
  final DatabaseHelper dbHelper = GetIt.instance<DatabaseHelper>();

  /// Create singleton instance of [GlobalHelper]
  final GlobalHelper globalHelper = GetIt.instance<GlobalHelper>();

  /// Create singleton instance of [BluetoothDevice]
  final BluetoothDevice device = GetIt.instance<BluetoothDevice>();

  // TODO: enable this
  // final BluetoothHelper btHelper = GetIt.instance<BluetoothHelper>();

  /// Initialize a customer data object
  CustomerData custData;

  /// Initialize empty [TruckTestData] object
  TruckTestData truckData = new TruckTestData.emptyConst();

  /// Initialize empty [TrailerTestData] object
  TrailerTestData trailerData = new TrailerTestData.emptyConst();

  /// Default constructor
  /// 
  /// Takes CustomerData object [cd] and optional TruckTestData [truckd] to initialize
  /// the state
  TrailerTestingPage(CustomerData cd, [TruckTestData truckd]){
    this.custData = cd;
    if(truckd != null){
      this.truckData = truckd;
    }
  }

  @override
  State<StatefulWidget> createState() {
    return TrailerTestingPageState();
  }
}

/// Create state of testing page
class TrailerTestingPageState extends State<TrailerTestingPage> {
  /// Create futures for each test case
  Future leftTurnSignal, rightTurnSignal, tailLights, reverseLights;

  /// Create booleans to handle when objects draw
  bool one, two, three = false;

  /// Specify the maximum allowed passing current value
  static const int CURRENT_MAX = 2;

  /// Specify the minimum allowed passing current value
  static const double CURRENT_MIN = .5;

  /// Initialize the state of the object and call future objects
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
    // TODO: send enable relay and test 1
    var services = await widget.device.discoverServices();
    var initial = await services[1].characteristics[4].read();
    await services[1].characteristics[4].write([Random().nextInt(4), Random().nextInt(255)]);

    for(int i = 0; i < 200; i++){
      var resp = await services[1].characteristics[4].read();
      if(initial[1] != resp[1]){
        var firsthalf = resp[0].toString();
        var secondhalf = resp[1].toString();

        // The doubles are split in half so combine them
        var combined = double.parse('$firsthalf.$secondhalf');
        widget.trailerData.trailerTest1Current = combined;
        if(combined >= CURRENT_MAX || combined < CURRENT_MIN){
          widget.trailerData.trailerTest1Result = 0;
          return 'Result: Fail\nCurrent: ${combined}A';
        }
        widget.trailerData.trailerTest1Result = 1;
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
    // TODO: send enable relay and test 2
    var services = await widget.device.discoverServices();
    var initial = await services[1].characteristics[5].read();
    await services[1].characteristics[5].write([Random().nextInt(4), Random().nextInt(255)]);

    for(int i = 0; i < 200; i++){
      var resp = await services[1].characteristics[5].read();
      if(initial[1] != resp[1]){
        var firsthalf = resp[0].toString();
        var secondhalf = resp[1].toString();

        // The doubles are split in half so combine them
        var combined = double.parse('$firsthalf.$secondhalf');
        widget.trailerData.trailerTest2Current = combined;
        if(combined >= CURRENT_MAX || combined < CURRENT_MIN){
          widget.trailerData.trailerTest2Result = 0;
          return 'Result: Fail\nCurrent: ${combined}A';
        }
        widget.trailerData.trailerTest2Result = 1;
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
    // TODO: send enable relay and test 3
    var services = await widget.device.discoverServices();
    var initial = await services[1].characteristics[6].read();
    await services[1].characteristics[6].write([Random().nextInt(4), Random().nextInt(255)]);

    for(int i = 0; i < 200; i++){
      var resp = await services[1].characteristics[6].read();
      if(initial[1] != resp[1]){
        var firsthalf = resp[0].toString();
        var secondhalf = resp[1].toString();

        // The doubles are split in half so combine them
        var combined = double.parse('$firsthalf.$secondhalf');
        widget.trailerData.trailerTest3Current = combined;
        if(combined >= CURRENT_MAX || combined < CURRENT_MIN){
          widget.trailerData.trailerTest3Result = 0;
          return 'Result: Fail\nCurrent: ${combined}A';
        }
        widget.trailerData.trailerTest3Result = 1;
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
    // TODO: send enable relay and test 3
    var services = await widget.device.discoverServices();
    var initial = await services[1].characteristics[7].read();
    await services[1].characteristics[7].write([Random().nextInt(4), Random().nextInt(4)]);

    for(int i = 0; i < 200; i++){
      var resp = await services[1].characteristics[7].read();
      if(initial[1] != resp[1]){
        var firsthalf = resp[0].toString();
        var secondhalf = resp[1].toString();

        // The doubles are split in half so combine them
        var combined = double.parse('$firsthalf.$secondhalf');
        widget.trailerData.trailerTest4Current = combined;
        if(combined >= CURRENT_MAX || combined < CURRENT_MIN){
          widget.trailerData.trailerTest4Result = 0;
          return 'Result: Fail\nCurrent: ${combined}A';
        }
        widget.trailerData.trailerTest4Result = 1;
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
        title: new Text("Trailer Testing"),
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
                Text('Left Turn Signal',
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
                      one = true;
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
                          Text('Right Turn Signal',
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
                          Text('Tail Lights',
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
                          Text('Reverse Lights',
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
                                      builder: (context) => TestingCompletePage(
                                        widget.custData,
                                        widget.truckData,
                                        widget.trailerData,
                                      ),
                                    ),
                                  );
                                }, // onPressed
                                child: Text('Finish Testing'),
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
  // @override
  // Widget build (BuildContext context) {
  //   return new Scaffold(
  //     appBar: new AppBar(
  //       title: new Text("Trailer Testing"),
  //     ),
  //     body: Center(
  //       child: Container(
  //         margin: EdgeInsets.all(20),
  //         child: Column(
  //           children: <Widget>[
  //             Column(
  //               crossAxisAlignment: CrossAxisAlignment.start,
  //               children: <Widget>[
  //                 Text("Testing for customer: ${widget.globalHelper.customerName}", 
  //                   style: TextStyle(
  //                     fontSize: 20,
  //                     fontStyle: FontStyle.italic
  //                   )
  //                 ),
  //               ],
  //             ),
  //             SizedBox(height: 15),
  //             RaisedButton(
  //               onPressed: () {
  //                 Navigator.push(
  //                   context,
  //                   MaterialPageRoute(
  //                     builder: (context) => TestingCompletePage(widget.custData),
  //                   ),
  //                 );
  //               }, // onPressed
  //               child: Text('Finish Testing'),
  //             ),
  //           ],
  //         ),
  //       ),
  //     ),
  //   );
  // }
}