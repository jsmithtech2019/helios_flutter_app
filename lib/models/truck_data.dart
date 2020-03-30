/*
 * Texas A&M University
 * Electronic Systems Engineering Technology
 * ESET-420 Engineering Technology Senior Design II
 * File: truck_data.dart
 * Author: Jack Smith (john.d.smitherton@tamu.edu)
 */

/// # Stores the information for Truck Testing
/// 
/// This class is used to design the TRUCK_TEST_DATA table by setting the columns
/// of the [SQLite] table TRUCK_TEST_DATA.
/// 
/// The truck data object is used in the [GlobalHelper] singleton to control which
/// profile is being used for testing. This stores the test information that is
/// gathered from the module during the Truck Test phase of testing. After
/// the end of the testing phase the data is then inserted into the [SQLite] 
/// database following the completion of testing to ensure a proper link between
/// a given customer and the testing data.
class TruckTestData {
  /// Truck identification number
  int _truckId;

  /// Integer CUSTOMER_DATA ID value to link tables
  int _customerId;

  /// Boolean integer result (pass/fail) for truck test result 1
  int _truckTest1Result;

  /// Boolean integer result (pass/fail) for truck test result 2
  int _truckTest2Result;

  /// Boolean integer result (pass/fail) for truck test result 3
  int _truckTest3Result;

  /// Boolean integer result (pass/fail) for truck test result 4
  int _truckTest4Result;

  /// Current value for truck test 1
  double _truckTest1Current;

  /// Current value for truck test 2
  double _truckTest2Current;

  /// Current value for truck test 3
  double _truckTest3Current;

  /// Current value for truck test 4
  double _truckTest4Current;

  /// Default empty constructor
  /// 
  /// Generates a [TruckTestData] object with no values for any of the internal
  /// variables. This allows these values to be added to the object during
  /// runtime rather than at initialization of the object.
  TruckTestData.emptyConst() {
    _truckTest1Result = null;
    _truckTest2Result = null;
    _truckTest3Result = null;
    _truckTest4Result = null;
    _truckTest1Current = null;
    _truckTest2Current = null;
    _truckTest3Current = null;
    _truckTest4Current = null;
  }

  /// Default constructor
  /// 
  /// Generates a [TruckTestData] object using provided variables for all of the
  /// private class variables. This will be used at the end of the truck testing
  /// phase when all result values have been received from the module.
  TruckTestData(
      this._truckTest1Result,
      this._truckTest2Result,
      this._truckTest3Result,
      this._truckTest4Result,
      this._truckTest1Current,
      this._truckTest2Current,
      this._truckTest3Current,
      this._truckTest4Current
  );

  /// Get the truck identifier
  int get truckId => _truckId;

  /// Get the customer id identifier
  int get customerId => _customerId;

  /// Get the truck test 1 result
  int get truckTest1Result => _truckTest1Result;

  /// Get the truck test 2 result
  int get truckTest2Result => _truckTest2Result;

  /// Get the truck test 3 result
  int get truckTest3Result => _truckTest3Result;

  /// Get the truck test 4 result
  int get truckTest4Result => _truckTest4Result;

  /// Get the truck 1 measured current
  double get truckTest1Current => _truckTest1Current;

  /// Get the truck 2 measured current
  double get truckTest2Current => _truckTest2Current;

  /// Get the truck 3 measured current
  double get truckTest3Current => _truckTest3Current;

  /// Get the truck 4 measured current
  double get truckTest4Current => _truckTest4Current;

  /// Set the truck identifier
  set truckId(int newId){
    this._truckId = newId;
  }

  /// Set the customer id identifier
  set customerId(int newId){
    this._customerId = newId;
  }


  /// Set the truck test 1 result
  set truckTest1Result(int newResult){
    this._truckTest1Result = newResult;
  }

  /// Set the truck test 2 result
  set truckTest1Current(double newCurrent){
    this._truckTest1Current = newCurrent;
  }

  /// Set the truck test 3 result
  set truckTest2Result(int newResult){
    this._truckTest2Result = newResult;
  }

  /// Set the truck test 4 result
  set truckTest2Current(double newCurrent){
    this._truckTest2Current = newCurrent;
  }

  /// Set the truck 1 measured current
  set truckTest3Result(int newResult){
    this._truckTest3Result = newResult;
  }

  /// Set the truck 2 measured current
  set truckTest3Current(double newCurrent){
    this._truckTest3Current = newCurrent;
  }

  /// Set the truck 3 measured current
  set truckTest4Result(int newResult){
    this._truckTest4Result = newResult;
  }

  /// Set the truck 4 measured current
  set truckTest4Current(double newCurrent){
    this._truckTest4Current = newCurrent;
  }

  /// Convert [TruckTestData] object to a map
  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    if(truckId != null){
      map['id'] = _truckId;
    }
    map['customerid'] = _customerId;
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

  /// Convert a map of values into an [TruckTestData] object
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