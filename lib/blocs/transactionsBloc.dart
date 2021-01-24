import 'dart:convert';
import 'package:admin_keja/connection/networkapi.dart';
import 'package:admin_keja/database/dao.dart';
import 'package:admin_keja/database/databasehelper.dart';
import 'package:admin_keja/models/transaction.dart';
import 'package:moor/moor.dart';

class MyTransactionsBloc {
  final repo = NetworkApi();
  var dao = DatabaseDao(databasehelper);
  MyTransactionsBloc();

  fetchTransactions(var apartmentId,var month,var year) async {
    var res = await repo.fetchTransactions(apartmentId,month,year);
    var map = json.decode(res);
    insertTransactions(TransactionResponse.fromJson(map).data.transactions);
  }
fetchTenantTransactions(var apartmentId,var tenantId) async {
    var res = await repo.fetchTenantTransactions(apartmentId,tenantId);
    var map = json.decode(res);
    insertTransactions(TransactionResponse.fromJson(map).data.transactions);
  }
  Future<void> insertTransactions(List<MyTransaction> result) async {
    final _items = <MyTransactionsTableCompanion>[];
    result.forEach((value) {
      var companion = MyTransactionsTableCompanion(
        onlineid: Value(value.id),
        year: Value(value.year),
        month: Value(value.month),
        apartment_id: Value(value.apartment_id),
        transaction_id: Value(value.transaction_id),
        user_id: Value(value.user_id),
        status: Value(value.status),
        amount: Value(value.amount),
        time: Value(value.time),
        type: Value(value.type),
      );
      _items.add(companion);
    });
    dao.insertUpdateTransactions(_items);
  }
}
