// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'config.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Config _$ConfigFromJson(Map<String, dynamic> json) {
  return Config(
    json['min_booking_amount'] as int,
    (json['delivery_time'] as List)?.map((e) => e as String)?.toList(),
  );
}

Map<String, dynamic> _$ConfigToJson(Config instance) => <String, dynamic>{
      'min_booking_amount': instance.minBookingAmount,
      'delivery_time': instance.deliveryTime,
    };
