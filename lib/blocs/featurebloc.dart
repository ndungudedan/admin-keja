import 'dart:convert';
import 'package:admin_keja/connection/networkapi.dart';
import 'package:admin_keja/database/dao.dart';
import 'package:admin_keja/database/databasehelper.dart';
import 'package:admin_keja/models/features.dart';
import 'package:moor/moor.dart';
import 'package:rxdart/rxdart.dart';

class FeatureBloc {
  final repo = NetworkApi();
  var dao = DatabaseDao(databasehelper);
  FeatureBloc();
  final _featFetcher = BehaviorSubject<List<Features>>();
  Stream<List<Features>> get allFeatures => _featFetcher.stream;

  fetchFeatures(var apartmentId) async {
    var res = await repo.getFeatures(apartmentId);
    var map = json.decode(res);
    _featFetcher.sink.add(FeaturesResponse.fromJson(map).data.data);
    insertFeatures(FeaturesResponse.fromJson(map).data.data);
  }

  dispose() {
    _featFetcher.close();
  }

  Future<void> insertFeatures(List<Features> features) async {
    final _items = <MyFeaturesTableCompanion>[];
    List<String> onIds = [];
    features.forEach((feat) {
      var companion = MyFeaturesTableCompanion(
        onlineid: Value(feat.id),
        apartment_id: Value(feat.apartment_id),
        feat: Value(feat.feat),
      );
      onIds.add(feat.id);
      _items.add(companion);
    });
    dao.deleteFeatures(onIds);
    dao.insertFeatures(_items);
  }
}

//final feature_bloc = FeatureBloc();
