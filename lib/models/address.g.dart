// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'address.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Address _$AddressFromJson(Map<String, dynamic> json) {
  return Address(
    json['full_address'] as String,
    json['city'] as String,
    json['pin_code'] as String,
  );
}

Map<String, dynamic> _$AddressToJson(Address instance) => <String, dynamic>{
      'full_address': instance.fullAddress,
      'city': instance.city,
      'pin_code': instance.pinCode,
    };
