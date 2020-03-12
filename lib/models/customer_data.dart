/*
 * Texas A&M University
 * Electronic Systems Engineering Technology
 * ESET-420 Engineering Technology Senior Design II
 * File: customer_data.dart
 * Author: Jack Smith (john.d.smitherton@tamu.edu)
 */

/// # Stores the information for a Customer
/// 
/// This class is used to design the CUSTOMER_DATA table by setting the columns
/// of the [SQLite] table [CUSTOMER_DATA].
/// 
/// The customer data object is used in the [GlobalHelper] singleton to control 
/// which profile is being used for testing. This stores the customer information
/// that is entered at the beginning of testing. The data is then inserted into
/// the [SQLite] database following the completion of testing (to avoid having
/// data for a customer without featuring testing data).
class CustomerData {
  /// ID for the customer from the [SQLite] database. This is autogenerated and
  /// managed by the database itself and is autogenerated. This is designed to
  /// give each customer a single profile within the database that can be
  /// referenced by the ID number rather than name (to avoid conflicts).
  /// 
  /// This should not be touched by the user or the code.
  int _customerId;

  /// Customer name
  String _customerName;

  /// Customer phone number
  String _customerPhoneNumber;

  /// Customer email address
  String _customerEmail;

  /// Customer address 1, street address
  String _customerAddressLine1;

  /// Customer address 2, such as apartment
  String _customerAddressLine2; // needs to accept blank

  /// Customer city
  String _customerCity;

  /// Customer state
  /// TODO: add from drop down list rather than an entry mode
  String _customerState;

  /// Customer zip code
  int _customerZipCode;

  /// Customer truck license plate
  String _truckLicensePlate;

  /// Customer trailer license plate
  String _trailerLicensePlate;

  /// Default empty constructor
  /// 
  /// Generates a [CustomerData] object with no values for any of the internal
  /// variables. This allows these values to be added to the object during
  /// runtime rather than at initialization of the object.
  CustomerData.emptyConst() {
    this._customerName = '';
    this._customerPhoneNumber = '';
    this._customerEmail = '';
    this._customerAddressLine1 = '';
    this._customerAddressLine2 = '';
    this._customerCity = '';
    this._customerState = '';
    this._customerZipCode = -1;
    this._truckLicensePlate = '';
    this._trailerLicensePlate = '';
  }

  /// Default constructor
  /// 
  /// Generates a [CustomerData] object using provided variables for all of the
  /// private class variables.
  CustomerData(
      this._customerName,
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

  /// Get the customer ID
  int get customerId => _customerId;

  /// Get the customer name
  String get customerName => _customerName;

  /// Get the customer phone number
  String get customerPhoneNumber => _customerPhoneNumber;

  /// Get the customer email address
  String get customerEmail => _customerEmail;

  /// Get the customer address line 1
  String get customerAddressLine1 => _customerAddressLine1;

  /// Get the customer address line 2
  String get customerAddressLine2 => _customerAddressLine2;

  /// Get the customer city
  String get customerCity => _customerCity;

  /// Get the customer state
  String get customerState => _customerState;

  /// Get the customer zip code
  int get customerZipCode => _customerZipCode;

  /// Get the customer truck license plate
  String get truckLicensePlate => _truckLicensePlate;

  /// Get the customer trailer license plate
  String get trailerLicensePlate => _trailerLicensePlate;

  /// Set the customer ID
  set customerId(int newID) {
    this._customerId = newID;
  }

  /// Set the customer name
  set customerName(String newCustName) {
    if (newCustName.length <= 255){
      this._customerName = newCustName;
    }
  }

  /// Set the customer phone number
  set customerPhoneNumber(String newCustPhoneNumber) {
    this._customerPhoneNumber = newCustPhoneNumber;
  }

  /// Set the customer email address
  set customerEmail(String newCustEmail) {
    this._customerEmail = newCustEmail;
  }

  /// Set the customer address line 1
  set customerAddressLine1(String newCustAddressLine1) {
    this._customerAddressLine1 = newCustAddressLine1;
  }

  /// Set the customer address line 2
  set customerAddressLine2(String newCustAddressLine2) {
    this._customerAddressLine2 = newCustAddressLine2;
  }

  /// Set the customer city
  set customerCity(String newCustCity) {
    this._customerCity = newCustCity;
  }

  /// Set the customer state
  set customerState(String newCustState) {
    this._customerState = newCustState;
  }

  /// Set the customer zip code
  set customerZipCode(int newCustZipCode) {
    this._customerZipCode = newCustZipCode;
  }

  /// Set the customer truck license plate
  set truckLicensePlate(String newTruckLicensePlate) {
    this._truckLicensePlate = newTruckLicensePlate;
  }

  /// Set the customer trailer license plate
  set trailerLicensePlate(String newTrailerLicensePlate) {
    this._trailerLicensePlate = newTrailerLicensePlate;
  }

  /// Convert [CustomerData] object to a map
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

  /// Convert a map of values into an [CustomerData] object
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