import 'package:kissan_garden/models/cart_item.dart';
import 'package:kissan_garden/models/category_item.dart';
import 'package:kissan_garden/models/user.dart';
import 'package:kissan_garden/services/api_service.dart';
import 'package:kissan_garden/services/broadcaster_service.dart';

class UserService extends ApiService {
  UserService._();

  static List<CartItem> _cartItems = new List();
  User _user;
  static final UserService _instance = UserService._();

  factory UserService.getInstance() => _instance;

  BroadcasterService _broadcasterService = BroadcasterService.getInstance();

  bootstrapApp() async {
    final response = await this.get('/api/me', useAuthHeaders: true);
    _cartItems = _getCartItemsList(response['data']['cart']['data']);
    _broadcasterService.emit(eventType: BroadcasterEventType.bootstrapped);
  }

  fetchCart() async {
    try {
      final response = await this.get('/api/cart', useAuthHeaders: true);
      _cartItems = _getCartItemsList(response['data']);
    } catch (error) {}
  }

  List<CartItem> _getCartItemsList(List<dynamic> i) {
    return i.map((item) {
      return CartItem.formJson(item);
    }).toList();
  }

  Future<void> addItem(CategoryItem item) async {
    if (item == null || item.id == null) {
      return;
    }
    CartItem _matchedItem = _cartItems
        .firstWhere((i) => i.item['data'].id == item.id, orElse: () => null);
    if (_matchedItem != null) {
      int quantity = int.parse(_matchedItem.quantity);
      quantity = quantity + 1;
      try {
        final response = await _updateCart(item.id, quantity);
        _cartItems = _getCartItemsList(response['data']);
      } catch (error) {}
    } else {
      try {
        final response = await _updateCart(item.id, 1);
        _cartItems = _getCartItemsList(response['data']);
      } catch (error) {}
    }
  }

  Future<void> removeItem(CategoryItem item) async {
    if (item == null || item.id == null) {
      return;
    }
    CartItem _matchedItem = _cartItems
        .firstWhere((i) => i.item['data'].id == item.id, orElse: () => null);
    if (_matchedItem != null) {
      int quantity = int.parse(_matchedItem.quantity);
      quantity = quantity - 1;
      try {
        final response = await _updateCart(item.id, quantity);
        _cartItems = _getCartItemsList(response['data']);
      } catch (error) {}
    }
  }

  getQuantity(int id) {
    print(id.toString());
    CartItem cartItem = _cartItems.firstWhere((i) => i.item['data'].id == id,
        orElse: () => null);
    if (cartItem != null) {
      return int.parse(cartItem.quantity);
    } else {
      return 0;
    }
  }

  _updateCart(int id, int quantity) async {
    print(quantity);
    final response = await this.post('/api/cart',
        body: {'qty': quantity, 'item_id': id}, useAuthHeaders: true);
    return response;
  }

  List<CartItem> get cartItems => _cartItems;

  User get user => _user;
}
