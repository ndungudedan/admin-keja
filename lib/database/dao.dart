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
    (delete(myFeaturesTable)..where((r) => r.onlineid.isIn(values))).go();
  }
  void deleteMyHomeSummary() {
    (delete(myHomeSummaryTable)).go();
  }

  void deleteSingleFeature(var featId) {
    (delete(myFeaturesTable)..where((r) => r.onlineid.equals(featId))).go();
  }

  Stream<List<MyApartmentTableData>> watchApartments() {
    return (select(myApartmentTable)).watch();
  }

  Stream<MyApartmentTableData> watchSingleApartment(String apartId) {
    return (select(myApartmentTable)..where((r) => r.onlineid.equals(apartId)))
        .watchSingle();
  }

  Stream<List<MyFeaturesTableData>> watchFeatures(String apartId) {
    return (select(myFeaturesTable)
          ..where((r) => r.apartment_id.equals(apartId)))
        .watch();
  }

  Stream<List<MyImagesTableData>> watchImages(String apartId) {
    return (select(myImagesTable)..where((r) => r.apartment_id.equals(apartId)))
        .watch();
  }

  Stream<List<MyImagesTableData>> watchImagesLimit(String apartId) {
    return (select(myImagesTable)
          ..limit(6)
          ..where((r) => r.apartment_id.equals(apartId)))
        .watch();
  }

  Stream<List<MyHomeSummaryTableData>> watchHomeSummary() {
    return (select(myHomeSummaryTable)).watch();
  }

  Stream<List<MyPaymentHistoryTableData>> watchPaymentHistory(var month,var year) {
    return (select(myPaymentHistoryTable)..where((r) => r.month.equals(month)
    & r.year.equals(year))).watch();
  }
  Stream<List<MyPaymentHistoryTableData>> watchApartmentPaymentHistory(var apartId) {
    return (select(myPaymentHistoryTable)..where(
      (r) => r.apartment_id.equals(apartId))).watch();
  }
  Stream<List<MyTransactionsTableData>> watchApartmentTransactions(var apartId,var month,var year) {
    return (select(myTransactionsTable)..where(
      (r) => r.apartment_id.equals(apartId)& r.year.equals(year)
      & r.month.equals(month))).watch();
  }
  Stream<List<MyTenantTableData>> watchApartmentTenants(var apartId) {
    return (select(myTenantTable)..where(
      (r) => r.apartment_id.equals(apartId))).watch();
  }
    Stream<List<MyTransactionsTableData>> watchTenantTransactions(var tenantId) {
    return (select(myTransactionsTable)..where(
      (r) => r.user_id.equals(tenantId))).watch();
  }

  Stream<List<HomeData>> entriesWithCategory() {
    final query = select(myHomeSummaryTable).join([
      leftOuterJoin(myPaymentHistoryTable,
          myPaymentHistoryTable.month.equalsExp(myHomeSummaryTable.month)),
    ]);
  }

  void insertApartments(List<MyApartmentTableCompanion> values) async {
    await batch((batch) {
      batch.insertAll(myApartmentTable, values);
    }).catchError((Object error) {
      print('errotr');
    });
  }

  void upsertApartment(MyApartmentTableCompanion value) {
    into(myApartmentTable).insertOnConflictUpdate(value);
  }
  void updateEnabled(bool enabled,var id){
    (update(myApartmentTable)
      ..where((t) => t.onlineid.equals(id))
    ).write(MyApartmentTableCompanion(
      enabled: Value(enabled),
    ),
  );
  }

  void insertFeatures(List<MyFeaturesTableCompanion> values) async {
    await batch((batch) {
      batch.insertAllOnConflictUpdate(myFeaturesTable, values);
    }).catchError((Object error) {
      print('errotr');
    });
  }

  void upsertFeature(MyFeaturesTableCompanion value) {
    into(myFeaturesTable).insertOnConflictUpdate(value);
  }

  void insertUpdateImages(List<MyImagesTableCompanion> values) async {
    await batch((batch) {
      batch.insertAllOnConflictUpdate(myImagesTable, values);
    }).catchError((Object error) {
      print('errotr');
    });
  }

  void upsertImage(MyImagesTableCompanion value) {
    into(myImagesTable).insertOnConflictUpdate(value);
  }

  void insertUpdatePaymentHistory(
      List<MyPaymentHistoryTableCompanion> values) async {
    await batch((batch) {
      batch.insertAllOnConflictUpdate(myPaymentHistoryTable, values);
    }).catchError((Object error) {
      print('errotr');
    });
  }

  void insertHomeSummary(List<MyHomeSummaryTableCompanion> values) async {
    await batch((batch) {
      batch.insertAll(myHomeSummaryTable, values);
    }).catchError((Object error) {
      print('errotr');
    });
  }

    void insertUpdateTenants(
      List<MyTenantTableCompanion> values) async {
    await batch((batch) {
      batch.insertAllOnConflictUpdate(myTenantTable, values);
    }).catchError((Object error) {
      print('errotr');
    });
  }
      void insertUpdateTransactions(
      List<MyTransactionsTableCompanion> values) async {
    await batch((batch) {
      batch.insertAllOnConflictUpdate(myTransactionsTable, values);
    }).catchError((Object error) {
      print('errotr');
    });
  }
}


class HomeData {
  final MyHomeSummaryTableData homeSummaryTableData;
  final MyPaymentHistoryTableData paymentHistoryTableData;

  HomeData(this.homeSummaryTableData, this.paymentHistoryTableData);
}
