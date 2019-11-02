import 'package:flutter/material.dart';
import 'package:kissan_garden/services/cart_service.dart';

class CartPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _CartPage();
  }
}

class _CartPage extends State<CartPage> {
  CartService _cartService = CartService.getInstance();

  @override
  void initState() {
    // TODO: implement initState
    _fetchCart();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Cart'),
      ),
    );
  }

  _fetchCart() async {
    final cart = await _cartService.fetchCart();
    print(cart);
  }
}
