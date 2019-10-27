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

  @JsonKey(name: 'min_booking_amount')
  int minBookingAmount;

  @JsonKey(name: 'delivery_time')
  // @TODO:Replace dynamic with List<String>
  dynamic deliveryTime;

  User(this.id, this.fullName, this.phoneNumber, this.minBookingAmount,
      this.deliveryTime);

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}
