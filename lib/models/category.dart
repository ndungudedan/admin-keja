import 'package:admin_keja/models/status.dart';
import 'package:json_annotation/json_annotation.dart';
part 'category.g.dart';

@JsonSerializable()
class CategoryResponse {
  MyCategoryList data;
  Status status;

  CategoryResponse({
    this.status,
    this.data,
  });

  factory CategoryResponse.fromJson(Map<String, dynamic> json) =>
      _$CategoryResponseFromJson(json);

  Map<String, dynamic> toJson() => _$CategoryResponseToJson(this);
}
@JsonSerializable()
class MyCategoryList {
  List<MyCategory> categorys;

  MyCategoryList({
    this.categorys,
  });

  factory MyCategoryList.fromJson(List<dynamic> json) {
    return MyCategoryList(
        categorys: json
            .map((e) => MyCategory.fromJson(e as Map<String, dynamic>))
            .toList());
  }
}

@JsonSerializable()
class MyCategory {
  String id;
  String title;
  MyCategory({
    this.id,
    this.title,
  });

  factory MyCategory.fromJson(Map<String, dynamic> json) =>
      _$MyCategoryFromJson(json);

  Map<String, dynamic> toJson() => _$MyCategoryToJson(this);
}
