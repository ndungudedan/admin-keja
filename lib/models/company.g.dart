// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'company.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CompanyResponse _$CompanyResponseFromJson(Map<String, dynamic> json) {
  return CompanyResponse(
    status: json['status'] == null
        ? null
        : Status.fromJson(json['status'] as Map<String, dynamic>),
    data: json['data'] == null
        ? null
        : MyCompany.fromJson(json['data'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$CompanyResponseToJson(CompanyResponse instance) =>
    <String, dynamic>{
      'data': instance.data,
      'status': instance.status,
    };

MyCompany _$MyCompanyFromJson(Map<String, dynamic> json) {
  return MyCompany(
    id: json['id'] as String,
    logo: json['logo'] as String,
    phone: json['phone'] as String,
    email: json['email'] as String,
    name: json['name'] as String,
    status: json['status'] == null
        ? null
        : Status.fromJson(json['status'] as Map<String, dynamic>),
    address: json['address'] as String,
    adminId: json['adminId'] as String,
  );
}

Map<String, dynamic> _$MyCompanyToJson(MyCompany instance) => <String, dynamic>{
      'id': instance.id,
      'adminId': instance.adminId,
      'name': instance.name,
      'logo': instance.logo,
      'phone': instance.phone,
      'address': instance.address,
      'email': instance.email,
      'status': instance.status,
    };
