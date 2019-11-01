// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cart_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CartItem _$CartItemFromJson(Map<String, dynamic> json) {
  return CartItem(
    json['id'] as int,
    json['qty'] as int,
    (json['item'] as Map<String, dynamic>).map(
      (k, e) => MapEntry(k, CategoryItem.fromJson(e as Map<String, dynamic>)),
    ),
  );
}

Map<String, dynamic> _$CartItemToJson(CartItem instance) => <String, dynamic>{
      'id': instance.id,
      'qty': instance.quantity,
      'item': instance.item,
    };
