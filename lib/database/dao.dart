import 'package:admin_keja/database/databasehelper.dart';
import 'package:moor/moor.dart';
part 'dao.g.dart';

@UseDao(tables: [
  MyApartmentTable,
  MyImagesTable,
  MyFeaturesTable,
  MyPaymentHistoryTable,
  MyHomeSummaryTable,
  MyTransactionsTable,
  MyTenantTable
])
class DatabaseDao extends DatabaseAccessor<DatabaseHelper>
    with _$DatabaseDaoMixin {
  DatabaseDao(DatabaseHelper db) : super(db);

  void deleteAllApartments() {
    (delete(myApartmentTable)).go();
  }

  void deleteFeatures(Iterable<String> values) {
    (delete(myFeaturesTable)..where((r) =>r.onlineid.isIn(values))).go();
  }

  Stream<List<MyApartmentTableData>> watchApartments() {
    return (select(myApartmentTable)).watch();
  }

  Stream<List<MyFeaturesTableData>> watchFeatures() {
    return (select(myFeaturesTable)).watch();
  }

  Stream<List<MyImagesTableData>> watchImages() {
    return (select(myImagesTable)).watch();
  }
  Stream<List<MyImagesTableData>> watchImagesLimit() {
    return (select(myImagesTable)..limit(6)).watch();
  }

  void insertApartments(List<MyApartmentTableCompanion> values) async {
    await batch((batch) {
      batch.insertAll(myApartmentTable, values);
    }).catchError((Object error) {
      print('errotr');
    });
  }

  void insertFeatures(List<MyFeaturesTableCompanion> values) async {
    await batch((batch) {
      batch.insertAll(myFeaturesTable, values);
    }).catchError((Object error) {
      print('errotr');
    });
  }
  void insertUpdateImages(List<MyImagesTableCompanion> values) async {
    await batch((batch) {
      batch.insertAllOnConflictUpdate(myImagesTable, values);
    }).catchError((Object error) {
      print('errotr');
    });
  }
}
