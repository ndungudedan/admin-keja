// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'locations.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Point _$PointFromJson(Map<String, dynamic> json) {
  return Point(
    address: json['address'] as String,
    id: json['id'] as String,
    latitude: json['latitude'] as String,
    longitude: json['longitude'] as String,
    title: json['title'] as String,
    phone: json['phone'] as String,
  );
}

Map<String, dynamic> _$PointToJson(Point instance) => <String, dynamic>{
      'address': instance.address,
      'id': instance.id,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'title': instance.title,
      'phone': instance.phone,
    };

Locations _$LocationsFromJson(Map<String, dynamic> json) {
  return Locations(
    data: (json['data'] as List)
        ?.map(
            (e) => e == null ? null : Point.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$LocationsToJson(Locations instance) => <String, dynamic>{
      'data': instance.data,
    };
