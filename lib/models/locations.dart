import 'package:json_annotation/json_annotation.dart';
part 'locations.g.dart';

@JsonSerializable()
class Point {
  Point({
    this.address,
    this.id,
    this.latitude,
    this.longitude,
    this.title,
    this.phone,
  });

  factory Point.fromJson(Map<String, dynamic> json) => _$PointFromJson(json);
  Map<String, dynamic> toJson() => _$PointToJson(this);
  final String address;
  final String id;
  final String latitude;
  final String longitude;
  final String title;
  final String phone;
}

@JsonSerializable()
class Locations {
  Locations({
    this.data,
  });

  factory Locations.fromJson(Map<String, dynamic> json) =>
      _$LocationsFromJson(json);
  Map<String, dynamic> toJson() => _$LocationsToJson(this);

  final List<Point> data;
}
