import 'dart:convert';
import 'package:admin_keja/connection/networkapi.dart';
import 'package:admin_keja/database/dao.dart';
import 'package:admin_keja/database/databasehelper.dart';
import 'package:admin_keja/models/apartment.dart';
import 'package:moor/moor.dart';
import 'package:rxdart/rxdart.dart';

class MyApartmentsBloc {
  final repo = NetworkApi();
  var dao = DatabaseDao(databasehelper);
  MyApartmentsBloc();
  final fetcher = BehaviorSubject<List<MyApartment>>();
  Stream<List<MyApartment>> get result => fetcher.stream;

  fetchMyApartments(var companyId) async {
    var res = await repo.fetchApartments(companyId);
    var map = json.decode(res);
    fetcher.sink.add(MyApartmentResponse.fromJson(map).data.apartments);
    await insertMyApartments(MyApartmentResponse.fromJson(map).data.apartments);
  }

  dispose() {
    fetcher.close();
  }

  Future<void> insertMyApartments(List<MyApartment> myApartments) async {
    dao.deleteAllApartments();
   final _items = <MyApartmentTableCompanion>[];
    myApartments.forEach((myApartment) {
      var companion = MyApartmentTableCompanion(
        onlineid: Value(myApartment.id),
        banner: Value(myApartment.banner),
        bannertag: Value(myApartment.bannertag),
        description: Value(myApartment.description),
        title: Value(myApartment.title),
        category: Value(myApartment.category),
        emailaddress: Value(myApartment.email),
        location: Value(myApartment.location),
        address: Value(myApartment.address),
        phone: Value(myApartment.phone),
        video: Value(myApartment.video),
        price: Value(myApartment.price),
        deposit: Value(myApartment.deposit),
        space: Value(myApartment.space),
        latitude: Value(myApartment.latitude),
        longitude: Value(myApartment.longitude),
        rating: Value(myApartment.rating),
        likes: Value(myApartment.likes),
        comments: Value(myApartment.comments),
        enabled: Value(myApartment.enabled=='1' ? true : false),
      );
      _items.add(companion);
    });
    dao.insertApartments(_items);
  }

}
