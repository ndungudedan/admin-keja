// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CategoryResponse _$CategoryResponseFromJson(Map<String, dynamic> json) {
  return CategoryResponse(
    status: json['status'] == null
        ? null
        : Status.fromJson(json['status'] as Map<String, dynamic>),
    data: json['data'] == null
        ? null
        : MyCategoryList.fromJson(json['data'] as List),
  );
}

Map<String, dynamic> _$CategoryResponseToJson(CategoryResponse instance) =>
    <String, dynamic>{
      'data': instance.data,
      'status': instance.status,
    };

MyCategoryList _$MyCategoryListFromJson(Map<String, dynamic> json) {
  return MyCategoryList(
    categorys: (json['categorys'] as List)
        ?.map((e) =>
            e == null ? null : MyCategory.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$MyCategoryListToJson(MyCategoryList instance) =>
    <String, dynamic>{
      'categorys': instance.categorys,
    };

MyCategory _$MyCategoryFromJson(Map<String, dynamic> json) {
  return MyCategory(
    id: json['id'] as String,
    title: json['title'] as String,
  );
}

Map<String, dynamic> _$MyCategoryToJson(MyCategory instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
    };
