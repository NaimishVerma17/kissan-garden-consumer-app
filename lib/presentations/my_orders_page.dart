import 'package:flutter/material.dart';
import 'package:kissan_garden/models/order.dart';
import 'package:kissan_garden/presentations/shared/order_card.dart';
import 'package:kissan_garden/services/user_service.dart';
import 'package:kissan_garden/utils/route_utils.dart';
import 'package:kissan_garden/utils/styles.dart';

class MyOrdersPage extends StatefulWidget {
  @override
  _MyOrdersPage createState() => _MyOrdersPage();
}

class _MyOrdersPage extends State<MyOrdersPage> {
  UserService _userService = new UserService.getInstance();
  bool _isLoading = true;
  List<Order> _orders;

  @override
  void initState() {
    _fetchOrders();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'My Orders',
          style: Styles.pageTitleText(),
        ),
        elevation: 3.0,
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Styles.primaryColor),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: _isLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Container(
                child: _orders.length == 0
                    ? Center(
                        child: Text(
                          'It seems like you haven\'t made any orders yet.',
                          style: Styles.labelText(),
                        ),
                      )
                    : ListView.builder(
                        itemCount: _orders.length,
                        itemBuilder: (context, index) =>
                            OrderCard(_orders[index], _orderClicked),
                      ),
              ),
      ),
    );
  }

  _fetchOrders() async {
    try {
      final response = await _userService.fetchOrders();
      setState(() {
        _orders = response;
        _isLoading = false;
      });
    } catch (error) {
      Styles.showToast(error);
      _isLoading = false;
    }
  }

  _orderClicked(Order order) {
    if (order == null) {
      return;
    }
    Navigator.pushNamed(context, RouteUtils.singleOrder,
        arguments: {'order': order, 'is_new': false});
  }
}
