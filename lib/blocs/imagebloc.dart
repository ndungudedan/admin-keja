import 'dart:convert';

import 'package:admin_keja/connection/networkapi.dart';
import 'package:admin_keja/database/dao.dart';
import 'package:admin_keja/database/databasehelper.dart';
import 'package:admin_keja/models/apartment.dart';
import 'package:moor/moor.dart';
import 'package:rxdart/rxdart.dart';

class ImagesBloc {
  final repo = NetworkApi();
  var dao = DatabaseDao(databasehelper);
  ImagesBloc();
  final _fetcher = BehaviorSubject<List<Images>>();
  Stream<List<Images>> get allImages => _fetcher.stream;

  fetchImages(var apartmentId) async {
    var res = await repo.getImages(apartmentId);
    var map = json.decode(res);
    _fetcher.sink.add(ImagesResponse.fromJson(map).data.data);
    upsertImages(ImagesResponse.fromJson(map).data.data);
  }

  dispose() {
    _fetcher.close();
  }

  Future<void> upsertImages(List<Images> values) async {
    final _items = <MyImagesTableCompanion>[];
    values.forEach((val) {
      var companion = MyImagesTableCompanion(
        onlineid: Value(val.id),
        apartment_id: Value(val.apartment_id),
        tag: Value(val.tag),
        tag_id: Value(val.tag_id),
        image: Value(val.image),
      );
      _items.add(companion);
    });
    dao.insertUpdateImages(_items);
  }
}

//final images_bloc = ImagesBloc();
