import 'dart:convert';
import 'package:admin_keja/connection/networkapi.dart';
import 'package:admin_keja/database/dao.dart';
import 'package:admin_keja/database/databasehelper.dart';
import 'package:admin_keja/models/home.dart';
import 'package:moor/moor.dart';

class MyHomeBloc {
  final repo = NetworkApi();
  var dao = DatabaseDao(databasehelper);
  MyHomeBloc();

  fetchMyHome(var companyId, month, year) async {
    var res = await repo.fetchHome(companyId, month, year);
    var map = json.decode(res);
    insertMyHomeSummary(MyHomeResponse.fromJson(map).summary.values);
    insertPaymentHistory(MyHomeResponse.fromJson(map).data.myhomes);
  }

  Future<void> insertMyHomeSummary(List<MyHomeSummary> result) async {
    dao.deleteMyHomeSummary();
    final _items = <MyHomeSummaryTableCompanion>[];
    result.forEach((value) {
      var companion = MyHomeSummaryTableCompanion(
        month: Value(value.month),
        year: Value(value.year),
        expected: Value(value.expected),
        paid: Value(value.paid),
        due: Value(value.due),
      );
      _items.add(companion);
    });
    dao.insertHomeSummary(_items);
  }

  Future<void> insertPaymentHistory(List<MyHome> result) async {
    final _items = <MyPaymentHistoryTableCompanion>[];
    result.forEach((value) {
      var companion = MyPaymentHistoryTableCompanion(
        month: Value(value.month),
        year: Value(value.year),
        expected: Value(value.expected),
        paid: Value(value.paid),
        due: Value(value.due),
        apartment_id: Value(value.apartment_id),
        onlineid: Value(value.id),
        title: Value(value.title),
        company_id: Value(value.company_id),
        timestamp: Value(value.timestamp),
      );
      _items.add(companion);
    });
    dao.insertUpdatePaymentHistory(_items);
  }
}
