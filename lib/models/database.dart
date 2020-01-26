import 'package:flutter/material.dart';

// SQLite Packages
import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

// Data Class
class TestData {
  int _id;
  String _custName;
  String _custPhoneNumber;
  String _custEmail;
  String _custAddressLine1;
  String _custAddressLine2; // needs to accept blank
  String _custCity;
  String _custState;
  int _custZipCode;
  String _truckLicensePlate;
  String _trailerLicensePlate;

  TestData(this._custName,
      this._custPhoneNumber,
      this._custEmail,
      this._custAddressLine1,
      this._custAddressLine2,
      this._custCity,
      this._custState,
      this._custZipCode,
      this._truckLicensePlate,
      this._trailerLicensePlate
      );

  TestData.withID(this._id,
      this._custName,
      this._custPhoneNumber,
      this._custEmail,
      this._custAddressLine1, // needs to accept blank
      this._custAddressLine2,
      this._custCity,
      this._custState,
      this._custZipCode,
      this._truckLicensePlate,
      this._trailerLicensePlate
      );

  // Getters
  int get id => _id;
  String get custName => _custName;
  String get custPhoneNumber => _custPhoneNumber;
  String get custEmail => _custEmail;
  String get custAddressLine1 => _custAddressLine1;
  String get custAddressLine2 => _custAddressLine2;
  String get custCity => _custCity;
  String get custState => _custState;
  int get custZipCode => _custZipCode;
  String get truckLicensePlate => _truckLicensePlate;
  String get trailerLicensePlate => _trailerLicensePlate;

  String getCustName(){
    print("THE INTERNAL NAME IS $_custName");
    return _custName;
  }

  // Setters
  set ID(int newID) {
    this._id = newID;
  }
  set custName(String newCustName) {
    if (newCustName.length <= 255){
      this._custName = newCustName;
    }
  }
  set custPhoneNumber(String newCustPhoneNumber) {
    this._custPhoneNumber = newCustPhoneNumber;
  }
  set custEmail(String newCustEmail) {
    this._custEmail = newCustEmail;
  }
  set custAddressLine1(String newCustAddressLine1) {
    this._custAddressLine1 = newCustAddressLine1;
  }
  set custAddressLine2(String newCustAddressLine2) {
    this._custAddressLine2 = newCustAddressLine2;
  }
  set custCity(String newCustCity) {
    this._custCity = newCustCity;
  }
  set custState(String newCustState) {
    this._custState = newCustState;
  }
  set custZipCode(int newCustZipCode) {
    this._custZipCode = newCustZipCode;
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
    if(id != null){
      map['id'] = _id;
    }
    map['name'] = _custName;
    map['phone'] = _custPhoneNumber;
    map['email'] = _custEmail;
    map['addr1'] = _custAddressLine1;
    map['addr2'] = _custAddressLine2;
    map['city'] = _custCity;
    map['state'] = _custState;
    map['zip'] = _custZipCode;
    map['truckplate'] = _truckLicensePlate;
    map['trailerplate'] = _trailerLicensePlate;

    return map;
  }

  TestData.fromMapObject(Map<String, dynamic> map) {
    this._custName = map['custName'];
    this._custPhoneNumber = map['custPhoneNumber'];
    this._custEmail = map['custEmail'];
    this._custAddressLine1 = map['custAddressLine1'];
    this._custAddressLine2 = map['custAddressLine2'];
    this._custCity = map['custCity'];
    this._custState = map['custState'];
    this._custZipCode = map['custZipCode'];
    this._truckLicensePlate = map['truckLicensePlate'];
    this._trailerLicensePlate = map['trailerLicensePlate'];
  }
}
