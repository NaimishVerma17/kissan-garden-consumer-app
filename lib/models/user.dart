import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
class User {
  @JsonKey(name: 'id')
  int id;

  @JsonKey(name: 'full_name', disallowNullValue: false)
  String fullName;

  @JsonKey(name: 'phone_number')
  dynamic phoneNumber;


  User(this.id, this.fullName, this.phoneNumber);

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}
