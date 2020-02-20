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
  String _customerTruckPlate = '';
  String _customerTrailerPlate = '';

  // Getters
  get dealership => _dealership;
  get dealershipUUID => _dealershipUUID;
  get employeeUUID => _employeeUUID;
  get employeeName => _employeeName;
  get employeeEmail => _employeeEmail;
  get employeePhone => _employeePhone;
  get moduleUUID => _moduleUUID;
  get customerName => _customerName;
  get customerID=> _customerID;
  get customerTruckPlate=> _customerTruckPlate;
  get customerTrailerPlate=> _customerTrailerPlate;

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
}