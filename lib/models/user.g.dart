// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) {
  return User(
    json['id'] as int,
    json['full_name'] as String,
    json['phone_number'],
    json['min_booking_amount'] as int,
    json['delivery_time'],
  );
}

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'id': instance.id,
      'full_name': instance.fullName,
      'phone_number': instance.phoneNumber,
      'min_booking_amount': instance.minBookingAmount,
      'delivery_time': instance.deliveryTime,
    };
