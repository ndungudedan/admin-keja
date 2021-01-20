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
  void deleteSingleFeature(var featId){
    (delete(myFeaturesTable)..where((r) =>r.onlineid.equals(featId))).go();
  }

  Stream<List<MyApartmentTableData>> watchApartments() {
    return (select(myApartmentTable)).watch();
  }

  Stream<MyApartmentTableData> watchSingleApartment(String apartId) {
    return (select(myApartmentTable)..where((r) =>r.onlineid.equals(apartId))).watchSingle();
  }

  Stream<List<MyFeaturesTableData>> watchFeatures(String apartId) {
    return (select(myFeaturesTable)..where((r) =>r.apartment_id.equals(apartId))).watch();
  }

  Stream<List<MyImagesTableData>> watchImages(String apartId) {
    return (select(myImagesTable)..where((r) =>r.apartment_id.equals(apartId))).watch();
  }
  Stream<List<MyImagesTableData>> watchImagesLimit(String apartId) {
    return (select(myImagesTable)..limit(6)..where((r) =>r.apartment_id.equals(apartId))).watch();
  }

  void insertApartments(List<MyApartmentTableCompanion> values) async {
    await batch((batch) {
      batch.insertAll(myApartmentTable, values);
    }).catchError((Object error) {
      print('errotr');
    });
  }
  void upsertApartment(MyApartmentTableCompanion value){
     into(myApartmentTable).insertOnConflictUpdate(value);
  }

  void insertFeatures(List<MyFeaturesTableCompanion> values) async {
    await batch((batch) {
      batch.insertAllOnConflictUpdate(myFeaturesTable, values);
    }).catchError((Object error) {
      print('errotr');
    });
  }
  void upsertFeature(MyFeaturesTableCompanion value){
     into(myFeaturesTable).insertOnConflictUpdate(value);
  }
  void insertUpdateImages(List<MyImagesTableCompanion> values) async {
    await batch((batch) {
      batch.insertAllOnConflictUpdate(myImagesTable, values);
    }).catchError((Object error) {
      print('errotr');
    });
  }
}
