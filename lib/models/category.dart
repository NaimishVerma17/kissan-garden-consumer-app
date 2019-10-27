import 'package:json_annotation/json_annotation.dart';

part 'category.g.dart';

@JsonSerializable()
class Category {
  @JsonKey(name: 'id', nullable: false)
  int id;

  @JsonKey(name: 'title', nullable: false)
  String title;

  @JsonKey(name: 'image_url', nullable: false)
  String imageUrl;

  @JsonKey(name: 'is_active', nullable: false)
  bool isActive;

  Category(this.id, this.title, this.imageUrl, this.isActive);

  factory Category.fromJson(Map<String, dynamic> json) =>
      _$CategoryFromJson(json);

  Map<String, dynamic> toJson() => _$CategoryToJson(this);
}
