/*
 * Texas A&M University
 * Electronic Systems Engineering Technology
 * ESET-420 Engineering Technology Senior Design II
 * File: admin_data.dart
 * Author: Jack Smith (john.d.smitherton@tamu.edu)
 */

/// # Stores the information for an Admin configuration
/// 
/// The admin data object is used in the [GetIt] singleton to control which
/// profile is being used for testing. This allows a dealership to be enrolled
/// as well as an employee which can be used faster than pulling data from the
/// [SQLite] database every time.
/// 
/// [AdminData] objects are also used to generate the employee and dealership
/// information in the ADMIN_DATA database. This allows for data to be easily
/// parsed and handled throughout the application as well as for passing data
/// to the DUET endpoint.
class AdminData {
  /// Employee name
  String _employeeName;

  /// Employee phone number
  String _employeePhoneNumber;

  /// Employee email address
  String _employeeEmail;

  /// Employee password
  String _employeePass; // THIS NEEDS TO BE SALTED AND HASHED

  /// UUID of employee
  String _employeeUUID;

  /// Module UUID of most recently paired device
  String _moduleUUID;

  /// Name of the currently active dealership
  String _dealership;

  /// UUID of the currently active dealership
  String _dealershipUUID;

  /// Default empty constructor
  /// 
  /// Generates an [AdminData] object with no values for any of the internal
  /// variables. This allows these values to be added to the object during
  /// runtime rather than at initialization of the object.
  AdminData.emptyConst() {
    this._employeeName = '';
    this._employeePhoneNumber = '';
    this._employeeEmail = '';
    this._employeePass = '';
    this._employeeUUID = '';
    this._moduleUUID = '';
    this._dealership = '';
    this._dealershipUUID = '';
  }

  /// Default constructor
  /// 
  /// Generates an [AdminData] object using provided variables for all of the
  /// private class variables.
  AdminData(
      this._employeeName,
      this._employeePhoneNumber,
      this._employeeEmail,
      this._employeePass,
      this._employeeUUID,
      this._moduleUUID,
      this._dealership,
      this._dealershipUUID
  );

  /// Get the employee name
  String get employeeName => _employeeName;

  /// Get the employee phone
  String get employeePhoneNumber => _employeePhoneNumber;

  /// Get the employee email address
  String get employeeEmail => _employeeEmail;

  /// Get the employee password
  /// TODO: remove this
  String get employeePass => _employeePass;

  /// Get the employee UUID
  String get employeeUUID => _employeeUUID;

  /// Get the module UUID
  String get moduleUUID => _moduleUUID;

  /// Get the dealership name
  String get dealership => _dealership;

  /// Get the dealership UUID
  String get dealershipUUID => _dealershipUUID;

  /// Set the employee name
  set employeeName(String newEmployeeName){
    this._employeeName = newEmployeeName;
  }

  /// Set the employee phone
  set employeePhoneNumber(String newEmployeePhoneNumber){
    this._employeePhoneNumber = newEmployeePhoneNumber;
  }

  /// Set the employee email address
  set employeeEmail(String newEmployeeEmail){
    this._employeeEmail = newEmployeeEmail;
  }

  /// Set the employee password
  set employeePass(String newEmployeePass){
    this._employeePass = newEmployeePass;
  }

  /// Set the employee UUID
  set employeeUUID(String newUUID){
    this._employeeUUID = newUUID;
  }

  /// Set the module UUID
  set moduleUUID(String newModuleID){
    this._moduleUUID = newModuleID;
  }

  /// Set the dealership name
  set dealership(String newDealership){
    this._dealership = newDealership;
  }

  /// Set the dealership UUID
  set dealershipUUID(String newDealershipUUID){
    this._dealershipUUID = newDealershipUUID;
  }

  /// Convert [AdminData] object to a map
  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();

    map['name'] = _employeeName;
    map['phone'] = _employeePhoneNumber;
    map['email'] = _employeeEmail;
    map['pass'] = _employeePass;
    map['moduleID'] = _moduleUUID;
    map['dealership'] = _dealership;
    map['dealer_uuid'] = _dealershipUUID;

    return map;
  }

  /// Convert a map of values into an [AdminData] object
  AdminData.fromMapObject(Map<String, dynamic> map) {
    this._employeeName = map['name'];
    this._employeePhoneNumber = map['phone'];
    this._employeeEmail = map['email'];
    this._employeePass = map['pass'];
    this._moduleUUID = map['moduleID'];
    this._dealership = map['dealership'];
    this._dealershipUUID = map['dealer_uuid'];
  }
}