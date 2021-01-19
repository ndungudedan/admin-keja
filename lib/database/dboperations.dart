import 'package:admin_keja/constants/constant.dart';
import 'package:admin_keja/database/databasehelper.dart';
import 'package:admin_keja/database/dbhelp.dart';
import 'package:admin_keja/models/apartment.dart';
import 'package:admin_keja/models/features.dart';
import 'package:admin_keja/models/home.dart';
import 'package:admin_keja/models/tenant.dart';
import 'package:admin_keja/models/transaction.dart';
import 'package:sqflite/sqflite.dart';

class DbOperations {
  final dbHelper = DatHelper.instance;
  static final imagestable = Constants.imagestable;
  static final tagstable = Constants.tagstable;
  static final featurestable = Constants.featurestable;
  static final apartmenttable = Constants.apartmenttable;
  static final paymenthistorytable = Constants.paymenthistorytable;
  static final homesummarytable = Constants.homesummarytable;
  static final transactionstable = Constants.transactionstable;
  static final tenanttable = Constants.tenanttable;

  static final columnId = '_id';
  static final columnName = 'name';
  static final columnAge = 'age';

  // make this a singleton class
  DbOperations._privateConstructor();
  static final DbOperations instance = DbOperations._privateConstructor();

  Future<MyApartment> insertApartment(MyApartment myApartment) async {
    Database _db = await instance.dbHelper.database;
    var count = Sqflite.firstIntValue(await _db.rawQuery(
        "SELECT COUNT(*) FROM $apartmenttable WHERE online_id = ?",
        [myApartment.id]));
    if (count == 0) {
      await _db.insert("$apartmenttable", myApartment.toMap());
    } else {
      await _db.update(apartmenttable, myApartment.toMap(),
          where: 'id = ?', whereArgs: [myApartment.id]);
    }
    return myApartment;
  }

  Future<List<MyApartment>> fetchApartments() async {
    Database _db = await instance.dbHelper.database;
    List<Map> results = await _db.query("$apartmenttable",
        columns: MyApartment.columns, orderBy: "id DESC");

    List<MyApartment> apartments = new List();
    results.forEach((result) {
      MyApartment apartment = MyApartment.fromMap(result);
      apartments.add(apartment);
    });

    return apartments;
  }

  Future<int> updateBanner(var id, var val) async {
    Database db = await instance.dbHelper.database;
    return await db.rawUpdate(
        'UPDATE $apartmenttable SET banner = ? WHERE online_id = ?', [val, id]);
  }

   Future<String> fetchBanner(var id) async {
    Database _db = await instance.dbHelper.database;
    var count = Sqflite.firstIntValue(await _db.rawQuery(
        "SELECT COUNT(*) FROM $apartmenttable WHERE online_id = ?", ['$id']));
    if (count == 0) {
      return "";
    } else {
      var results = await _db.rawQuery(
          'SELECT banner FROM $apartmenttable WHERE online_id = ?', ['$id']);
      var val = results.first;
      var res = val['banner'] as String;
      if (res == null || res.isEmpty) {
        return "";
      } else {
        return res;
      }
    }
  } 

  //Images
  Future<Images> insertImages(Images images) async {
    Database _db = await instance.dbHelper.database;
    var count = Sqflite.firstIntValue(await _db.rawQuery(
        "SELECT COUNT(*) FROM $imagestable WHERE online_id = ?", [images.id]));
    if (count == 0) {
      await _db.insert("$imagestable", images.toMap());
    } else {
      await _db.update(imagestable, images.toMap(),
          where: 'online_id = ?', whereArgs: [images.id]);
    }
    return images;
  }

  Future<List<Images>> fetchImages(var id) async {
    Database _db = await instance.dbHelper.database;
    List<Map> results = await _db
        .rawQuery('SELECT * FROM $imagestable WHERE apartment_id = ?', ['$id']);

    List<Images> images = List();
    results.forEach((result) {
      Images image = Images.fromMap(result);
      images.add(image);
    });

    return images;
  }

  Future<List<Images>> fetchDetailsImages(var id) async {
    Database _db = await instance.dbHelper.database;
    List<Map> results = await _db.rawQuery(
        'SELECT * FROM $imagestable WHERE apartment_id = ? LIMIT 6', ['$id']);

    List<Images> images = List();
    results.forEach((result) {
      Images image = Images.fromMap(result);
      images.add(image);
    });

    return images;
  }

/*   Future<String> fetchSingleImage(var id) async {
    Database _db = await instance.dbHelper.database;
    var count = Sqflite.firstIntValue(await _db.rawQuery(
        "SELECT COUNT(*) FROM $imagestable WHERE online_id = ?", ['$id']));
    if (count == 0) {
      return "";
    } else {
      var results = await _db.rawQuery(
          'SELECT image FROM $imagestable WHERE online_id = ?', ['$id']);
      var res = results.first;
      if (res == null || res.isEmpty) {
        return "";
      } else {
        return res.;
      }
    }
  } */

  Future<int> updateImage(var col, var id, var val) async {
    Database db = await instance.dbHelper.database;
    return await db.rawUpdate(
        'UPDATE $imagestable SET $col = ? WHERE apartment_id = ?', [val, id]);
  }

  //Tags
  Future<Tags> insertTags(Tags tags) async {
    Database _db = await instance.dbHelper.database;
    var count = Sqflite.firstIntValue(await _db.rawQuery(
        "SELECT COUNT(*) FROM $tagstable WHERE online_id = ?", [tags.id]));
    if (count == 0) {
      await _db.insert("$tagstable", tags.toMap());
    } else {
      await _db.update(tagstable, tags.toMap(),
          where: 'online_id = ?', whereArgs: [tags.id]);
    }
    return tags;
  }

  Future<List<Tags>> fetchTags(var id) async {
    Database _db = await instance.dbHelper.database;
    List<Map> results = await _db
        .rawQuery('SELECT * FROM $tagstable WHERE apartment_id = ?', ['$id']);
    List<Tags> tags = List();
    results.forEach((result) {
      Tags tag = Tags.fromMap(result);
      tags.add(tag);
    });

    return tags;
  }

  Future<int> updateTag(var col, var id, var val) async {
    Database db = await instance.dbHelper.database;
    return await db.rawUpdate(
        'UPDATE $tagstable SET $col = ? WHERE apartment_id = ?', [val, id]);
  }

  //Features
  Future<Features> insertFeatures(Features features) async {
    Database _db = await instance.dbHelper.database;
    var count = Sqflite.firstIntValue(await _db.rawQuery(
        "SELECT COUNT(*) FROM $featurestable WHERE online_id = ?",
        [features.id]));
    if (count == 0) {
      await _db.insert("$featurestable", features.toMap());
    } else {
      await _db.update(featurestable, features.toMap(),
          where: 'online_id = ?', whereArgs: [features.id]);
    }
    return features;
  }

  Future<List<Features>> fetchFeatures(var id) async {
    Database _db = await instance.dbHelper.database;
    List<Map> results = await _db.rawQuery(
        'SELECT * FROM $featurestable WHERE apartment_id = ?', ['$id']);
    List<Features> features = List();
    results.forEach((result) {
      Features feature = Features.fromMap(result);
      features.add(feature);
    });
    return features;
  }
Future<int> deleteFeature(int id) async {
    Database db = await instance.dbHelper.database;
    return await db.delete(featurestable, where: 'online_id = ?', whereArgs: [id]);
  }

//Home
  Future<MyHome> insertHome(MyHome myhome) async {
    Database _db = await instance.dbHelper.database;
    var count = Sqflite.firstIntValue(await _db.rawQuery(
        "SELECT COUNT(*) FROM $paymenthistorytable WHERE online_id = ?",
        [myhome.id]));
    if (count == 0) {
      await _db.insert("$paymenthistorytable", myhome.toMap());
    } else {
      await _db.update(paymenthistorytable, myhome.toMap(),
          where: 'online_id = ?', whereArgs: [myhome.id]);
    }
    return myhome;
  }

  Future<List<MyHome>> fetchAllHome() async {
    Database _db = await instance.dbHelper.database;
    List<Map> results = await _db.query("$paymenthistorytable",
        columns: MyHome.columns, orderBy: "id DESC");

    List<MyHome> myhomes = new List();
    results.forEach((result) {
      MyHome myHome = MyHome.fromMap(result);
      myhomes.add(myHome);
    });
    return myhomes;
  }

  Future<List<MyHome>> fetchApartmentHome(var id, var month, var year) async {
    Database _db = await instance.dbHelper.database;
    List<Map> results = await _db.rawQuery(
        'SELECT * FROM $paymenthistorytable WHERE apartment_id = ?', [id]);

    List<MyHome> myhomes = new List();
    results.forEach((result) {
      MyHome myHome = MyHome.fromMap(result);
      myhomes.add(myHome);
    });
    return myhomes;
  }

  Future<List<MyHome>> fetchHome(var month, var year) async {
    Database _db = await instance.dbHelper.database;
    List<Map> results = await _db.rawQuery(
        'SELECT * FROM $paymenthistorytable WHERE month = ? AND year = ? ORDER BY month DESC, year DESC',
        [month, year]);
    List<MyHome> myhomes = new List();
    results.forEach((result) {
      MyHome myHome = MyHome.fromMap(result);
      myhomes.add(myHome);
    });
    return myhomes;
  }

//Home Summary
  Future<MyHomeSummary> insertHomeSummary(MyHomeSummary myhomesummary) async {
    Database _db = await instance.dbHelper.database;
    var count = Sqflite.firstIntValue(await _db.rawQuery(
        "SELECT COUNT(*) FROM $homesummarytable WHERE month = ? AND year = ?",
        [myhomesummary.month, myhomesummary.year]));
    if (count == 0) {
      await _db.insert("$homesummarytable", myhomesummary.toMap());
    } else {
      await _db.update(homesummarytable, myhomesummary.toMap(),
          where: 'month = ? AND year = ?',
          whereArgs: [myhomesummary.month, myhomesummary.year]);
    }
    return myhomesummary;
  }

  Future<List<MyHomeSummary>> fetchHomeSummary() async {
    Database _db = await instance.dbHelper.database;
    List<Map> results = await _db.query("$homesummarytable",
        columns: MyHomeSummary.columns, orderBy: "year DESC");
    List<MyHomeSummary> myhomes = new List();
    results.forEach((result) {
      MyHomeSummary myHome = MyHomeSummary.fromMap(result);
      myhomes.add(myHome);
    });
    return myhomes;
  }

//Transactions
  Future<MyTransaction> insertTransaction(MyTransaction transaction) async {
    Database _db = await instance.dbHelper.database;
    var count = Sqflite.firstIntValue(await _db.rawQuery(
        "SELECT COUNT(*) FROM $transactionstable WHERE online_id = ?",
        [transaction.id]));
    if (count == 0) {
      await _db.insert("$transactionstable", transaction.toMap());
    } else {
      await _db.update(transactionstable, transaction.toMap(),
          where: 'online_id = ?', whereArgs: [transaction.id]);
    }
    return transaction;
  }

  Future<List<MyTransaction>> fetchTransactions(
      var aId, var month, var year) async {
    Database _db = await instance.dbHelper.database;
    List<Map> results = await _db.rawQuery(
        'SELECT * FROM $transactionstable WHERE apartment_id = ? AND month = ? AND year = ? ',
        [aId, month, year]);
    List<MyTransaction> myTransactions = new List();
    results.forEach((result) {
      MyTransaction myTrans = MyTransaction.fromMap(result);
      myTransactions.add(myTrans);
    });
    return myTransactions;
  }

//Tenants
  Future<MyTenant> insertTenant(MyTenant tenant) async {
    Database _db = await instance.dbHelper.database;
    var count = Sqflite.firstIntValue(await _db.rawQuery(
        "SELECT COUNT(*) FROM $tenanttable WHERE online_id = ?", [tenant.id]));
    if (count == 0) {
      await _db.insert("$tenanttable", tenant.toMap());
    } else {
      await _db.update(tenanttable, tenant.toMap(),
          where: 'online_id = ?', whereArgs: [tenant.id]);
    }
    return tenant;
  }

  Future<List<MyTenant>> fetchTenants(var id) async {
    Database _db = await instance.dbHelper.database;
    List<Map> results = await _db
        .rawQuery('SELECT * FROM $tenanttable WHERE apartment_id = ?', ['$id']);
    List<MyTenant> myTenants = new List();
    results.forEach((result) {
      MyTenant val = MyTenant.fromMap(result);
      myTenants.add(val);
    });
    return myTenants;
  }

  Future<List<MyTransaction>> fetchTenantTransactions(var tId, var aId) async {
    Database _db = await instance.dbHelper.database;
    List<Map> results = await _db.rawQuery(
        'SELECT * FROM $transactionstable WHERE apartment_id = ? AND user_id= ?',
        [aId, tId]);
    List<MyTransaction> myTransactions = new List();
    results.forEach((result) {
      MyTransaction myTrans = MyTransaction.fromMap(result);
      myTransactions.add(myTrans);
    });
    return myTransactions;
  }

  /*  Future<MyApartment> updateApartment(MyApartment myApartment) async {
    Database db = await instance.dbHelper.database;
    await db.update(apartmenttable, myApartment.toMap(),
        where: 'id = ?', whereArgs: [myApartment.id]);
    return myApartment;
  }

  // All of the rows are returned as a list of maps, where each map is
  // a key-value list of columns.
  Future<List<Map<String, dynamic>>> queryAllRows() async {
    Database db = await instance.dbHelper.database;
    return await db.query(salestable);
  }

  // All of the methods (insert, query, update, delete) can also be done using
  // raw SQL commands. This method uses a raw query to give the row count.
  Future<int> queryRowCount() async {
    Database db = await instance.dbHelper.database;
    return Sqflite.firstIntValue(
        await db.rawQuery('SELECT COUNT(*) FROM $salestable'));
  }

  // We are assuming here that the id column in the map is set. The other
  // column values will be used to update the row.
  Future<int> update(Map<String, dynamic> row) async {
    Database db = await instance.dbHelper.database;
    int id = row[columnId];
    return await db
        .update(salestable, row, where: '$columnId = ?', whereArgs: [id]);
  }

  // Deletes the row specified by the id. The number of affected rows is
  // returned. This should be 1 as long as the row exists.
  Future<int> delete(int id) async {
    Database db = await instance.dbHelper.database;
    return await db.delete(salestable, where: '$columnId = ?', whereArgs: [id]);
  } */
}
