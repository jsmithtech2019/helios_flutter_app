/*
 * Texas A&M University
 * Electronic Systems Engineering Technology
 * ESET-420 Engineering Technology Senior Design II
 * File: results.dart
 * Author: Jack Smith (john.d.smitherton@tamu.edu)
 */

// Flutter Packages
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

// Models
import 'package:HITCH/models/customer_data.dart';
import 'package:HITCH/models/global.dart';
import 'package:HITCH/models/print.dart';
import 'package:HITCH/models/seperator.dart';

// Utils
import 'package:HITCH/utils/database_helper.dart';

class ResultsPage extends StatefulWidget {
  // Pull GetIt Singleton and create pointers to Singleton Helpers
  final DatabaseHelper dbHelper = GetIt.instance<DatabaseHelper>();
  final GlobalHelper gbHelper = GetIt.instance<GlobalHelper>();

  // Pass customer data into this state
  final CustomerData custData;
  ResultsPage({this.custData});

  @override
  State<StatefulWidget> createState() {
    return ResultsPageState();
  }
}

class ResultsPageState extends State<ResultsPage> {
  String dropDownNameValue, dropDownTruckTestNum, dropDownTrailerTestNum, custid;
  Map<String, dynamic> custNameIDmap = {'key': -1};

  @override
  void initState() {
    dropDownNameValue = null;
    dropDownTruckTestNum = null;
    dropDownTrailerTestNum = null;
    super.initState();
  }

  @override
  Widget build (BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Test Results"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            new SeparatorBox("Showing test result for"),
            SizedBox(height: 20),
            Container(
              margin: EdgeInsets.fromLTRB(24, 0, 24, 0),
              child: Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      FutureBuilder<List<Map<String, dynamic>>>(
                        future: widget.dbHelper.getCustomerListTwo('name', 'id'),
                        builder: (BuildContext context, AsyncSnapshot<List<Map<String, dynamic>>> snapshot) {
                          switch (snapshot.connectionState) {
                            case ConnectionState.none: return new Text("Database Connection Failed!");
                            case ConnectionState.waiting: return new CircularProgressIndicator();
                            case ConnectionState.active: return new CircularProgressIndicator();
                            default:
                              if(snapshot.hasError){
                                return new Text("Error: ${snapshot.error}");
                              } else {
                                // Convert map to list, drop second value (id)
                                List<String> l = [];

                                int i;
                                for(i = 0; i < snapshot.data.length; i++){
                                  snapshot.data[i].forEach((k, v) => l.add(k));
                                }
                                return Container(
                                  color: Colors.grey[800],
                                  padding: EdgeInsets.fromLTRB(13,3,10,3),
                                  child: DropdownButton<String>(
                                    value: dropDownNameValue,
                                    hint: Text('Choose Customer'),
                                    items: l.map((String val){
                                      return new DropdownMenuItem<String>(
                                        value: val.toString(),
                                        child: new Text(val.toString()),
                                      );
                                    }).toList(),
                                    onChanged: (String newVal){
                                      setState(() {
                                        int i;
                                        for(i = 0; i < snapshot.data.length; i++){
                                          if(snapshot.data[i].keys.contains(newVal)){
                                            custNameIDmap = snapshot.data[i];
                                          }
                                        }
                                        dropDownTruckTestNum = null;
                                        dropDownTrailerTestNum = null;
                                        dropDownNameValue = newVal;
                                      });
                                    },
                                  ),
                                );
                              }
                          }
                        }
                      ),
                      Spacer(),
                      SizedBox(
                        height: 55,
                        child: RaisedButton(
                          color: Colors.grey[800],
                          onPressed: () {
                            // Get last test from db
                            widget.dbHelper.executeRawQuery('SELECT id, name, truckplate, trailerplate FROM CUSTOMER_DATA ORDER BY timestamp DESC LIMIT 1').then((onValue){
                              // Set the customer, truck plate and trailer plate
                              widget.gbHelper.customerData.customerID = onValue[0]['id'].toString();
                              widget.gbHelper.customerData.customerName = onValue[0]['name'];
                              widget.gbHelper.customerData.customerTruckPlate = onValue[0]['truckplate'];
                              widget.gbHelper.customerData.customerTrailerPlate = onValue[0]['trailerplate'];
                              dropDownNameValue = widget.gbHelper.customerData.customerName;
                              widget.dbHelper.executeRawQuery('SELECT id FROM TRUCK_TEST_DATA WHERE customerid="${widget.gbHelper.customerData.customerID}"').then((truckVal){
                                dropDownTruckTestNum = truckVal[0]['id'].toString();
                                widget.dbHelper.executeRawQuery('SELECT id FROM TRAILER_TEST_DATA WHERE customerid="${widget.gbHelper.customerData.customerID}"').then((trailerVal){
                                  dropDownTrailerTestNum = trailerVal[0]['id'].toString();
                                });
                              });
                            });
                          },
                          child: Text("Show Last Test"),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Row(
                    children: <Widget>[
                      new FutureBuilder<List<String>>(
                          future: widget.dbHelper.getCustomerTestList(custNameIDmap[dropDownNameValue], 'TRUCK_TEST_DATA'),
                          builder: (BuildContext context, AsyncSnapshot<List<String>> snapshot) {
                            switch (snapshot.connectionState) {
                              case ConnectionState.none: return new Text("Database Connection Failed!");
                              case ConnectionState.waiting: return new CircularProgressIndicator();
                              case ConnectionState.active: return new CircularProgressIndicator();
                              default:
                                if(snapshot.hasError){
                                  return new Text("Error: ${snapshot.error}");
                                } else {
                                  return Container(
                                    color: Colors.grey[800],
                                    padding: EdgeInsets.fromLTRB(13,3,10,3),
                                    child:DropdownButton<String>(
                                      hint: Text('Choose Truck'),
                                      value: dropDownTruckTestNum,
                                      items: snapshot.data.map((String val) {
                                        return new DropdownMenuItem<String>(
                                          value: val,
                                          child: new Text(val),
                                        );
                                      }).toList(),
                                      onChanged: (String newVal){
                                        setState(() {
                                          dropDownTruckTestNum = newVal;
                                        });
                                      },
                                    )
                                  );
                                }
                            }
                          }
                      ),
                      Spacer(),
                      new FutureBuilder<List<String>>(
                          future: widget.dbHelper.getCustomerTestList(custNameIDmap[dropDownNameValue], 'TRAILER_TEST_DATA'),
                          builder: (BuildContext context, AsyncSnapshot<List<String>> snapshot) {
                            switch (snapshot.connectionState) {
                              case ConnectionState.none: return new Text("Database Connection Failed!");
                              case ConnectionState.waiting: return new CircularProgressIndicator();
                              case ConnectionState.active: return new CircularProgressIndicator();
                              default:
                                if(snapshot.hasError){
                                  return new Text("Error: ${snapshot.error}");
                                } else {
                                  return Container(
                                      color: Colors.grey[800],
                                      padding: EdgeInsets.fromLTRB(13,3,10,3),
                                      child:DropdownButton<String>(
                                        hint: Text('Choose Trailer'),
                                        value: dropDownTrailerTestNum,
                                        items: snapshot.data.map((String val) {
                                          return new DropdownMenuItem<String>(
                                            value: val,
                                            child: new Text(val),
                                          );
                                        }).toList(),
                                        onChanged: (String newVal){
                                          setState(() {
                                            dropDownTrailerTestNum = newVal;
                                          });
                                        },
                                      )
                                  );
                                }
                            }
                          }
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                ]),
              ),
            new SeparatorBox("Showing test result for"),
            Container(
              margin: EdgeInsets.fromLTRB(24, 0, 24, 0),
              child: Column(
                children: <Widget>[
                  SizedBox(height: 20),
                  Align(
                    alignment: Alignment.centerLeft,
                    child:  PrintDatabaseResponses(
                        //'SELECT name FROM CUSTOMER_DATA WHERE id="${gbHelper.customerID}" LIMIT 1',
                        'SELECT name FROM CUSTOMER_DATA ORDER BY id DESC LIMIT 1',
                        'Customer', 20),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: PrintDatabaseResponses(
                        //'SELECT truckplate FROM CUSTOMER_DATA WHERE id="${gbHelper.customerID}" LIMIT 1',
                        'SELECT truckplate FROM CUSTOMER_DATA ORDER BY id DESC LIMIT 1',
                        'Truck License Plate', 20),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: PrintDatabaseResponses(
                        //'SELECT trailerplate FROM CUSTOMER_DATA WHERE id="${gbHelper.customerID}" LIMIT 1',
                        'SELECT trailerplate FROM CUSTOMER_DATA ORDER BY id DESC LIMIT 1',
                        'Trailer License Plate', 20),
                  ),
                  TruckResults(),
                  TrailerResults(),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class TruckResults extends StatelessWidget {
  // Pull GetIt Singleton and create pointers to Singleton Helpers
  static GetIt sl = GetIt.instance;
  final DatabaseHelper dbHelper = sl.get<DatabaseHelper>();

  Widget build(BuildContext context, [String customer]){
    return new Align(
      alignment: Alignment.centerLeft,
      child: Container(
        margin: EdgeInsets.fromLTRB(24, 24, 0, 0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            // Truck test result 1
            Text('Truck Test 1:', style: DefaultTextStyle.of(context).style.apply(fontSizeFactor: 1.5)),
            PrintDatabaseCurrentResult('SELECT test1_current FROM TRUCK_TEST_DATA ORDER BY id DESC LIMIT 1', 'Current', 1),
            PrintDatabaseResponses('SELECT test1_result FROM TRUCK_TEST_DATA ORDER BY id DESC LIMIT 1', 'Test Result', 14),

            // Truck test result 2
            SizedBox(height: 15),
            Text('Truck Test 2:', style: DefaultTextStyle.of(context).style.apply(fontSizeFactor: 1.5)),
            PrintDatabaseCurrentResult('SELECT test2_current FROM TRUCK_TEST_DATA ORDER BY id DESC LIMIT 1', 'Current', 1),
            PrintDatabaseResponses('SELECT test2_result FROM TRUCK_TEST_DATA ORDER BY id DESC LIMIT 1', 'Test Result', 14),

            // Truck test result 3
            SizedBox(height: 15),
            Text('Truck Test 3:', style: DefaultTextStyle.of(context).style.apply(fontSizeFactor: 1.5)),
            PrintDatabaseCurrentResult('SELECT test3_current FROM TRUCK_TEST_DATA ORDER BY id DESC LIMIT 1', 'Current', 1),
            PrintDatabaseResponses('SELECT test3_result FROM TRUCK_TEST_DATA ORDER BY id DESC LIMIT 1', 'Test Result', 14),

            // Truck test result 4
            SizedBox(height: 15),
            Text('Truck Test 4:', style: DefaultTextStyle.of(context).style.apply(fontSizeFactor: 1.5)),
            PrintDatabaseCurrentResult('SELECT test4_current FROM TRUCK_TEST_DATA ORDER BY id DESC LIMIT 1', 'Current', 1),
            PrintDatabaseResponses('SELECT test4_result FROM TRUCK_TEST_DATA ORDER BY id DESC LIMIT 1', 'Test Result', 14),
          ],
        ),
      ),
    );
  }
}

class TrailerResults extends StatelessWidget {
  // Pull GetIt Singleton and create pointers to Singleton Helpers
  static GetIt sl = GetIt.instance;
  final DatabaseHelper dbHelper = sl.get<DatabaseHelper>();

  Widget build(BuildContext context){
    return new Align(
      alignment: Alignment.centerLeft,
      child: Container(
        margin: EdgeInsets.fromLTRB(24, 35, 0, 0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            // Truck test result 1
            Text('Trailer Test 1:', style: DefaultTextStyle.of(context).style.apply(fontSizeFactor: 1.5)),
            PrintDatabaseCurrentResult('SELECT test1_current FROM TRAILER_TEST_DATA ORDER BY id DESC LIMIT 1', 'Current', 1),
            PrintDatabaseResponses('SELECT test1_result FROM TRAILER_TEST_DATA ORDER BY id DESC LIMIT 1', 'Test Result', 14),

            // Truck test result 2
            SizedBox(height: 15),
            Text('Trailer Test 2:', style: DefaultTextStyle.of(context).style.apply(fontSizeFactor: 1.5)),
            PrintDatabaseCurrentResult('SELECT test2_current FROM TRAILER_TEST_DATA ORDER BY id DESC LIMIT 1', 'Current', 1),
            PrintDatabaseResponses('SELECT test2_result FROM TRAILER_TEST_DATA ORDER BY id DESC LIMIT 1', 'Test Result', 14),

            // Truck test result 3
            SizedBox(height: 15),
            Text('Trailer Test 3:', style: DefaultTextStyle.of(context).style.apply(fontSizeFactor: 1.5)),
            PrintDatabaseCurrentResult('SELECT test3_current FROM TRAILER_TEST_DATA ORDER BY id DESC LIMIT 1', 'Current', 1),
            PrintDatabaseResponses('SELECT test3_result FROM TRAILER_TEST_DATA ORDER BY id DESC LIMIT 1', 'Test Result', 14),

            // Truck test result 4
            SizedBox(height: 15),
            Text('Trailer Test 4:', style: DefaultTextStyle.of(context).style.apply(fontSizeFactor: 1.5)),
            PrintDatabaseCurrentResult('SELECT test4_current FROM TRAILER_TEST_DATA ORDER BY id DESC LIMIT 1', 'Current', 1),
            PrintDatabaseResponses('SELECT test4_result FROM TRAILER_TEST_DATA ORDER BY id DESC LIMIT 1', 'Test Result', 14),
          ],
        ),
      ),
    );
  }
}

