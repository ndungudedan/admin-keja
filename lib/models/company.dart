import 'package:admin_keja/models/status.dart';
import 'package:json_annotation/json_annotation.dart';
part 'company.g.dart';

@JsonSerializable()
class CompanyResponse {
  MyCompany data;
  Status status;

  CompanyResponse({
    this.status,
    this.data,
  });

  factory CompanyResponse.fromJson(Map<String, dynamic> json) =>
      _$CompanyResponseFromJson(json);

  Map<String, dynamic> toJson() => _$CompanyResponseToJson(this);
}

@JsonSerializable()
class MyCompany {
  String id;
  String adminId;
  String name;
  String logo;
  String phone;
  String address;
  String email;
  Status status;

  MyCompany({
    this.id,
    this.logo,
    this.phone,
    this.email,
    this.name,
    this.status,
    this.address,
    this.adminId,
  });

  factory MyCompany.fromJson(Map<String, dynamic> json) =>
      _$MyCompanyFromJson(json);

  Map<String, dynamic> toJson() => _$MyCompanyToJson(this);
}
