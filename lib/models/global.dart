/**
 * Global Singleton for all information that is needed in the application?
 */


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

  // Getters
  get dealershipUUID => _dealershipUUID;
  get dealership => _dealership;
  get employeeUUID => _employeeUUID;
  get employeeEmail => _employeeEmail;
  get employeePhone => _employeePhone;
  get moduleUUID => _moduleUUID;
  get employeeName => _employeeName;

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
}