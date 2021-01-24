import 'dart:convert';
import 'package:admin_keja/connection/networkapi.dart';
import 'package:admin_keja/database/dao.dart';
import 'package:admin_keja/database/databasehelper.dart';
import 'package:admin_keja/models/tenant.dart';
import 'package:moor/moor.dart';

class MyTenantBloc {
  final repo = NetworkApi();
  var dao = DatabaseDao(databasehelper);
  MyTenantBloc();

  fetchMyTenants(var apartmentId) async {
    var res = await repo.fetchTenants(apartmentId);
    var map = json.decode(res);
    insertMyTenants(MyTenantResponse.fromJson(map).data.tenants);
  }

  Future<void> insertMyTenants(List<MyTenant> result) async {
    final _items = <MyTenantTableCompanion>[];
    result.forEach((value) {
      var companion = MyTenantTableCompanion(
        onlineid: Value(value.id),
        apartment_id:Value(value.apartment_id),
        photo: Value(value.photo),
        name: Value(value.name),
        email: Value(value.email),
        payed: Value(value.payed),
        unit: Value(value.unit),
      );
      _items.add(companion);
    });
    dao.insertUpdateTenants(_items);
  }
}
