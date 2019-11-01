import 'package:kissan_garden/models/cart_item.dart';
import 'package:kissan_garden/services/api_service.dart';

class CartService extends ApiService {
  CartService._();

  static final CartService _instance = CartService._();

  factory CartService.getInstance() => _instance;

  List<CartItem> _cartItems = new List();

  Future<List<CartItem>> fetchCart() async {
    try {
      final response = await this.get('/cart', useAuthHeaders: true);
      return _getCartItemsList(response['data']);
    } catch (error) {
      throw (error);
    }
  }

  List<CartItem> _getCartItemsList(List<dynamic> i) {
    return i.map((item) {
      return CartItem.formJson(item);
    }).toList();
  }
}
