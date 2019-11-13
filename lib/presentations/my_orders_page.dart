import 'package:flutter/material.dart';
import 'package:kissan_garden/models/order.dart';
import 'package:kissan_garden/presentations/shared/order_card.dart';
import 'package:kissan_garden/services/user_service.dart';
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
          'My orders',
          style: Styles.pageTitleText(),
        ),
        elevation: 3.0,
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Styles.primaryColor),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: _isLoading
            ? CircularProgressIndicator()
            : ListView.builder(
                itemCount: 4,
                itemBuilder: (context, index) => OrderCard(),
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
}
