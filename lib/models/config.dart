import 'package:json_annotation/json_annotation.dart';

part 'config.g.dart';

@JsonSerializable()
class Config {
  @JsonKey(name: 'min_booking_amount')
  int minBookingAmount;

  @JsonKey(name: 'delivery_time')
  List<String> deliveryTime;

  Config(this.minBookingAmount, this.deliveryTime);

  factory Config.fromJson(Map<String, dynamic> json) => _$ConfigFromJson(json);

  Map<String, dynamic> toJson() => _$ConfigToJson(this);
}
