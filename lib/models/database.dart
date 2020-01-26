import 'dart:core';

// Data Class
class CustomerData {
  int _customerId;
  String _customerName;
  String _customerPhoneNumber;
  String _customerEmail;
  String _customerAddressLine1;
  String _customerAddressLine2; // needs to accept blank
  String _customerCity;
  String _customerState;
  int _customerZipCode;
  String _truckLicensePlate;
  String _trailerLicensePlate;

  CustomerData(this._customerName,
    this._customerPhoneNumber,
    this._customerEmail,
    this._customerAddressLine1,
    this._customerAddressLine2,
    this._customerCity,
    this._customerState,
    this._customerZipCode,
    this._truckLicensePlate,
    this._trailerLicensePlate
  );

  // Getters
  int get customerId => _customerId;
  String get customerName => _customerName;
  String get customerPhoneNumber => _customerPhoneNumber;
  String get customerEmail => _customerEmail;
  String get customerAddressLine1 => _customerAddressLine1;
  String get customerAddressLine2 => _customerAddressLine2;
  String get customerCity => _customerCity;
  String get customerState => _customerState;
  int get customerZipCode => _customerZipCode;
  String get truckLicensePlate => _truckLicensePlate;
  String get trailerLicensePlate => _trailerLicensePlate;

  // Setters
  set customerId(int newID) {
    this._customerId = newID;
  }
  set customerName(String newCustName) {
    if (newCustName.length <= 255){
      this._customerName = newCustName;
    }
  }
  set customerPhoneNumber(String newCustPhoneNumber) {
    this._customerPhoneNumber = newCustPhoneNumber;
  }
  set customerEmail(String newCustEmail) {
    this._customerEmail = newCustEmail;
  }
  set customerAddressLine1(String newCustAddressLine1) {
    this._customerAddressLine1 = newCustAddressLine1;
  }
  set customerAddressLine2(String newCustAddressLine2) {
    this._customerAddressLine2 = newCustAddressLine2;
  }
  set customerCity(String newCustCity) {
    this._customerCity = newCustCity;
  }
  set customerState(String newCustState) {
    this._customerState = newCustState;
  }
  set customerZipCode(int newCustZipCode) {
    this._customerZipCode = newCustZipCode;
  }
  set truckLicensePlate(String newTruckLicensePlate) {
    this._truckLicensePlate = newTruckLicensePlate;
  }
  set trailerLicensePlate(String newTrailerLicensePlate) {
    this._trailerLicensePlate = newTrailerLicensePlate;
  }

  // Mapping
  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    if(customerId != null){
      map['id'] = _customerId;
    }
    map['name'] = _customerName;
    map['phone'] = _customerPhoneNumber;
    map['email'] = _customerEmail;
    map['addr1'] = _customerAddressLine1;
    map['addr2'] = _customerAddressLine2;
    map['city'] = _customerCity;
    map['state'] = _customerState;
    map['zip'] = _customerZipCode;
    map['truckplate'] = _truckLicensePlate;
    map['trailerplate'] = _trailerLicensePlate;

    return map;
  }

  CustomerData.fromMapObject(Map<String, dynamic> map) {
    this._customerName = map['customerName'];
    this._customerPhoneNumber = map['customerPhoneNumber'];
    this._customerEmail = map['customerEmail'];
    this._customerAddressLine1 = map['customerAddressLine1'];
    this._customerAddressLine2 = map['customerAddressLine2'];
    this._customerCity = map['customerCity'];
    this._customerState = map['customerState'];
    this._customerZipCode = map['customerZipCode'];
    this._truckLicensePlate = map['truckLicensePlate'];
    this._trailerLicensePlate = map['trailerLicensePlate'];
  }
}

class TruckTestData {
  int _truckId;
  int _truckTest1Result;
  int _truckTest2Result;
  int _truckTest3Result;
  int _truckTest4Result;
  double _truckTest1Current;
  double _truckTest2Current;
  double _truckTest3Current;
  double _truckTest4Current;

  TruckTestData(this._truckTest1Result,
    this._truckTest2Result,
    this._truckTest3Result,
    this._truckTest4Result,
    this._truckTest1Current,
    this._truckTest2Current,
    this._truckTest3Current,
    this._truckTest4Current
  );

  // Getters
  int get truckId => _truckId;
  int get truckTest1Result => _truckTest1Result;
  int get truckTest2Result => _truckTest2Result;
  int get truckTest3Result => _truckTest3Result;
  int get truckTest4Result => _truckTest4Result;
  double get truckTest1Current => _truckTest1Current;
  double get truckTest2Current => _truckTest2Current;
  double get truckTest3Current => _truckTest3Current;
  double get truckTest4Current => _truckTest4Current;

  // Setters
  set truckId(int newId){
    this._truckId = newId;
  }

  set truckTest1Result(int newResult){
    this._truckTest1Result = newResult;
  }

  set truckTest1Current(double newCurrent){
    this._truckTest1Current = newCurrent;
  }

  set truckTest2Result(int newResult){
    this._truckTest2Result = newResult;
  }

  set truckTest2Current(double newCurrent){
    this._truckTest2Current = newCurrent;
  }

  set truckTest3Result(int newResult){
    this._truckTest3Result = newResult;
  }

  set truckTest3Current(double newCurrent){
    this._truckTest3Current = newCurrent;
  }

  set truckTest4Result(int newResult){
    this._truckTest4Result = newResult;
  }

  set truckTest4Current(double newCurrent){
    this._truckTest4Current = newCurrent;
  }

  // Mapping
  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    if(truckId != null){
      map['id'] = _truckId;
    }
    map['test1_result'] = _truckTest1Result;
    map['test2_result'] = _truckTest2Result;
    map['test3_result'] = _truckTest3Result;
    map['test4_result'] = _truckTest4Result;
    map['test1_current'] = _truckTest1Current;
    map['test2_current'] = _truckTest2Current;
    map['test3_current'] = _truckTest3Current;
    map['test4_current'] = _truckTest4Current;

    return map;
  }

  TruckTestData.fromMapObject(Map<String, dynamic> map) {
    this._truckTest1Result = map['test1_result'];
    this._truckTest2Result = map['test2_result'];
    this._truckTest3Result = map['test3_result'];
    this._truckTest4Result = map['test4_result'];
    this._truckTest1Current = map['test1_current'];
    this._truckTest2Current = map['test2_current'];
    this._truckTest3Current = map['test3_current'];
    this._truckTest4Current = map['test4_current'];
  }
}

class TrailerTestData {
  int _trailerId;
  int _trailerTest1Result;
  int _trailerTest2Result;
  int _trailerTest3Result;
  int _trailerTest4Result;
  double _trailerTest1Current;
  double _trailerTest2Current;
  double _trailerTest3Current;
  double _trailerTest4Current;

  TrailerTestData(this._trailerTest1Result,
      this._trailerTest2Result,
      this._trailerTest3Result,
      this._trailerTest4Result,
      this._trailerTest1Current,
      this._trailerTest2Current,
      this._trailerTest3Current,
      this._trailerTest4Current
      );

  // Getters
  int get trailerId => _trailerId;
  int get trailerTest1Result => _trailerTest1Result;
  int get trailerTest2Result => _trailerTest2Result;
  int get trailerTest3Result => _trailerTest3Result;
  int get trailerTest4Result => _trailerTest4Result;
  double get trailerTest1Current => _trailerTest1Current;
  double get trailerTest2Current => _trailerTest2Current;
  double get trailerTest3Current => _trailerTest3Current;
  double get trailerTest4Current => _trailerTest4Current;

  // Setters
  set trailerId(int newId){
    this._trailerId = newId;
  }

  set trailerTest1Result(int newResult){
    this._trailerTest1Result = newResult;
  }

  set trailerTest1Current(double newCurrent){
    this._trailerTest1Current = newCurrent;
  }

  set trailerTest2Result(int newResult){
    this._trailerTest2Result = newResult;
  }

  set trailerTest2Current(double newCurrent){
    this._trailerTest2Current = newCurrent;
  }

  set trailerTest3Result(int newResult){
    this._trailerTest3Result = newResult;
  }

  set trailerTest3Current(double newCurrent){
    this._trailerTest3Current = newCurrent;
  }

  set trailerTest4Result(int newResult){
    this._trailerTest4Result = newResult;
  }

  set trailerTest4Current(double newCurrent){
    this._trailerTest4Current = newCurrent;
  }

  // Mapping
  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    if(trailerId != null){
      map['id'] = _trailerId;
    }
    map['test1_result'] = _trailerTest1Result;
    map['test2_result'] = _trailerTest2Result;
    map['test3_result'] = _trailerTest3Result;
    map['test4_result'] = _trailerTest4Result;
    map['test1_current'] = _trailerTest1Current;
    map['test2_current'] = _trailerTest2Current;
    map['test3_current'] = _trailerTest3Current;
    map['test4_current'] = _trailerTest4Current;

    return map;
  }

  TrailerTestData.fromMapObject(Map<String, dynamic> map) {
    this._trailerTest1Result = map['test1_result'];
    this._trailerTest2Result = map['test2_result'];
    this._trailerTest3Result = map['test3_result'];
    this._trailerTest4Result = map['test4_result'];
    this._trailerTest1Current = map['test1_current'];
    this._trailerTest2Current = map['test2_current'];
    this._trailerTest3Current = map['test3_current'];
    this._trailerTest4Current = map['test4_current'];
  }
}