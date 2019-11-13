import 'package:json_annotation/json_annotation.dart';

part 'order.g.dart';

@JsonSerializable()
class Order {
  @JsonKey(name: 'id')
  int id;

  @JsonKey(name: 'order_id')
  String orderId;

  @JsonKey(name: 'total_amount')
  int totalAmount;

  @JsonKey(name: 'items')
  dynamic items;

  @JsonKey(name: 'status')
  String status;

  @JsonKey(name: 'delivery_time')
  String deliveryTime;

  @JsonKey(name: 'address')
  String address;

  Order(this.id, this.orderId, this.totalAmount, this.items, this.status,
      this.deliveryTime, this.address);

  factory Order.fromJson(Map<String, dynamic> json) => _$OrderFromJson(json);

  Map<String, dynamic> toJson() => _$OrderToJson(this);
}
