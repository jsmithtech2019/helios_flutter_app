// Flutter Packages
import 'dart:async';
import 'dart:io';
//import 'dart:math';
import 'package:get_it/get_it.dart';
import 'package:logger/logger.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

// Models
import 'package:HITCH/models/database.dart';

/// # Boilerplate for SQLite Database
///
/// This class contains the means to boilerplate the SQLite database that
/// is relied on for the controller to function correctly and store data
/// for administrative and testing purposes securely.
///
/// Tables are specificed in the first section of code and are outlined
/// as table name followed by a list of columns that will be inserted
/// in their corresponding table. Shared table columns are listed at
/// the top of this section.
class DatabaseHelper {
  /// Static singleton instances of the class are used to access the
  /// database in an asynchronous fashion and ensure that there is never
  /// a race condition between data entries in the table.
  ///
  /// This also ensures that the application will not try to access the
  /// database simultaneously due to implementation of the [GetIt] package
  /// provided by Flutter.
  static DatabaseHelper _databaseHelper;    // Singleton DatabaseHelper
  static Database _database;                // Singleton Database

  /// Declarations of the columns that are shared between some (or all)
  /// of the tables. These allow for no variable naming issues when
  /// designing and modifying schemas.

  // CUSTOMER_DATA Table
  String custTable = 'CUSTOMER_DATA';
  List customerColumns = ['id', 'name', 'phone', 'email', 'addr1', 'addr2',
    'city', 'state', 'zip', 'truckplate', 'trailerplate', 'timestamp'];

  // ADMIN_DATA Table
  String adminTable = "ADMIN_DATA";
  List adminColumns = ['id', 'name', 'phone', 'email', 'pass', 'employee_uuid',
    'moduleID', 'dealership', 'dealer_uuid'];

  // TRUCK_TEST_DATA and TRAILER_TEST_DATA
  String truckTable = 'TRUCK_TEST_DATA';
  String trailerTable = 'TRAILER_TEST_DATA';
  List testColumns = ['id', 'customerid', 'test1_result', 'test2_result', 
    'test3_result', 'test4_result', 'test1_current', 'test2_current', 
    'test3_current', 'test4_current', 'timestamp'];

  /// Logger singleton for logging functionality.
  ///
  /// Logger instance to be used by the methods in this file to log errors and
  /// other functional events that can be submitted for debugging to the
  /// developers. Also useful in development of the application.
  ///
  /// The logger instance lives in the [GetIt] singleton handler to protect
  /// it from being accessed simultaneously in asynchronous threads.
  Logger logHelper = GetIt.instance<Logger>();

  /// Named contructor for the [DatabaseHelper] singleton.
  ///
  /// Named constructor for [DatabaseHelper] that should only be called once
  /// during app lifetime. This will generate a database file that lives within
  /// the application through reboots to retain test, dealership and employee
  /// information.
  DatabaseHelper._createInstance(); // Named constructor to create instance of DatabaseHelper

  /// Protect against recreating the [DatabaseHelper] singleton.
  ///
  /// Factory contructor for the [DatabaseHelper] object that verifies if a
  /// database exists within the file system already and protects from
  /// regenerating and overwriting existing saved data.
  ///
  /// Function returns a [DatabaseHelper] singleton which is stored in the [GetIt]
  /// object and can be utilized to access the database and perform necessary
  /// functions to the data within it including:
  /// * Insertions
  /// * Selects
  /// * Updates
  /// * Deletes
  factory DatabaseHelper() {
    if (_databaseHelper == null) {
      _databaseHelper = DatabaseHelper._createInstance(); // This is executed only once, singleton object
    }
    return _databaseHelper;
  }

  /// Protect from reinitializing a database on the file system
  ///
  /// Asynchronous function called during app startup that will get an existing
  /// database instance (if it exists) or generate one using [initializeDatabase]
  /// if one does not. This access to the singleton [DatabaseHelper] object is
  /// stored in the [GetIt] singleton that is generated in the [main.dart].
  ///
  /// This function generates a .db file that is then stored on the file system
  /// and can be read by database inspectors such as __SQLite Inspector__ which
  /// can be useful for code analysis and debugging.
  Future<Database> get database async {
    if (_database == null) {
      _database = await initializeDatabase();
    }
    return _database;
  }

  /// Initializes a database file on the phone.
  ///
  /// A database file _.db_ is generated at the [path] specified in this
  /// function which is either a static path on the host (used for debugging)
  /// or a path generated using [getApplicationDocumentsDirectory] to create
  /// the file at an appropriate location on a physical device. Though the
  /// database path is logged upon creation, it is often difficult to debug
  /// using the dynamic path from a device, commenting out this method and
  /// re-enabling a static path is useful for development purposes.
  ///
  /// This function returns the database created at the specified [path] as well
  /// as starts the generation of the schemas outlined in this classes local
  /// variables.
  Future<Database> initializeDatabase() async {
    // Get the directory path for both Android and iOS to store database. Must
    // be enabled for application functionality on a physical device.
    //Directory directory = await getApplicationDocumentsDirectory();
    //String path = p.join(directory.toString(), 'HitchDatabase.db');

    // Using a static path on the host machine can be useful for debugging
    // errors or writing additional functionality for the controller. The path
    // specified is an absolute path from the root directory of the dev machine.
    String path = '/Users/mars/Desktop/HitchDatabase.db';

    // Log the database path for debugging purposes
    logHelper.d('Using path: $path');

    // Open/create the database at a given path
    return await openDatabase(path, version: 1, onCreate: _createTables);
  }

  /// Create the tables outlined in the schemas above.
  ///
  /// This function calls four sub functions to generate the specified tables
  /// and columns from the applications designed schemas. Using the provided
  /// [Database] the tables are then generated.
  void _createTables(Database db, int newVersion) async {
    _createCustomerDb(db, newVersion);
    _createTruckDb(db, newVersion);
    _createTrailerDb(db, newVersion);
    _createAdminDb(db, newVersion);
  }

  /// Create the CUSTOMER_DATA SQLite table.
  ///
  /// Using the schemas outlined at the beginning of the class this function
  /// then generates the specified tables within the given [db] database.
  void _createCustomerDb(Database db, int newVersion) async {
    await db.execute('CREATE TABLE $custTable('
        '${customerColumns[0]} INTEGER PRIMARY KEY AUTOINCREMENT,'
        '${customerColumns[1]} TEXT NOT NULL, '
        '${customerColumns[2]} TEXT NOT NULL, '
        '${customerColumns[3]} TEXT, '
        '${customerColumns[4]} TEXT, '
        '${customerColumns[5]} TEXT, '
        '${customerColumns[6]} TEXT, '
        '${customerColumns[7]} TEXT, '
        '${customerColumns[8]} INTEGER, '
        '${customerColumns[9]} TEXT NOT NULL, '
        '${customerColumns[10]} TEXT NOT NULL,'
        '${customerColumns[11]} DATETIME DEFAULT CURRENT_TIMESTAMP NOT NULL)');
    logHelper.d('Customer table created!');
  }

  /// Create the ADMIN_DATA SQLite table.
  ///
  /// Using the schemas outlined at the beginning of the class this function
  /// then generates the specified tables within the given [db] database.
  void _createAdminDb(Database db, int newVersion) async {

    await db.execute('CREATE TABLE $adminTable('
        '${adminColumns[0]} INTEGER PRIMARY KEY AUTOINCREMENT,'
        '${adminColumns[1]} TEXT, '
        '${adminColumns[2]} TEXT, '
        '${adminColumns[3]} TEXT, '
        '${adminColumns[4]} TEXT, '
        '${adminColumns[5]} TEXT, '
        '${adminColumns[6]} TEXT, '
        '${adminColumns[7]} TEXT, '
        '${adminColumns[8]} TEXT NOT NULL)');
    logHelper.d('Admin table created!');
  }

  /// Create the TRUCK_TEST_DATA SQLite table.
  ///
  /// Using the schemas outlined at the beginning of the class this function
  /// then generates the specified tables within the given [db] database. This
  /// table also references the [custTable] at customerid.
  void _createTruckDb(Database db, int newVersion) async {

    await db.execute('CREATE TABLE $truckTable('
        '${testColumns[0]} INTEGER PRIMARY KEY NOT NULL, '
        '${testColumns[1]} INTEGER, '
        '${testColumns[2]} INTEGER, '
        '${testColumns[3]} REAL, '
        '${testColumns[4]} INTEGER, '
        '${testColumns[5]} REAL, '
        '${testColumns[6]} INTEGER, '
        '${testColumns[7]} REAL, '
        '${testColumns[8]} INTEGER, '
        '${testColumns[9]} REAL, '
        '${testColumns[10]} DATETIME DEFAULT CURRENT_TIMESTAMP NOT NULL, '
        'FOREIGN KEY(${testColumns[1]}) REFERENCES $custTable(id))');

    logHelper.d('Truck table created!');
  }

  /// Create the TRAILER_TEST_DATA SQLite table.
  ///
  /// Using the schemas outlined at the beginning of the class this function
  /// then generates the specified tables within the given [db] database. This
  /// table also references the [custTable] at customerid.
  void _createTrailerDb(Database db, int newVersion) async {
    await db.execute('CREATE TABLE $trailerTable('
        '${testColumns[0]} INTEGER PRIMARY KEY NOT NULL, '
        '${testColumns[1]} INTEGER, '
        '${testColumns[2]} INTEGER, '
        '${testColumns[3]} REAL, '
        '${testColumns[4]} INTEGER, '
        '${testColumns[5]} REAL, '
        '${testColumns[6]} INTEGER, '
        '${testColumns[7]} REAL, '
        '${testColumns[8]} INTEGER, '
        '${testColumns[9]} REAL, '
        '${testColumns[10]} DATETIME DEFAULT CURRENT_TIMESTAMP NOT NULL, '
        'FOREIGN KEY(${testColumns[1]}) REFERENCES $custTable(id))');

    logHelper.d('Trailer table created!');
  }

  /// Insert a CustomerData object into the CUSTOMER_DATA table.
  ///
  /// Using the provided [custData] the function will attempt to insert the
  /// customer into the database. Upon finding a conflicting entry the conflict
  /// resolution algorithm will replace it using this most recent entry.
  ///
  /// This will return an integer [result] that will either confirm a successful
  /// insertion or a failure.
  Future<int> insertCustomerData(CustomerData custData) async {
    Database db = await this.database;
    var result = await db.insert(custTable, custData.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
    return result;
  }

  // // Update Operation: Update a TestData object and save it to database
  // Future<int> updateCustomerData(CustomerData custData) async {
  //   var db = await this.database;
  //   var result = await db.update(custTable, custData.toMap(), where: '$colId = ?', whereArgs: [custData.customerId]);
  //   return result;
  // }

  // // Delete Operation: Delete a TestData object from database
  // Future<int> deleteCustomerData(int id) async {
  //   var db = await this.database;
  //   int result = await db.rawDelete('DELETE FROM $custTable WHERE $colId = $id');
  //   return result;
  // }

  /// Insert a AdminData object into the ADMIN_DATA table.
  ///
  /// Using the provided [adminData] the function will attempt to insert the
  /// data into the database. Upon finding a conflicting entry the conflict
  /// resolution algorithm will replace it using this most recent entry.
  ///
  /// This will return an integer [result] that will either confirm a successful
  /// insertion or a failure.
  Future<int> insertAdminData(AdminData adminData) async {
    Database db = await this.database;
    var result = await db.insert(adminTable, adminData.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
    return result;
  }

  /// Execute a raw SQL query against the SQLite database.
  ///
  /// Using the provided [query] this function will run it explicitly against
  /// the database. This can be dangerous and should likely be removed and
  /// replaced with safer insertion methods but is useful for debugging.
  /// TODO: remove and replace with functions
  Future<List<Map<dynamic, dynamic>>> executeRawQuery(String query) async {
    Database db = await this.database;
    return await db.rawQuery(query);
  }

  /// Retrieves a list of customers data from the CUSTOMER_DATA table by filter.
  ///
  /// This function can be used to create drop down menus from which a customer
  /// can be selected by [filter]. Providing _name_ as argument will therefore
  /// generate a list of all the distinct names in the database while providing
  /// _phone_ will return a list of all the customer phone numbers.
  ///
  /// A list of strings [values] will then be returned for usage.
  Future<List<String>> getCustomerList(String filter) async {
    List<String> values = List<String>();
    Database db = await this.database;
    var countRes = await db.rawQuery("SELECT count(DISTINCT $filter) FROM CUSTOMER_DATA");
    var res = await db.rawQuery("SELECT DISTINCT $filter FROM CUSTOMER_DATA ORDER BY timestamp DESC");

    int i = 0;
    for (i = 0; i < countRes[0]['count(DISTINCT $filter)']; i++){
      values.add(res[i]['$filter']);
    }

    return values;
  }

  /// Retrieve two values from the CUSTOMER_DATA table.
  /// 
  /// This function selects values [one] and [two] from the customer table
  /// by running a select query that groups by [one] and then returns a list of
  /// maps that map {[one]: [two]} for usage in a FutureBuilder.
  /// 
  /// This is implemented heavily in the Results page for selecting a list of
  /// tests (by linked column customerid) for a specific customer provided by
  /// the user.
  Future<List<Map<String, dynamic>>> getCustomerListTwo(String one, String two) async {
    List<Map<String, dynamic>> values = List<Map<String, dynamic>>();
    Database db = await this.database;
    var countRes = await db.rawQuery("SELECT count(DISTINCT $one) FROM CUSTOMER_DATA");
    var res = await db.rawQuery("SELECT $one, $two FROM CUSTOMER_DATA GROUP BY $one");

    int i = 0;
    for (i = 0; i < countRes[0]["count(DISTINCT $one)"]; i++){
      values.add({res[i]['$one']: res[i]['$two']});
    }
    return values;
  }

  /// Retrieves a list of employee names from the ADMIN_DATA table by filter.
  ///
  /// This function can be used to create drop down menus from which an employee
  /// can be selected by [filter]. Providing _name_ as argument will therefore
  /// generate a list of all the distinct names in the database while providing
  /// _phone_ will return a list of all the customer phone numbers.
  ///
  /// A list of strings [realNames] will then be returned for usage.
  Future<List<String>> getEmployeesList(String filter) async {
    List<String> realNames = List<String>();
    Database db = await this.database;
    var countRes = await db.rawQuery("SELECT count(DISTINCT $filter) FROM ADMIN_DATA");
    var res = await db.rawQuery("SELECT DISTINCT $filter FROM ADMIN_DATA ORDER BY id DESC");

    int i = 0;
    for (i = 0; i < countRes[0]['count(DISTINCT $filter)']; i++){
      realNames.add(res[i]['$filter']);
    }

    return realNames;
  }

  /// Retrieves a list of tests by customer on either the truck or the table.
  ///
  /// This function returns a list of tests run on a customer ([cust]) from the
  /// specified TRUCK_TEST_DATA or TRAILER_TEST_DATA table ([table]). It includes
  /// logic for drop down lists to avoid searching for a customer that does not
  /// exists (such as 'Choose Customer').
  ///
  /// A list of the distinct customers will then be returned for usage.
  Future<List<String>> getCustomerTestList(int custID, String table) async {
    List<String> tests = List<String>();
    Database db = await this.database;
    var countRes = await db.rawQuery("SELECT count(DISTINCT timestamp) FROM $table WHERE customerid='$custID'");
    var res = await db.rawQuery("SELECT id FROM $table WHERE customerid='$custID' ORDER BY timestamp DESC");

    int i = 0;
    for (i = 0; i < countRes[0]['count(DISTINCT timestamp)']; i++){
      tests.add(res[i]['id'].toString());
    }
    return tests;
  }
}
