// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CategoryItem _$CategoryItemFromJson(Map<String, dynamic> json) {
  return CategoryItem(
    json['id'] as int,
    json['title'] as String,
    json['image_url'] as String,
    json['price'] as int,
    json['min_qty'] as String,
    json['category_id'] as int,
    json['is_active'] as bool,
  );
}

Map<String, dynamic> _$CategoryItemToJson(CategoryItem instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'image_url': instance.imageUrl,
      'price': instance.price,
      'min_qty': instance.minQuantity,
      'category_id': instance.categoryId,
      'is_active': instance.isActive,
    };
