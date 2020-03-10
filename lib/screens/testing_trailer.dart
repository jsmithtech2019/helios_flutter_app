// Flutter Packages
import 'dart:io';
import 'dart:math';

import 'package:HITCH/models/global.dart';
import 'package:HITCH/models/print.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:get_it/get_it.dart';
import 'package:synchronized/synchronized.dart';

// Models
import 'package:HITCH/models/database.dart';
//import 'package:HITCH/models/seperator.dart';

// Screens
import 'package:HITCH/screens/testing_complete.dart';

// Utils
import 'package:HITCH/utils/database_helper.dart';



class TrailerTestingPage extends StatefulWidget {
  // Pull GetIt Singleton and create pointers to Singleton Helpers
  final DatabaseHelper dbHelper = GetIt.instance<DatabaseHelper>();
  final GlobalHelper globalHelper = GetIt.instance<GlobalHelper>();
  final BluetoothDevice device = GetIt.instance<BluetoothDevice>();
  // TODO: enable this
  // final BluetoothHelper btHelper = GetIt.instance<BluetoothHelper>();

  CustomerData custData;
  TruckTestData truckData = new TruckTestData(-1, -1, -1, -1, 0, 0, 0, 0);
  TrailerTestData trailerData = new TrailerTestData(-1, -1, -1, -1, 0, 0, 0, 0);

  TrailerTestingPage(CustomerData cd, [TruckTestData truckd]){
    this.custData = cd;
    if(truckd != null){
      this.truckData = truckd;
    }
  }

  // TrailerTestingPage({this.custData});

  @override
  State<StatefulWidget> createState() {
    return TrailerTestingPageState();
  }
}

class TrailerTestingPageState extends State<TrailerTestingPage> {
  Future leftTurnSignal, rightTurnSignal, tailLights, reverseLights;
  bool one = false;
  bool two = false;
  bool three = false;
  int CURRENT_MAX = 2;
  double CURRENT_MIN = .5;

  @override
  void initState() {
    super.initState();
    leftTurnSignal = _getLeftTurnSignal();
    rightTurnSignal = _getRightTurnSignal();
    tailLights = _getTailLights();
    reverseLights = _getReverseLights();
  }

  _getLeftTurnSignal() async {
    // TODO: send enable relay and test 1
    var services = await widget.device.discoverServices();
    var initial = await services[1].characteristics[4].read();
    await services[1].characteristics[4].write([Random().nextInt(4), Random().nextInt(255)]);

    for(int i = 0; i < 200; i++){
      var resp = await services[1].characteristics[4].read();
      if(initial[1] != resp[1]){
        // TODO: insert this information into the database
        var firsthalf = resp[0].toString();
        var secondhalf = resp[1].toString();

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

  _getRightTurnSignal() async {
    // TODO: send enable relay and test 2
    var services = await widget.device.discoverServices();
    var initial = await services[1].characteristics[5].read();
    await services[1].characteristics[5].write([Random().nextInt(4), Random().nextInt(255)]);

    for(int i = 0; i < 200; i++){
      var resp = await services[1].characteristics[5].read();
      if(initial[1] != resp[1]){
        // TODO: insert this information into the database
        var firsthalf = resp[0].toString();
        var secondhalf = resp[1].toString();

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

  _getTailLights() async {
    // TODO: send enable relay and test 3
    var services = await widget.device.discoverServices();
    var initial = await services[1].characteristics[6].read();
    await services[1].characteristics[6].write([Random().nextInt(4), Random().nextInt(255)]);

    for(int i = 0; i < 200; i++){
      var resp = await services[1].characteristics[6].read();
      if(initial[1] != resp[1]){
        // TODO: insert this information into the database
        var firsthalf = resp[0].toString();
        var secondhalf = resp[1].toString();

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

  _getReverseLights() async {
    // TODO: send enable relay and test 3
    var services = await widget.device.discoverServices();
    var initial = await services[1].characteristics[7].read();
    await services[1].characteristics[7].write([Random().nextInt(4), Random().nextInt(4)]);

    for(int i = 0; i < 200; i++){
      var resp = await services[1].characteristics[7].read();
      if(initial[1] != resp[1]){
        // TODO: insert this information into the database
        var firsthalf = resp[0].toString();
        var secondhalf = resp[1].toString();

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
    var lock = new Lock();
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
                Text("Testing for customer: ${widget.globalHelper.customerName}", 
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