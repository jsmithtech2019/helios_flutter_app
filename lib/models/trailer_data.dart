/*
 * Texas A&M University
 * Electronic Systems Engineering Technology
 * ESET-420 Engineering Technology Senior Design II
 * File: trailer_data.dart
 * Author: Jack Smith (john.d.smitherton@tamu.edu)
 */

/// # Stores the information for Trailer Testing
/// 
/// This class is used to design the TRAILER_TEST_DATA table by setting the columns
/// of the [SQLite] table TRAILER_TEST_DATA.
/// 
/// The trailer data object is used in the [GlobalHelper] singleton to control which
/// profile is being used for testing. This stores the test information that is
/// gathered from the module during the Trailer Test phase of testing. After
/// the end of the testing phase the data is then inserted into the [SQLite] 
/// database following the completion of testing to ensure a proper link between
/// a given customer and the testing data.
class TrailerTestData {
  /// Trailer identification number
  int _trailerId;

  /// Integer CUSTOMER_DATA ID value to link tables
  int _customerId;

  /// Boolean integer result (pass/fail) for trailer test result 1
  int _trailerTest1Result;

  /// Boolean integer result (pass/fail) for trailer test result 2
  int _trailerTest2Result;

  /// Boolean integer result (pass/fail) for trailer test result 3
  int _trailerTest3Result;

  /// Boolean integer result (pass/fail) for trailer test result 4
  int _trailerTest4Result;

  /// Current value for trailer test 1
  double _trailerTest1Current;

  /// Current value for trailer test 2
  double _trailerTest2Current;

  /// Current value for trailer test 3
  double _trailerTest3Current;

  /// Current value for trailer test 4
  double _trailerTest4Current;

  /// Default empty constructor
  /// 
  /// Generates a [TrailerTestData] object with no values for any of the internal
  /// variables. This allows these values to be added to the object during
  /// runtime rather than at initialization of the object.
  TrailerTestData.emptyConst() {
    _trailerTest1Result = null;
    _trailerTest2Result = null;
    _trailerTest3Result = null;
    _trailerTest4Result = null;
    _trailerTest1Current = null;
    _trailerTest2Current = null;
    _trailerTest3Current = null;
    _trailerTest4Current = null;
  }

  /// Default constructor
  /// 
  /// Generates a [TrailerTestData] object using provided variables for all of the
  /// private class variables. This will be used at the end of the trailer testing
  /// phase when all result values have been received from the module.
  TrailerTestData(
      this._trailerTest1Result,
      this._trailerTest2Result,
      this._trailerTest3Result,
      this._trailerTest4Result,
      this._trailerTest1Current,
      this._trailerTest2Current,
      this._trailerTest3Current,
      this._trailerTest4Current
  );

  /// Get the trailer identifier
  int get trailerId => _trailerId;

  /// Get the customer id identifier
  int get customerId => _customerId;

  /// Get the trailer test 1 result
  int get trailerTest1Result => _trailerTest1Result;

  /// Get the trailer test 2 result
  int get trailerTest2Result => _trailerTest2Result;

  /// Get the trailer test 3 result
  int get trailerTest3Result => _trailerTest3Result;

  /// Get the trailer test 4 result
  int get trailerTest4Result => _trailerTest4Result;

  /// Get the trailer 1 measured current
  double get trailerTest1Current => _trailerTest1Current;

  /// Get the trailer 2 measured current
  double get trailerTest2Current => _trailerTest2Current;

  /// Get the trailer 3 measured current
  double get trailerTest3Current => _trailerTest3Current;

  /// Get the trailer 4 measured current
  double get trailerTest4Current => _trailerTest4Current;

  /// Set the trailer identifier
  set trailerId(int newId){
    this._trailerId = newId;
  }

  /// Set the customer id identifier
  set customerId(int newId){
    this._customerId = newId;
  }

  /// Set the trailer test 1 result
  set trailerTest1Result(int newResult){
    this._trailerTest1Result = newResult;
  }

  /// Set the trailer test 2 result
  set trailerTest1Current(double newCurrent){
    this._trailerTest1Current = newCurrent;
  }

  /// Set the trailer test 3 result
  set trailerTest2Result(int newResult){
    this._trailerTest2Result = newResult;
  }

  /// Set the trailer test 4 result
  set trailerTest2Current(double newCurrent){
    this._trailerTest2Current = newCurrent;
  }

  /// Set the trailer 1 measured current
  set trailerTest3Result(int newResult){
    this._trailerTest3Result = newResult;
  }

  /// Set the trailer 2 measured current
  set trailerTest3Current(double newCurrent){
    this._trailerTest3Current = newCurrent;
  }

  /// Set the trailer 3 measured current
  set trailerTest4Result(int newResult){
    this._trailerTest4Result = newResult;
  }

  /// Set the trailer 4 measured current
  set trailerTest4Current(double newCurrent){
    this._trailerTest4Current = newCurrent;
  }

  /// Convert [TrailerTestData] object to a map
  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    if(trailerId != null){
      map['id'] = _trailerId;
    }
    map['customerid'] = _customerId;
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

  /// Convert a map of values into an [TrailerTestData] object
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