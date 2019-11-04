import 'package:kissan_garden/models/cart_item.dart';
import 'package:kissan_garden/models/user.dart';
import 'package:kissan_garden/services/api_service.dart';

class UserService extends ApiService {
  UserService._();

  List<CartItem> _cartItems;
  User _user;
  static final UserService _instance = UserService._();

  factory UserService.getInstance() => _instance;

  bootstrapApp() {}

  List<CartItem> get cartItems => _cartItems;

  User get user => _user;
}
