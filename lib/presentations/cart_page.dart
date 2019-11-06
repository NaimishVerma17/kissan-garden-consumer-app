import 'package:flutter/material.dart';
import 'package:kissan_garden/models/cart_item.dart';
import 'package:kissan_garden/models/category_item.dart';
import 'package:kissan_garden/presentations/shared/item_card.dart';
import 'package:kissan_garden/services/user_service.dart';
import 'package:kissan_garden/utils/styles.dart';

class CartPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _CartPage();
  }
}

class _CartPage extends State<CartPage> {
  UserService _userService = UserService.getInstance();
  List<CartItem> _items;

  @override
  void initState() {
    _items = _userService.cartItems;
    print('Cart Items' + _items.toString());
    _fetchCart();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Styles.primaryColor),
      ),
      body: ListView.builder(
            itemCount: _items.length,
            itemBuilder: (context, index) {
              return ItemCard(
                CategoryItem.fromJson(_items[index].item['data'].toJson()),
              );
            }),
    );
  }

  _fetchCart() {}
}
