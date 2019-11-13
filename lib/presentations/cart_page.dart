import 'package:flutter/material.dart';
import 'package:kissan_garden/models/cart_item.dart';
import 'package:kissan_garden/models/category_item.dart';
import 'package:kissan_garden/presentations/shared/item_card.dart';
import 'package:kissan_garden/services/user_service.dart';
import 'package:kissan_garden/utils/route_utils.dart';
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cart', style: Styles.pageTitleText()),
        elevation: 0.0,
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Styles.primaryColor),
      ),
      body: _items.length == 0
          ? Center(
              child: Text(
                'Please add item in cart to order.',
                style: Styles.labelText(),
              ),
            )
          : Column(
              children: <Widget>[
                Expanded(
                  child: ListView.builder(
                      itemCount: _items.length,
                      itemBuilder: (context, index) {
                        return ItemCard(
                          CategoryItem.fromJson(
                              _items[index].item['data'].toJson()),
                        );
                      }),
                ),
                Container(
                  height: 50.0,
                  color: Styles.primaryColor,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      FlatButton(
                        onPressed: () {
                          Navigator.of(context).pushNamed(RouteUtils.order);
                        },
                        child: Text(
                          'Checkout',
                          style: TextStyle(
                              color: Styles.primaryColor, fontSize: 18.0),
                        ),
                        color: Colors.white,
                      )
                    ],
                  ),
                )
              ],
            ),
    );
  }
}
