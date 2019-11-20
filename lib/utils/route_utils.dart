import 'package:flutter/widgets.dart';
import 'package:kissan_garden/pages.dart';

abstract class RouteUtils {
  static const splash = '/';
  static const home = '/home';
  static const login = '/login';
  static const verifyOTP = '/verify-otp';
  static const items = '/items';
  static const cart = '/cart';
  static const savedAddresses = '/saved-addresses';
  static const addAddress = '/add-address';
  static const order = '/order';
  static const myOrders = '/my-orders';
  static const singleOrder = '/single-order';
  static const myAccount = '/my-account';

  static final Map<String, WidgetBuilder> routes = {
    splash: (context) => SplashPage(),
    home: (context) => HomePage(),
    login: (context) => LoginPage(),
    verifyOTP: (context) => VerifyOtpPage(),
    items: (context) => ItemsPage(),
    cart: (context) => CartPage(),
    savedAddresses: (context) => SavedAddressesPage(),
    addAddress: (context) => AddAddressPage(),
    order: (context) => OrderPage(),
    myOrders: (context) => MyOrdersPage(),
    singleOrder: (context) => SingleOrderPage(),
    myAccount: (context) => MyAccountPage(),
  };
}
