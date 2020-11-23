// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MyHome _$MyHomeFromJson(Map<String, dynamic> json) {
  return MyHome(
    id: json['id'] as String,
    apartment_id: json['apartment_id'] as String,
    company_id: json['company_id'] as String,
    expected: json['expected'] as String,
    banner: json['banner'] as String,
    paid: json['paid'] as String,
    timestamp: json['timestamp'] as String,
    title: json['title'] as String,
    due: json['due'] as String,
    month: json['month'] as String,
    year: json['year'] as String,
  );
}

Map<String, dynamic> _$MyHomeToJson(MyHome instance) => <String, dynamic>{
      'id': instance.id,
      'apartment_id': instance.apartment_id,
      'company_id': instance.company_id,
      'expected': instance.expected,
      'paid': instance.paid,
      'timestamp': instance.timestamp,
      'title': instance.title,
      'due': instance.due,
      'month': instance.month,
      'year': instance.year,
      'banner': instance.banner,
    };

MyHomeSummary _$MyHomeSummaryFromJson(Map<String, dynamic> json) {
  return MyHomeSummary(
    id: json['id'] as String,
    expected: json['expected'] as String,
    paid: json['paid'] as String,
    due: json['due'] as String,
    month: json['month'] as String,
    year: json['year'] as String,
  );
}

Map<String, dynamic> _$MyHomeSummaryToJson(MyHomeSummary instance) =>
    <String, dynamic>{
      'id': instance.id,
      'expected': instance.expected,
      'paid': instance.paid,
      'due': instance.due,
      'month': instance.month,
      'year': instance.year,
    };

MyHomeSummaryList _$MyHomeSummaryListFromJson(Map<String, dynamic> json) {
  return MyHomeSummaryList(
    values: (json['values'] as List)
        ?.map((e) => e == null
            ? null
            : MyHomeSummary.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$MyHomeSummaryListToJson(MyHomeSummaryList instance) =>
    <String, dynamic>{
      'values': instance.values,
    };

MyHomeList _$MyHomeListFromJson(Map<String, dynamic> json) {
  return MyHomeList(
    myhomes: (json['myhomes'] as List)
        ?.map((e) =>
            e == null ? null : MyHome.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$MyHomeListToJson(MyHomeList instance) =>
    <String, dynamic>{
      'myhomes': instance.myhomes,
    };

MyHomeResponse _$MyHomeResponseFromJson(Map<String, dynamic> json) {
  return MyHomeResponse(
    data:
        json['data'] == null ? null : MyHomeList.fromJson(json['data'] as List),
    status: json['status'] == null
        ? null
        : Status.fromJson(json['status'] as Map<String, dynamic>),
    summary: json['summary'] == null
        ? null
        : MyHomeSummaryList.fromJson(json['summary'] as List),
  );
}

Map<String, dynamic> _$MyHomeResponseToJson(MyHomeResponse instance) =>
    <String, dynamic>{
      'summary': instance.summary,
      'data': instance.data,
      'status': instance.status,
    };
