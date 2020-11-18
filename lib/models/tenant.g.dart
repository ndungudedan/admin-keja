// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tenant.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MyTenant _$MyTenantFromJson(Map<String, dynamic> json) {
  return MyTenant(
    id: json['id'] as String,
    apartment_id: json['apartment_id'] as String,
    photo: json['photo'] as String,
    email: json['email'] as String,
    name: json['name'] as String,
    payed: json['payed'] as String,
    unit: json['unit'] as String,
  );
}

Map<String, dynamic> _$MyTenantToJson(MyTenant instance) => <String, dynamic>{
      'id': instance.id,
      'apartment_id': instance.apartment_id,
      'name': instance.name,
      'photo': instance.photo,
      'email': instance.email,
      'payed': instance.payed,
      'unit': instance.unit,
    };

MyTenantList _$MyTenantListFromJson(Map<String, dynamic> json) {
  return MyTenantList(
    tenants: (json['tenants'] as List)
        ?.map((e) =>
            e == null ? null : MyTenant.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$MyTenantListToJson(MyTenantList instance) =>
    <String, dynamic>{
      'tenants': instance.tenants,
    };

MyTenantResponse _$MyTenantResponseFromJson(Map<String, dynamic> json) {
  return MyTenantResponse(
    data: json['data'] == null
        ? null
        : MyTenantList.fromJson(json['data'] as List),
    status: json['status'] == null
        ? null
        : Status.fromJson(json['status'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$MyTenantResponseToJson(MyTenantResponse instance) =>
    <String, dynamic>{
      'data': instance.data,
      'status': instance.status,
    };
