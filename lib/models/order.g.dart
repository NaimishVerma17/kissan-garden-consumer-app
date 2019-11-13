// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Order _$OrderFromJson(Map<String, dynamic> json) {
  return Order(
    json['id'] as int,
    json['order_id'] as String,
    json['total_amount'] as int,
    json['items'],
    json['status'] as String,
    json['delivery_time'] as String,
    json['address'] as String,
  );
}

Map<String, dynamic> _$OrderToJson(Order instance) => <String, dynamic>{
      'id': instance.id,
      'order_id': instance.orderId,
      'total_amount': instance.totalAmount,
      'items': instance.items,
      'status': instance.status,
      'delivery_time': instance.deliveryTime,
      'address': instance.address,
    };
