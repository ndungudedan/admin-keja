import 'dart:io';
import 'package:admin_keja/database/dao.dart';
import 'package:moor/ffi.dart';
import 'package:moor/moor.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
part 'databasehelper.g.dart';

LazyDatabase _openConnection() {
  // the LazyDatabase util lets us find the right location for the file async.
  return LazyDatabase(() async {
    // put the database file, called db.sqlite here, into the documents folder
    // for your app.
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'db.sqlite'));
    return VmDatabase(file);
  });
}

@UseMoor(tables: [MyApartmentTable,MyImagesTable,MyFeaturesTable,
MyPaymentHistoryTable,MyHomeSummaryTable,MyTransactionsTable,MyTenantTable], daos: [DatabaseDao])
class DatabaseHelper extends _$DatabaseHelper {
  // we tell the database where to store the data with this constructor
  DatabaseHelper() : super(_openConnection());

  // you should bump this number whenever you change or add a table definition. Migrations
  // are covered later in this readme.
  @override
  int get schemaVersion => 2;
}
final databasehelper = DatabaseHelper();
  class MyApartmentTable extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get onlineid => text()();
  TextColumn get banner => text()();
  TextColumn get bannertag => text()();
  TextColumn get description => text().nullable()();
  TextColumn get title => text()();
  TextColumn get category => text()();
  TextColumn get emailaddress => text().nullable()();
  TextColumn get location => text().nullable()();
  TextColumn get address => text().nullable()();
  TextColumn get phone => text().nullable()();
  TextColumn get video => text().nullable()();
  TextColumn get price => text()();
  TextColumn get deposit => text()();
  TextColumn get space => text()();
  TextColumn get latitude => text()();
  TextColumn get longitude => text()();
  TextColumn get rating => text()();
  TextColumn get likes => text()();
  TextColumn get comments => text()();
}
class MyImagesTable extends Table {
  TextColumn get onlineid => text()();
  TextColumn get apartment_id => text()();
  TextColumn get tag_id => text()();
  TextColumn get tag => text()();
  TextColumn get image => text()();

   @override
  Set<Column> get primaryKey => {onlineid};
}
class MyFeaturesTable extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get onlineid => text()();
  TextColumn get apartment_id => text()();
  TextColumn get feat => text()();
}
class MyPaymentHistoryTable extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get onlineid => text()();
  TextColumn get apartment_id => text()();
  TextColumn get title => text()();
  TextColumn get company_id => text()();
  TextColumn get month => text()();
  TextColumn get year => text()();
  TextColumn get expected => text()();
  TextColumn get paid => text()();
  TextColumn get due => text()();
}
class MyHomeSummaryTable extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get month => text()();
  TextColumn get year => text()();
  TextColumn get expected => text()();
  TextColumn get paid => text()();
  TextColumn get due => text()();
}
class MyTransactionsTable extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get onlineid => text()();
  TextColumn get apartment_id => text()();
  TextColumn get transaction_id => text()();
  TextColumn get user_id => text()();
  TextColumn get month => text()();
  TextColumn get year => text()();
  TextColumn get status => text()();
  TextColumn get amount => text()();
  TextColumn get time => text()();
  TextColumn get type => text()();
}
class MyTenantTable extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get onlineid => text()();
  TextColumn get apartment_id => text()();
  TextColumn get photo => text()();
  TextColumn get name => text()();
  TextColumn get email => text()();
  TextColumn get payed => text()();
  TextColumn get unit => text()();
}