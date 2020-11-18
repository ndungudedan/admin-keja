import 'package:admin_keja/models/status.dart';
import 'package:json_annotation/json_annotation.dart';
part 'user.g.dart';

@JsonSerializable()
class UserResponse {
  User data;
  Status status;

  UserResponse({
    this.status,
    this.data,
  });

  factory UserResponse.fromJson(Map<String, dynamic> json) =>
      _$UserResponseFromJson(json);

  Map<String, dynamic> toJson() => _$UserResponseToJson(this);
}

@JsonSerializable()
class User {
  String id;
  String name;
  String password;
  String phone;
  String photo;
  String email;

  User({
    this.id,
    this.password,
    this.photo,
    this.phone,
    this.email,
    this.name,
  });

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}
