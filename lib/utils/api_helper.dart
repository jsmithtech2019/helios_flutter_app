import 'dart:async';
import 'dart:convert';
import 'dart:core';
import 'package:HITCH/models/database.dart';
import 'package:intl/intl.dart';
import 'package:HITCH/models/global.dart';
import 'package:get_it/get_it.dart';
import 'package:logger/logger.dart';
import 'package:http/http.dart' as http;
import 'package:HITCH/utils/database_helper.dart';
import 'package:package_info/package_info.dart';

Future<http.Response> getRequest (Map body) async {
  var logHelper = GetIt.instance<Logger>();
  // TODO: update from HTTP to HTTPS
  var url ='http://duet.helioscapstone.com/download/';

  // Expected body request format
  //   "date": "current date",
  //   "time": "time time that response was sent",
  //   "recieved": "time that data request was received",
  //   "customer": "which customer was requested",
  //   "truckplate": "which truck license plate was requested",
  //   "trailerplate": "which trailer license plate was requested",
  //   "phone": "which phone number was requested"

  Map<String,String> headers = {'Content-Type':'application/json'};

  var response = await http.post(url,
      headers: headers,
      body: jsonEncode(body)
  );
  
  logHelper.d("${response.statusCode}");
  logHelper.d("${response.body}");
  return response;
}

Future<http.Response> postRequest (CustomerData cust, TruckTestData truckd, TrailerTestData trailerd) async {
  // TODO: update from HTTP to HTTPS
  var url ='http://duet.helioscapstone.com/upload/';

  var globalHelper = GetIt.instance<GlobalHelper>();
  Logger logHelper = GetIt.instance<Logger>();
  var dbHelper = GetIt.instance<DatabaseHelper>();

  // Get Application information
  PackageInfo packageInfo = await PackageInfo.fromPlatform();
  var employeePass = await dbHelper.executeRawQuery('SELECT pass FROM ADMIN_DATA WHERE phone="${globalHelper.employeePhone}" AND email="${globalHelper.employeeEmail}"');

  //var customerID = await dbHelper.executeRawQuery('SELECT id FROM CUSTOMER_DATA WHERE phone="${cust.customerPhoneNumber}" ORDER BY timestamp DESC LIMIT 1');
  //var truckDB = await dbHelper.executeRawQuery('SELECT * FROM TRUCK_TEST_DATA WHERE customerid="${customerID[0]['id']}" ORDER BY timestamp DESC LIMIT 1');
  //var trailerDB = await dbHelper.executeRawQuery('SELECT * FROM TRAILER_TEST_DATA WHERE customerid="${customerID[0]['id']}" ORDER BY timestamp DESC LIMIT 1');

  Map testData = {
    'truck':[
      {
        'test': 'Left Turn Signal/Brake Light',
        'value': Null,
        'current': Null,
      },
      {
        'test': 'Right Turn Signal/Brake Light',
        'value': Null,
        'current': Null,
      },
      {
        'test': 'Tail Lights',
        'value': Null,
        'current': Null,
      },
      {
        'test': 'Backup Lights',
        'value': Null,
        'current': Null,
      }
    ],
    'trailer':[
      {
        'test': 'Left Turn Signal/Brake Light',
        'value': Null,
        'current': Null,
      },
      {
        'test': 'Right Turn Signal/Brake Light',
        'value': Null,
        'current': Null,
      },
      {
        'test': 'Tail Lights',
        'value': Null,
        'current': Null,
      },
      {
        'test': 'Backup Lights',
        'value': Null,
        'current': Null,
      }
    ]
  };

  // Insert received values from TruckTestData object
  // Test 1
  testData['truck'][0]['value'] = truckd.truckTest1Result;
  testData['truck'][0]['current'] = truckd.truckTest1Current;

  // Test 2
  testData['truck'][1]['value'] = truckd.truckTest2Result;
  testData['truck'][1]['current'] = truckd.truckTest2Current;

  // Test 3
  testData['truck'][2]['value'] = truckd.truckTest3Result;
  testData['truck'][2]['current'] = truckd.truckTest3Current;

  // Test 4
  testData['truck'][3]['value'] = truckd.truckTest4Result;
  testData['truck'][3]['current'] = truckd.truckTest4Current;

  // Insert received values from TrailerTestData object
  // Test 1
  testData['trailer'][0]['value'] = trailerd.trailerTest1Result;
  testData['trailer'][0]['current'] = trailerd.trailerTest1Current;

  // Test 2
  testData['trailer'][1]['value'] = trailerd.trailerTest2Result;
  testData['trailer'][1]['current'] = trailerd.trailerTest2Current;

  // Test 3
  testData['trailer'][2]['value'] = trailerd.trailerTest3Result;
  testData['trailer'][2]['current'] = trailerd.trailerTest3Current;

  // Test 4
  testData['trailer'][3]['value'] = trailerd.trailerTest4Result;
  testData['trailer'][3]['current'] = trailerd.trailerTest4Current;

  if(cust.customerZipCode == null){
    cust.customerZipCode = 0;
  }

  // Generate JSON body to send to DUET
  Map msg = {
    'application': "H.I.T.C.H",
    'version': packageInfo.version,
    'date': DateFormat('yy-MM-dd').format(new DateTime.now()),
    'time': DateFormat('hh:mm:ss').format(new DateTime.now()),
    'dealership': {
      'dealership_uuid': globalHelper.dealershipUUID,
      'dealership': globalHelper.dealership,
    },
    'employee': {
      // TODO: wtf is going on
      "employee_uuid": globalHelper.employeeUUID,
      "email": globalHelper.employeeEmail,
      "password": employeePass[0]['pass'],
      "phone": globalHelper.employeePhone.toString(),
      "module_uuid": globalHelper.moduleUUID,
    },
    "customer": {
      "name": cust.customerName,
      "phone": cust.customerPhoneNumber.toString(),
      "email": cust.customerEmail,
      "addr1": cust.customerAddressLine1,
      "addr2": cust.customerAddressLine2,
      "city": cust.customerCity,
      "state": cust.customerState,
      "zip": cust.customerZipCode.toString(),
      "truck": cust.truckLicensePlate,
      "trailer": cust.trailerLicensePlate,
      "timestamp": DateFormat('hh:mm:ss').format(new DateTime.now()),
    },
    'results': {
      ...testData,
    }
  };

  final body = jsonEncode(msg);

  Map<String,String> headers = {'Content-Type':'application/json'};
  var response = await http.post(url,
      headers: headers,
      body: body
  );
  
  logHelper.d("${response.statusCode}");
  logHelper.d("${response.body}");
  return response;
}

// Future<http.Response> testDuet () async {
//   var logHelper = GetIt.instance<Logger>();
//   // TODO: update from HTTP to HTTPS
//   var url ='http://duet.helioscapstone.com/upload/';

//   Map str = {
//     "application": "HITCH",
//     "version": "1.0.0",
//     "releasedate": "",
//     "date": "2020-02-17",
//     "time": "11:11:11",
//     "dealership": {
//       "dealership_uuid": "c1cde81b-51e2-11ea-8777-0242c0a83004",
//       "dealership": "helios"
//     },
//     "employee": {
//       "employee_uuid": "c1cde8fc-51e2-11ea-8777-0242c0a83004",
//       "email": "test@mail",
//       "password": "pass",
//       "phone": "303",
//       "module_uuid": "c1cde887-51e2-11ea-8777-0242c0a83004"
//     },
//     "customer": {
//       "name": "test cust",
//       "phone": "cust phone",
//       "email": "cust@email",
//       "addr1": "cust addr1",
//       "addr2": "",
//       "city": "cust city",
//       "state": "cust state",
//       "zip": "10000",
//       "truck": "truck plate",
//       "trailer": "trailer plate",
//       "timestamp": "11:11:19"
//     },
//     "results": {
//       "truck": [
//         {
//           "test": "Left Turn Signal/Brake Light",
//           "value": "0",
//           "current": "3.3"
//         },
//         {
//           "test": "Right Turn Signal/Brake Light",
//           "value": "1",
//           "current": "3.3"
//         },
//         {
//           "test": "Tail Lights",
//           "value": "1",
//           "current": "3.3"
//         },
//         {
//           "test": "Backup Lights",
//           "value": "1",
//           "current": "3.3"
//         }
//       ],
//       "trailer": [
//         {
//           "test": "Left Turn Signal/Brake Light",
//           "value": "1",
//           "current": "3.3"
//         },
//         {
//           "test": "Right Turn Signal/Brake Light",
//           "value": "1",
//           "current": "3.3"
//         },
//         {
//           "test": "Tail Lights",
//           "value": "1",
//           "current": "3.3"
//         },
//         {
//           "test": "Backup Lights",
//           "value": "1",
//           "current": "3.3"
//         }
//       ],
//       "pass": "boolean overall pass/fail"
//     }
//   };
//   var body = jsonEncode(str);

//   var response = await http.post(url,
//       headers: {"Content-Type": "application/json"},
//       body: body
//   );
  
//   logHelper.d("${response.statusCode}");
//   logHelper.d("${response.body}");
//   return response;
// }