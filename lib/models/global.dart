import 'package:flutter_blue/flutter_blue.dart';
import 'package:get_it/get_it.dart';

///Global Singleton for all information that is needed in the application?

class GlobalHelper {
  // Dealership Values
  String _dealership = '';
  String _dealershipUUID = '';

  // Employee Values
  String _employeeUUID = '';
  String _employeeName = '';
  String _employeeEmail = '';
  String _employeePhone = '';
  String _moduleUUID = '';

  // Customer Values
  String _customerName = '';
  String _customerID = '';
  String _customerPhone = '';
  String _customerTruckPlate = '';
  String _customerTrailerPlate = '';

  // GetIt Instance
  GetIt _getIt;

  // Bluetooth Values
  BluetoothDevice _bluetoothDevice;

  // Getters
  get dealership => _dealership;
  get dealershipUUID => _dealershipUUID;
  get employeeUUID => _employeeUUID;
  get employeeName => _employeeName;
  get employeeEmail => _employeeEmail;
  get employeePhone => _employeePhone;
  get moduleUUID => _moduleUUID;
  get customerName => _customerName;
  get customerID => _customerID;
  get customerPhone => _customerPhone;
  get customerTruckPlate => _customerTruckPlate;
  get customerTrailerPlate => _customerTrailerPlate;
  get getIt => _getIt;
  get bluetoothDevice => _bluetoothDevice;

  // Setters
  set dealership(String dealership){
    _dealership = dealership;
  }

  set dealershipUUID(String uuid){
    _dealershipUUID = uuid;
  }

  set employeeUUID(String uuid){
    _employeeUUID = uuid;
  }

  set employeeEmail(String email){
    _employeeEmail = email;
  }

  set employeePhone(String phone){
    _employeePhone = phone;
  }

  set moduleUUID(String uuid){
    _moduleUUID = uuid;
  }

  set employeeName(String name){
    _employeeName = name;
  }

  set customerName(String name){
    _customerName = name;
  }

  set customerID(String id){
    _customerID = id;
  }

  set customerTruckPlate(String plate){
    _customerTruckPlate = plate;
  }

  set customerTrailerPlate(String plate){
    _customerTrailerPlate = plate;
  }

  set customerPhone(String phone){
    _customerPhone = phone;
  }

  set getIt(GetIt i){
    _getIt = i;
  }

  set bluetoothDevice(BluetoothDevice d){
    _bluetoothDevice = d;
  }
}