import 'package:kissan_garden/models/category.dart';
import 'package:kissan_garden/models/category_item.dart';
import 'package:kissan_garden/services/api_service.dart';

class ProductService extends ApiService {
  ProductService._();

  static final ProductService _instance = ProductService._();

  factory ProductService.getInstance() => _instance;

  Future<List<Category>> fetchCategories() async {
    try {
      final response = await this.get('/api/categories', useAuthHeaders: false);
      return _getCategories(response['data']);
    } catch (error) {
      throw (error);
    }
  }

  Future<List<CategoryItem>> fetchItems({String id}) async {
    try {
      final response = await this.get('/api/items',
          params: {'category_id': id.toString()}, useAuthHeaders: false);
      return _getItems(response['data']);
    } catch (error) {
      throw (error);
    }
  }

  List<Category> _getCategories(List<dynamic> c) {
    return c.map((value) {
      return Category.fromJson(value);
    }).toList();
  }

  List<CategoryItem> _getItems(List<dynamic> i) {
    return i.map((value) {
      return CategoryItem.fromJson(value);
    }).toList();
  }
}
