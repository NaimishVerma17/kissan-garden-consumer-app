import 'package:json_annotation/json_annotation.dart';
import 'package:kissan_garden/models/category_item.dart';

part 'cart_item.g.dart';

@JsonSerializable()
class CartItem {
  @JsonKey(name: 'id', nullable: false)
  int id;

  @JsonKey(name: 'qty', nullable: false)
  String quantity;

  @JsonKey(name: 'item', nullable: false)
  Map<String, CategoryItem> item;

  CartItem(this.id, this.quantity, this.item);

  factory CartItem.formJson(Map<String, dynamic> json) =>
      _$CartItemFromJson(json);

  Map<String, dynamic> toJson() => _$CartItemToJson(this);
}
