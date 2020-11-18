import 'package:admin_keja/models/status.dart';
import 'package:json_annotation/json_annotation.dart';
part 'tenant.g.dart';

@JsonSerializable()
class MyTenant {
  String id;
  String apartment_id;
  String name;
  String photo;
  String email;
  String payed;
  String unit;

  MyTenant({
    this.id,
    this.apartment_id,
    this.photo,
    this.email,
    this.name,
    this.payed,
    this.unit,
  });

  factory MyTenant.fromJson(Map<String, dynamic> json) =>
      _$MyTenantFromJson(json);

  Map<String, dynamic> toJson() => _$MyTenantToJson(this);

  static final columns = [
    "id",
    "online_id",
    "apartment_id",
    "photo",
    "email",
    "name"
    "payed",
    "unit",
  ];

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      "online_id": id,
      "apartment_id": apartment_id,
      "photo": photo,
      "email": email,
      "name": name,
      "payed": payed,
      "unit": unit,
    };

    if (id != null) {
      map["id"] = id;
    }

    return map;
  }

  static fromMap(Map map) {
    MyTenant tenant = MyTenant();
    //transaction.id = map["id"].toString();
    tenant.id = map["online_id"];
    tenant.apartment_id = map["apartment_id"];
    tenant.photo = map["photo"];
    tenant.email = map["email"];
    tenant.name = map["name"];
    tenant.payed = map["payed"];
    tenant.unit = map["unit"];
    return tenant;
  }
}

@JsonSerializable()
class MyTenantList {
  List<MyTenant> tenants;

  MyTenantList({
    this.tenants,
  });

  factory MyTenantList.fromJson(List<dynamic> json) {
    return MyTenantList(
        tenants: json
            .map((e) => MyTenant.fromJson(e as Map<String, dynamic>))
            .toList());
  }
}

@JsonSerializable()
class MyTenantResponse {
  MyTenantList data;
  Status status;

  MyTenantResponse({
    this.data,
    this.status,
  });

  factory MyTenantResponse.fromJson(Map<String, dynamic> json) =>
      _$MyTenantResponseFromJson(json);

  Map<String, dynamic> toJson() => _$MyTenantResponseToJson(this);
}
