import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:HITCH/models/database.dart';

class DatabaseHelper {

  static DatabaseHelper _databaseHelper;    // Singleton DatabaseHelper
  static Database _database;                // Singleton Database


  // Shared column ID's
  String colId = 'id';

  // TESTING_DATA Database
  String testDataTable = 'TESTING_DATA';
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
  String colTimestamp = 'timestamp';

  // EMPLOYEE_DATA Database
  String employeeDataTable = "EMPLOYEE_DATA";
  String colEmployeeName = 'name';
  String colEmployeePhoneNumber = 'phone';
  String colEmployeeEmail = 'email';
  String colModuleID = 'moduleID';

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
    String path = directory.path + 'testData.db';
    //print(path);

    // Open/create the database at a given path
    var testDataDatabase = await openDatabase(path, version: 1, onCreate: _createCustomerDb);
    //var employeeDataDatabase = await openDatabase(path, version: 1, onCreate: _createEmployeeDb);
    return testDataDatabase;
  }

  void _createCustomerDb(Database db, int newVersion) async {
    await db.execute('CREATE TABLE $testDataTable('
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

  // Fetch Operation: Get all testData objects from database
  Future<List<Map<String, dynamic>>> getTestDataMapList() async {
    Database db = await this.database;

    var result = await db.rawQuery('SELECT * FROM $testDataTable order by $colId ASC');
    //var result = await db.query(testDataTable, orderBy: '$colId ASC');
    return result;
  }

  // Insert Operation: Insert a TestData object to database
  Future<int> insertTestData(TestData testData) async {
    Database db = await this.database;
    var result = await db.insert(testDataTable, testData.toMap());
    return result;
  }

  // Update Operation: Update a TestData object and save it to database
  Future<int> updateTestData(TestData testData) async {
    var db = await this.database;
    var result = await db.update(testDataTable, testData.toMap(), where: '$colId = ?', whereArgs: [testData.id]);
    return result;
  }

  // Delete Operation: Delete a TestData object from database
  Future<int> deleteTestData(int id) async {
    var db = await this.database;
    int result = await db.rawDelete('DELETE FROM $testDataTable WHERE $colId = $id');
    return result;
  }

  // Get number of TestData objects in database
  Future<int> getCount() async {
    Database db = await this.database;
    List<Map<String, dynamic>> x = await db.rawQuery('SELECT COUNT (*) from $testDataTable');
    int result = Sqflite.firstIntValue(x);
    return result;
  }

  // Get the 'Map List' [ List<Map> ] and convert it to 'TestData List' [ List<TestData> ]
  Future<List<TestData>> getTestDataList() async {

    var testDataMapList = await getTestDataMapList(); // Get 'Map List' from database
    int count = testDataMapList.length;         // Count the number of map entries in db table

    List<TestData> testDataList = List<TestData>();
    // For loop to create a 'TestData List' from a 'Map List'
    for (int i = 0; i < count; i++) {
      testDataList.add(TestData.fromMapObject(testDataMapList[i]));
    }

    return testDataList;
  }

  Future<List<Map<String, dynamic>>> executeRawQuery(String query) async {
    Database db = await this.database;
    return await db.rawQuery(query);
  }

  Future<List<Map<String, dynamic>>> executeFormattedQuery(String param, String database, String id) async {
    Database db = await this.database;
    return await db.rawQuery("SELECT $param FROM $database WHERE id=$id");
  }
}