import 'package:json_annotation/json_annotation.dart';

part 'address.g.dart';

@JsonSerializable()
class Address {
  @JsonKey(name: 'id')
  int id;

  @JsonKey(name: 'full_address')
  String fullAddress;

  @JsonKey(name: 'city')
  String city;

  @JsonKey(name: 'pin_code')
  String pinCode;

  Address(this.fullAddress, this.city, this.pinCode, {this.id});

  factory Address.fromJson(Map<String, dynamic> json) =>
      _$AddressFromJson(json);

  Map<String, dynamic> toJson() => _$AddressToJson(this);
}
