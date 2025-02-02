import 'package:kissan_garden/models/address.dart';
import 'package:kissan_garden/models/cart_item.dart';
import 'package:kissan_garden/models/category_item.dart';
import 'package:kissan_garden/models/config.dart';
import 'package:kissan_garden/models/order.dart';
import 'package:kissan_garden/models/user.dart';
import 'package:kissan_garden/services/api_service.dart';
import 'package:kissan_garden/services/broadcaster_service.dart';

class UserService extends ApiService {
  UserService._();

  List<CartItem> _cartItems = new List();

  List<Address> _savedAddresses = new List();

  Config _config;

  User _user;

  double _totalAmount = 0.0;

  static final UserService _instance = UserService._();

  factory UserService.getInstance() => _instance;

  BroadcasterService _broadcasterService = BroadcasterService.getInstance();

  Future<void> bootstrapApp() async {
    final response = await this.get('/api/me', useAuthHeaders: true);
    _cartItems = _getCartItemsList(response['data']['cart']['data']);
    _user = User.fromJson(response['data']);
    _updateTotalAmount();
    _savedAddresses =
        _getSavedAddressesList(response['data']['savedAddress']['data']);
    await fetchConfiguration();
    _broadcasterService.emit(eventType: BroadcasterEventType.bootstrapped);
  }

  Future<void> updateUser(String fullName) async {
    try {
      final response = await this
          .put('/api/me', body: {'full_name': fullName}, useAuthHeaders: true);
      _user = User.fromJson(response['data']);
    } catch (error) {
      throw (error);
    }
  }

  Future<void> fetchConfiguration() async {
    try {
      final response = await this.get('/api/config', useAuthHeaders: true);
      _config = Config.fromJson(response);
    } catch (error) {
      throw (error);
    }
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
        _updateTotalAmount();
      } catch (error) {
        throw (error);
      }
    } else {
      try {
        final response = await _updateCart(item.id, 1);
        _cartItems = _getCartItemsList(response['data']);
        _updateTotalAmount();
      } catch (error) {
        throw (error);
      }
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
        _updateTotalAmount();
      } catch (error) {
        throw (error);
      }
    }
  }

  Future<void> addAddress(Map<String, String> address) async {
    try {
      final response = await this
          .post('/api/saved-addresses', body: address, useAuthHeaders: true);
      Address _address = Address.fromJson(response['data']);
      _savedAddresses.add(_address);
    } catch (error) {
      throw (error);
    }
  }

  Future<void> updateAddress(Map<String, String> address, int id) async {
    try {
      final response = await this.put('/api/saved-addresses/${id}',
          body: address, useAuthHeaders: true);
      Address _address = Address.fromJson(response['data']);
      _savedAddresses.forEach((Address a) {
        if (a.id == id) {
          a.fullAddress = _address.fullAddress;
          a.city = _address.city;
          a.pinCode = _address.pinCode;
        }
      });
      _broadcasterService.emit(
          eventType: BroadcasterEventType.addressChanged,
          data: _savedAddresses);
    } catch (error) {
      throw (error);
    }
  }

  Future<List<Order>> fetchOrders() async {
    try {
      final response = await this.get('/api/orders', useAuthHeaders: true);
      return _getOrdersList(response['data']);
    } catch (error) {
      throw (error);
    }
  }

  Future<Order> fetchOrder(String id) async {
    try {
      final response = await this.get('/api/orders/$id', useAuthHeaders: true);
      return Order.fromJson(response['data']);
    } catch (error) {
      throw (error);
    }
  }

  Future<Order> createOrder(Map<String, dynamic> orderDetails) async {
    try {
      final response = await this
          .post('/api/orders', body: orderDetails, useAuthHeaders: true);
      resetCart();
      return Order.fromJson(response['data']);
    } catch (error) {
      throw (error);
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

  resetCart() {
    _cartItems = [];
  }

  // private methods

  List<CartItem> _getCartItemsList(List<dynamic> i) {
    return i.map((item) {
      return CartItem.fromJson(item);
    }).toList();
  }

  List<Address> _getSavedAddressesList(List<dynamic> i) {
    return i.map((item) {
      return Address.fromJson(item);
    }).toList();
  }

  List<Order> _getOrdersList(List<dynamic> i) {
    return i.map((item) {
      return Order.fromJson(item);
    }).toList();
  }

  _updateTotalAmount() {
    double _amt = 0.0;
    _cartItems.forEach((CartItem i) {
      _amt = _amt + (int.parse(i.quantity) * i.item['data'].price);
    });
    _totalAmount = _amt;
    _broadcasterService.emit(
        eventType: BroadcasterEventType.cartChanged, data: _totalAmount);
  }

  _updateCart(int id, int quantity) async {
    print(quantity);
    final response = await this.post('/api/cart',
        body: {'qty': quantity, 'item_id': id}, useAuthHeaders: true);
    return response;
  }

  // getters

  List<CartItem> get cartItems => _cartItems;

  List<Address> get savedAddresses => _savedAddresses;

  Config get config => _config;

  double get totalAmount => _totalAmount;

  User get user => _user;
}
