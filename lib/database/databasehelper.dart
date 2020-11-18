import 'dart:io';
import 'package:admin_keja/constants/constant.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

class DatabaseHelper {
  static final _databaseName = "cheki_keja.db";
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
  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

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
            image0 TEXT,
            image1 TEXT,
            image2 TEXT,
            image3 TEXT,
            image4 TEXT,
            image5 TEXT,
            image6 TEXT,
            image7 TEXT,
            image8 TEXT,
            image9 TEXT,
            image10 TEXT,
            image11 TEXT,
            image12 TEXT,
            image13 TEXT,
            image14 TEXT,
            image15 TEXT
          )
          ''');
    await db.execute('''
          CREATE TABLE $tagstable (
            id INTEGER PRIMARY KEY,
            online_id TEXT NOT NULL,
            apartment_id TEXT NOT NULL,
            tag0 TEXT NOT NULL,
            tag1 TEXT NOT NULL,
            tag2 TEXT NOT NULL,
            tag3 TEXT NOT NULL,
            tag4 TEXT NOT NULL,
            tag5 TEXT NOT NULL,
            tag6 TEXT,
            tag7 TEXT,
            tag8 TEXT,
            tag9 TEXT,
            tag10 TEXT,
            tag11 TEXT,
            tag12 TEXT,
            tag13 TEXT,
            tag14 TEXT,
            tag15 TEXT
          )
          ''');
    await db.execute('''
          CREATE TABLE $featurestable (
            id INTEGER PRIMARY KEY,
            online_id TEXT NOT NULL,
            apartment_id TEXT NOT NULL,
            feat0 TEXT NOT NULL,
            feat1 TEXT NOT NULL,
            feat2 TEXT NOT NULL,
            feat3 TEXT NOT NULL,
            feat4 TEXT NOT NULL,
            feat5 TEXT NOT NULL,
            feat6 TEXT NOT NULL,
            feat7 TEXT NOT NULL,
            feat8 TEXT NOT NULL,
            feat9 TEXT NOT NULL,
            feat10 TEXT NOT NULL
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
<<<<<<< HEAD
=======
          CREATE TABLE $homesummarytable (
            month TEXT NOT NULL,
            year TEXT NOT NULL,
            expected TEXT NOT NULL,
            paid TEXT NOT NULL,
            due TEXT NOT NULL
          )
          ''');
    await db.execute('''
>>>>>>> 5c6701b9a1d3c747abe0828cf7c36ded3d426857
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
