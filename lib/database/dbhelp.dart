import 'dart:io';
import 'package:admin_keja/constants/constant.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

class DatHelper {
  static final _databaseName = "admin_keja.db";
  static final _databaseVersion = 1;

  static final imagestable = Constants.imagestable;
  static final tagstable = Constants.tagstable;
  static final featurestable = Constants.featurestable;
  static final apartmenttable = Constants.apartmenttable;
  static final paymenthistorytable = Constants.paymenthistorytable;
  static final homesummarytable = Constants.homesummarytable;
  static final transactionstable = Constants.transactionstable;
  static final tenanttable = Constants.tenanttable;

  // make this a singleton class
  DatHelper._privateConstructor();
  static final DatHelper instance = DatHelper._privateConstructor();

  // only have a single app-wide reference to the database
  static Database _database;
  Future<Database> get database async {
    if (_database != null) return _database;
    // lazily instantiate the db the first time it is accessed
    _database = await _initDatabase();
    return _database;
  }

  // this opens the database (and creates it if it doesn't exist)
  _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _databaseName);
    return await openDatabase(path,
        version: _databaseVersion, onCreate: _onCreate);
  }

  // SQL code to create the database table
  Future _onCreate(Database db, int version) async {
    await db.execute('''
          CREATE TABLE $apartmenttable (
            id INTEGER PRIMARY KEY,
            online_id TEXT NOT NULL,
            owner_id TEXT NOT NULL,
            banner TEXT,
            bannertag TEXT,
            category TEXT NOT NULL,
            title TEXT NOT NULL,
            description TEXT,
            location TEXT ,
            emailaddress TEXT NOT NULL,
            address TEXT,
            phone TEXT NOT NULL,
            video TEXT NOT NULL,
            price TEXT,
            deposit TEXT NOT NULL,
            space TEXT NOT NULL,
            latitude TEXT NOT NULL,
            longitude TEXT NOT NULL,
            likes TEXT NOT NULL,
            comments TEXT NOT NULL,
            rating	 TEXT NOT NULL
          )
          ''');
    await db.execute('''
          CREATE TABLE $imagestable (
            id INTEGER PRIMARY KEY,
            online_id TEXT NOT NULL,
            apartment_id TEXT NOT NULL,
            image TEXT
          )
          ''');
    await db.execute('''
          CREATE TABLE $tagstable (
            id INTEGER PRIMARY KEY,
            online_id TEXT NOT NULL,
            apartment_id TEXT NOT NULL,
            image_id TEXT NOT NULL,
            tag TEXT NOT NULL
          )
          ''');
    await db.execute('''
          CREATE TABLE $featurestable (
            id INTEGER PRIMARY KEY,
            online_id TEXT NOT NULL,
            apartment_id TEXT NOT NULL,
            feat TEXT NOT NULL
          )
          ''');
    await db.execute('''
          CREATE TABLE $paymenthistorytable (
            id INTEGER PRIMARY KEY,
            online_id TEXT NOT NULL,
            apartment_id TEXT NOT NULL,
            title TEXT NOT NULL,
            company_id TEXT NOT NULL,
            month TEXT NOT NULL,
            year TEXT NOT NULL,
            expected TEXT NOT NULL,
            paid TEXT NOT NULL,
            due TEXT NOT NULL
          )
          ''');
    await db.execute('''
          CREATE TABLE $homesummarytable (
            month TEXT NOT NULL,
            year TEXT NOT NULL,
            expected TEXT NOT NULL,
            paid TEXT NOT NULL,
            due TEXT NOT NULL
          )
          ''');
    await db.execute('''
          CREATE TABLE $transactionstable (
            id INTEGER PRIMARY KEY,
            online_id TEXT NOT NULL,
            user_id TEXT NOT NULL,
            transaction_id TEXT NOT NULL,
            apartment_id TEXT NOT NULL,
            status TEXT NOT NULL,
            amount TEXT NOT NULL,
            time TEXT NOT NULL,
            month TEXT NOT NULL,
            year TEXT NOT NULL,
            type TEXT NOT NULL
          )
          ''');
    await db.execute('''
          CREATE TABLE $tenanttable (
            id INTEGER PRIMARY KEY,
            online_id TEXT NOT NULL,
            apartment_id TEXT NOT NULL,
            photo TEXT NOT NULL,
            email TEXT NOT NULL,
            name TEXT NOT NULL,
            payed TEXT NOT NULL,
            unit TEXT
          )
          ''');
  }
}
