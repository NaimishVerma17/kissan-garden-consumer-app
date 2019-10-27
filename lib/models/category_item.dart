import 'package:json_annotation/json_annotation.dart';

part 'category_item.g.dart';

@JsonSerializable()
class CategoryItem {
  @JsonKey(name: 'id', nullable: false)
  int id;

  @JsonKey(name: 'title', nullable: false)
  String title;

  @JsonKey(name: 'image_url', nullable: false)
  String imageUrl;

  @JsonKey(name: 'price', nullable: false)
  int price;

  @JsonKey(name: 'min_qty', nullable: false)
  String minQuantity;

  @JsonKey(name: 'category_id', nullable: false)
  int categoryId;

  @JsonKey(name: 'is_active', nullable: false)
  bool isActive;

  CategoryItem(this.id, this.title, this.imageUrl, this.price, this.minQuantity,
      this.categoryId, this.isActive);

  factory CategoryItem.fromJson(Map<String, dynamic> json) =>
      _$CategoryItemFromJson(json);

  Map<String, dynamic> toJson() => _$CategoryItemToJson(this);
}
