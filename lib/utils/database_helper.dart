import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:HITCH/models/database.dart';

class DatabaseHelper {

  static DatabaseHelper _databaseHelper;    // Singleton DatabaseHelper
  static Database _database;                // Singleton Database


  // Shared table values
  String colId = 'id';
  String colTimestamp = 'timestamp';

  // TESTING_DATA Database
  String custTable = 'CUSTOMER_DATA';
  String colCustName = 'name';
  String colCustPhoneNumber = 'phone';
  String colCustEmail = 'email';
  String colCustAddressLine1 = 'addr1';
  String colCustAddressLine2 = 'addr2';
  String colCustCity = 'city';
  String colCustState = 'state';
  String colCustZipCode = 'zip';
  String colTruckLicensePlate = 'truckplate';
  String colTrailerLicensePlate = 'trailerplate';

  // ADMIN_DATA Database
  String adminTable = "ADMIN_DATA";
  String colEmployeeName = 'name';
  String colEmployeePhoneNumber = 'phone';
  String colEmployeeEmail = 'email';
  String colEmployeePass = 'pass'; // THIS NEEDS TO BE SALTED AND HASHED
  String colModuleID = 'moduleID';
  String colDealership = 'dealership';
  String colDealershipUUID = 'dealer_uuid';

  // TRUCK_TEST_DATA
  String truckTable = 'TRUCK_TEST_DATA';
  String colTruckTest1Result = 'test1_result';
  String colTruckTest1Current = 'test1_current';
  String colTruckTest2Result = 'test2_result';
  String colTruckTest2Current = 'test2_current';
  String colTruckTest3Result = 'test3_result';
  String colTruckTest3Current = 'test3_current';
  String colTruckTest4Result = 'test4_result';
  String colTruckTest4Current = 'test4_current';

  // TRAILER_TEST_DATA
  String trailerTable = 'TRAILER_TEST_DATA';
  String colTrailerTest1Result = 'test1_result';
  String colTrailerTest1Current = 'test1_current';
  String colTrailerTest2Result = 'test2_result';
  String colTrailerTest2Current = 'test2_current';
  String colTrailerTest3Result = 'test3_result';
  String colTrailerTest3Current = 'test3_current';
  String colTrailerTest4Result = 'test4_result';
  String colTrailerTest4Current = 'test4_current';

  DatabaseHelper._createInstance(); // Named constructor to create instance of DatabaseHelper

  factory DatabaseHelper() {
    if (_databaseHelper == null) {
      _databaseHelper = DatabaseHelper._createInstance(); // This is executed only once, singleton object
    }
    return _databaseHelper;
  }

  Future<Database> get database async {
    if (_database == null) {
      _database = await initializeDatabase();
    }
    return _database;
  }

  Future<Database> initializeDatabase() async {
    // Get the directory path for both Android and iOS to store database.
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path + 'HitchDatabase.db';
    print(path);

    // Open/create the database at a given path
    var HitchDatabase = await openDatabase(path, version: 1, onCreate: _createTables);
    //var employeeDataDatabase = await openDatabase(path, version: 1, onCreate: _createEmployeeDb);
    return HitchDatabase;
  }

  void _createTables(Database db, int newVersion) async {
    _createCustomerDb(db, newVersion);
    _createTruckDb(db, newVersion);
    _createTrailerDb(db, newVersion);
    _createAdminDb(db, newVersion);
  }

  void _createCustomerDb(Database db, int newVersion) async {
    await db.execute('CREATE TABLE $custTable('
        '$colId INTEGER PRIMARY KEY AUTOINCREMENT,'
        '$colCustName TEXT NOT NULL, '
        '$colCustPhoneNumber TEXT NOT NULL, '
        '$colCustEmail TEXT, '
        '$colCustAddressLine1 TEXT, '
        '$colCustAddressLine2 TEXT, '
        '$colCustCity TEXT, '
        '$colCustState TEXT, '
        '$colCustZipCode INTEGER, '
        '$colTruckLicensePlate TEXT NOT NULL, '
        '$colTrailerLicensePlate TEXT NOT NULL,'
        '$colTimestamp DATETIME DEFAULT CURRENT_TIMESTAMP NOT NULL)');
  }

  void _createAdminDb(Database db, int newVersion) async {
    await db.execute('CREATE TABLE $adminTable('
        '$colEmployeeName TEXT, '
        '$colEmployeePhoneNumber TEXT, '
        '$colEmployeeEmail TEXT, '
        '$colEmployeePass TEXT, '
        '$colModuleID TEXT, '
        '$colDealership TEXT, '
        '$colDealershipUUID TEXT NOT NULL)');
  }

  void _createTruckDb(Database db, int newVersion) async {
    await db.execute('CREATE TABLE $truckTable('
        '$colId INTEGER PRIMARY KEY NOT NULL, '
        '$colTruckTest1Result INTEGER, '
        '$colTruckTest1Current REAL, '
        '$colTruckTest2Result INTEGER, '
        '$colTruckTest2Current REAL, '
        '$colTruckTest3Result INTEGER, '
        '$colTruckTest3Current REAL, '
        '$colTruckTest4Result INTEGER, '
        '$colTruckTest4Current REAL, '
        '$colTimestamp DATETIME DEFAULT CURRENT_TIMESTAMP NOT NULL)');
  }

  void _createTrailerDb(Database db, int newVersion) async {
    await db.execute('CREATE TABLE $trailerTable('
        '$colId INTEGER PRIMARY KEY NOT NULL, '
        '$colTrailerTest1Result INTEGER, '
        '$colTrailerTest1Current REAL, '
        '$colTrailerTest2Result INTEGER, '
        '$colTrailerTest2Current REAL, '
        '$colTrailerTest3Result INTEGER, '
        '$colTrailerTest3Current REAL, '
        '$colTrailerTest4Result INTEGER, '
        '$colTrailerTest4Current REAL, '
        '$colTimestamp DATETIME DEFAULT CURRENT_TIMESTAMP NOT NULL)');
  }

  // Fetch Operation: Get all testData objects from database
  Future<List<Map<String, dynamic>>> getTestDataMapList() async {
    Database db = await this.database;

    var result = await db.rawQuery('SELECT * FROM $custTable order by $colId ASC');
    //var result = await db.query(custTable, orderBy: '$colId ASC');
    return result;
  }

  // Insert Operation: Insert a TestData object to database
  Future<int> insertCustomerData(CustomerData custData) async {
    Database db = await this.database;
    var result = await db.insert(custTable, custData.toMap());
    return result;
  }

  // Update Operation: Update a TestData object and save it to database
  Future<int> updateCustomerData(CustomerData custData) async {
    var db = await this.database;
    var result = await db.update(custTable, custData.toMap(), where: '$colId = ?', whereArgs: [custData.customerId]);
    return result;
  }

  // Delete Operation: Delete a TestData object from database
  Future<int> deleteCustomerData(int id) async {
    var db = await this.database;
    int result = await db.rawDelete('DELETE FROM $custTable WHERE $colId = $id');
    return result;
  }

  // Get number of TestData objects in database
  Future<int> getCount(String db) async {
    Database db = await this.database;
    List<Map<String, dynamic>> x = await db.rawQuery('SELECT COUNT (*) from $db');
    int result = Sqflite.firstIntValue(x);
    return result;
  }

  // Get the 'Map List' [ List<Map> ] and convert it to 'TestData List' [ List<TestData> ]
  Future<List<CustomerData>> getCustomerDataList() async {

    var testDataMapList = await getTestDataMapList(); // Get 'Map List' from database
    int count = testDataMapList.length;         // Count the number of map entries in db table

    List<CustomerData> testDataList = List<CustomerData>();
    // For loop to create a 'TestData List' from a 'Map List'
    for (int i = 0; i < count; i++) {
      testDataList.add(CustomerData.fromMapObject(testDataMapList[i]));
    }

    return testDataList;
  }

  // THESE ARE THE ONES THAT WILL LIKELY BE USED MOST
  Future<List<Map<String, dynamic>>> executeRawQuery(String query) async {
    Database db = await this.database;
    return await db.rawQuery(query);
  }

  Future<List<Map<String, dynamic>>> executeFormattedQuery(String param, String database, String id) async {
    Database db = await this.database;
    return await db.rawQuery("SELECT $param FROM $database WHERE id=$id");
  }
}