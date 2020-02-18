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

Future<http.Response> postRequest (Map body) async {
  var logHelper = GetIt.instance<Logger>();
  // TODO: update from HTTP to HTTPS
  var url ='http://duet.helioscapstone.com/upload/';

  // Expected body request format
  //   "date": "current date",
  //   "time": "time time that response was sent",
  //   "recieved": "time that data request was received",
  //   "customer": "which customer was requested",
  //   "truckplate": "which truck license plate was requested",
  //   "trailerplate": "which trailer license plate was requested",
  //   "phone": "which phone number was requested"

  var response = await http.post(url,
      headers: {"Content-Type": "application/json"},
      body: body
  );
  
  logHelper.d("${response.statusCode}");
  logHelper.d("${response.body}");
  return response;
}

Future<http.Response> getRequest (CustomerData cust) async {
  // TODO: update from HTTP to HTTPS
  var url ='http://duet.helioscapstone.com/download/';

  var globalHelper = GetIt.instance<GlobalHelper>();
  var dbHelper = GetIt.instance<DatabaseHelper>();

  // Get Application information
  PackageInfo packageInfo = await PackageInfo.fromPlatform();
  var employeePass = await dbHelper.executeRawQuery('SELECT pass FROM ADMIN_DATA WHERE phone=${globalHelper.employeePhone} AND email=${globalHelper.employeeEmail}');

  var 

  Map body = {
    'application': packageInfo.appName,
    'version': packageInfo.version,
    'date': DateFormat('yy-MM-dd').format(new DateTime.now()),
    'time': DateFormat('hh:mm:ss').format(new DateTime.now()),
    'dealership': {
      'dealership_uuid': globalHelper.dealershipUUID,
      'dealership': globalHelper.dealership,
    },
    'employee': {
      "employee_uuid": globalHelper.employeeUUID,
      "email": globalHelper.employeeEmail,
      "password": employeePass,
      "phone": globalHelper.employeePhone,
      "module_uuid": globalHelper.moduleUUID,
    },
    "customer": {
      "name": cust.customerName,
      "phone": cust.customerPhoneNumber,
      "email": cust.customerEmail,
      "addr1": cust.customerAddressLine1,
      "addr2": cust.customerAddressLine2,
      "city": cust.customerCity,
      "state": cust.customerState,
      "zip": cust.customerZipCode,
      "truck": cust.truckLicensePlate,
      "trailer": cust.trailerLicensePlate,
      "timestamp": DateFormat('hh:mm:ss').format(new DateTime.now()),
    },
    'results': {
      'truck':[
        {
          'test': ,
          'value': ,
          'current': ,
        },
        {
          'test': ,
          'value': ,
          'current': ,
        },
        {
          'test': ,
          'value': ,
          'current': ,
        },
        {
          'test': ,
          'value': ,
          'current': ,
        }
      ],
      'trailer': [
        {
          'test': ,
          'value': ,
          'current': ,
        },
        {
          'test': ,
          'value': ,
          'current': ,
        },
        {
          'test': ,
          'value': ,
          'current': ,
        },
        {
          'test': ,
          'value': ,
          'current': ,
        }
      ],
    }
  };

  var response = await http.post(url,
      headers: {"Content-Type": "application/json"},
      body: body
  );
  
  logHelper.d("${response.statusCode}");
  logHelper.d("${response.body}");
  return response;
}

Future<http.Response> testDuet () async {
  var logHelper = GetIt.instance<Logger>();
  // TODO: update from HTTP to HTTPS
  var url ='http://duet.helioscapstone.com/upload/';

  Map str = {
    "application": "HITCH",
    "version": "1.0.0",
    "releasedate": "",
    "date": "2020-02-17",
    "time": "11:11:11",
    "dealership": {
      "dealership_uuid": "c1cde81b-51e2-11ea-8777-0242c0a83004",
      "dealership": "helios"
    },
    "employee": {
      "employee_uuid": "c1cde8fc-51e2-11ea-8777-0242c0a83004",
      "email": "test@mail",
      "password": "pass",
      "phone": "303",
      "module_uuid": "c1cde887-51e2-11ea-8777-0242c0a83004"
    },
    "customer": {
      "name": "test cust",
      "phone": "cust phone",
      "email": "cust@email",
      "addr1": "cust addr1",
      "addr2": "",
      "city": "cust city",
      "state": "cust state",
      "zip": "10000",
      "truck": "truck plate",
      "trailer": "trailer plate",
      "timestamp": "11:11:19"
    },
    "results": {
      "truck": [
        {
          "test": "Left Turn Signal/Brake Light",
          "value": "0",
          "current": "3.3"
        },
        {
          "test": "Right Turn Signal/Brake Light",
          "value": "1",
          "current": "3.3"
        },
        {
          "test": "Tail Lights",
          "value": "1",
          "current": "3.3"
        },
        {
          "test": "Backup Lights",
          "value": "1",
          "current": "3.3"
        }
      ],
      "trailer": [
        {
          "test": "Left Turn Signal/Brake Light",
          "value": "1",
          "current": "3.3"
        },
        {
          "test": "Right Turn Signal/Brake Light",
          "value": "1",
          "current": "3.3"
        },
        {
          "test": "Tail Lights",
          "value": "1",
          "current": "3.3"
        },
        {
          "test": "Backup Lights",
          "value": "1",
          "current": "3.3"
        }
      ],
      "pass": "boolean overall pass/fail"
    }
  };
  var body = jsonEncode(str);

  var response = await http.post(url,
      headers: {"Content-Type": "application/json"},
      body: body
  );
  
  logHelper.d("${response.statusCode}");
  logHelper.d("${response.body}");
  return response;
}