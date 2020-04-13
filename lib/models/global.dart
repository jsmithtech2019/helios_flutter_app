/*
 * Texas A&M University
 * Electronic Systems Engineering Technology
 * ESET-420 Engineering Technology Senior Design II
 * File: global.dart
 * Author: Jack Smith (john.d.smitherton@tamu.edu)
 */

// Flutter Packages
import 'package:flutter_blue/flutter_blue.dart';

// Models
import 'package:HITCH/models/admin_data.dart';
import 'package:HITCH/models/customer_data.dart';
import 'package:HITCH/models/trailer_data.dart';
import 'package:HITCH/models/truck_data.dart';

/// # Global singleton object used for passing data between pages
/// 
/// This object contains all of the information for [AdminData] that is used
/// for testing. It also contains the [CustomerData] that is inserted at the
/// testing init page as well as the [TruckTestData] and [TrailerTestData] that
/// may or may not be gathered over the course of testing (depending on the testing
/// performed).
/// 
/// By sharing these values in local memory there is less requirement on slow
/// asynchronous calls to the [SQLite] database and the application will draw
/// pages much faster. A caveat: if this object becomes too large/filled at some
/// point in later development, it may need to be broken down and rely more on
/// database calls rather than keeping all information in memory.
class GlobalHelper {
  /// [AdminData] object that stores the current working profile for the
  /// dealership/employee/HITCH module that is being used for testing and upload
  /// to the DUET endpoint.
  AdminData _adminData = AdminData.emptyConst();

  /// [CustomerData] object that stores the currently entered customer data
  /// for a specific test run. This data will be reset to the newly input data
  /// every time a test run is started
  CustomerData _customerData = CustomerData.emptyConst();

  /// Id of the last test run customer
  int _lastTestId;

  /// [TruckTestData] object that stores the information received from the
  /// HITCH module following a truck test.
  TruckTestData _truckTestData = TruckTestData.emptyConst();

  /// [TrailerTestData] object that stores the information received from the
  /// HITCH module following a trailer test.
  TrailerTestData _trailerTestData = TrailerTestData.emptyConst();

  /// Bluetooth device that is currently paired with the controller application.
  ///
  /// It is important to keep the device connected while running tests to ensure
  /// that instructions are not lost while being transmitted to the module.
  BluetoothDevice _bluetoothDevice;

  /// Name of the website to point DUET at
  /// 
  /// Is used to allow the dealership website to be updated.
  String _websiteAddress = 'helioscapstone';

  /// Get [AdminData] object
  get adminData => _adminData;

  /// Get [CustomerData] object
  get customerData => _customerData;

  /// Get [TruckTestData] object
  get truckTestData => _truckTestData;

  /// Get [TrailerTestData] object
  get trailerTestData => _trailerTestData;

  /// Get the [BluetoothDevice] object
  get bluetoothDevice => _bluetoothDevice;

  /// Get the id of the last test run customer
  get lastTestId => _lastTestId;

  /// Get the website address
  get websiteAddress => _websiteAddress;

  /// Set the [AdminData] object
  set adminData(AdminData ad) {
    this._adminData = ad;
  }

  /// Set the [CustomerData] object
  set customerData(CustomerData cd) {
    this._customerData = cd;
  }

  /// Set the [TruckTestData] object
  set truckTestData(TruckTestData td) {
    this._truckTestData = td;
  }

  /// Set the [TrailerTestData] object
  set trailerTestData(TrailerTestData td) {
    this._trailerTestData = td;
  }

  /// Set the [BluetoothDevice] object
  set bluetoothDevice(BluetoothDevice bd) {
    this._bluetoothDevice = bd;
  }

  /// Set the id of the last test run customer
  set lastTestId(int id) {
    this._lastTestId = id;
  }

  /// Set the website address
  set websiteAddress(String name) {
    this._websiteAddress = name;
  }
}