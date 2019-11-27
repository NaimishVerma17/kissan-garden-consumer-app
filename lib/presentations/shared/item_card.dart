import 'package:flutter/material.dart';
import 'package:kissan_garden/models/category_item.dart';
import 'package:kissan_garden/services/auth_service.dart';
import 'package:kissan_garden/services/user_service.dart';
import 'package:kissan_garden/utils/styles.dart';

class ItemCard extends StatefulWidget {
  CategoryItem item;

  ItemCard(this.item);

  @override
  State<StatefulWidget> createState() {
    return _ItemCard(this.item);
  }
}

class _ItemCard extends State<ItemCard> {
  CategoryItem item;
  int itemCount = 0;
  bool _isLoggedIn = false;
  UserService _userService = UserService.getInstance();
  AuthService _authService = AuthService.getInstance();

  _ItemCard(this.item);

  @override
  void initState() {
    _checkIsLoggedIn();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Container(
              height: 100.0,
              width: 100.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(3.0),
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(item.imageUrl),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 26.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    item.title,
                    style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.w600,
                        color: Styles.primaryColor),
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                  Text(
                    item.minQuantity,
                    style: TextStyle(
                        color: Styles.subHeadingColor,
                        fontSize: 14.0,
                        fontWeight: FontWeight.w500),
                  ),
                  SizedBox(
                    height: 15.0,
                  ),
                  Text(
                    'Rs. ${item.price}',
                    style: TextStyle(
                        color: Styles.subHeadingColor,
                        fontSize: 14.0,
                        fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ),
            Container(
              child: itemCount == 0
                  ? Container(
                      width: 58.0,
                      child: FlatButton(
                        color: Styles.primaryColor,
                        onPressed: _onAddPressed,
                        child: Text(
                          'Add',
                          style: TextStyle(color: Colors.white, fontSize: 12.0),
                        ),
                      ),
                    )
                  : Container(
                      child: Row(
                        children: <Widget>[
                          GestureDetector(
                            onTap: _onRemovePressed,
                            child: Container(
                              padding: EdgeInsets.all(6.0),
                              width: 26.0,
                              height: 26.0,
                              color: Styles.primaryColor,
                              child: Image.asset('assets/images/minus.png'),
                            ),
                          ),
                          SizedBox(
                            width: 8.0,
                          ),
                          Text(
                            itemCount.toString(),
                            style: TextStyle(fontSize: 15.0),
                          ),
                          SizedBox(
                            width: 8.0,
                          ),
                          GestureDetector(
                            onTap: _onAddPressed,
                            child: Container(
                              padding: EdgeInsets.all(6.0),
                              width: 26.0,
                              height: 26.0,
                              color: Styles.primaryColor,
                              child: Image.asset('assets/images/add_icon.png'),
                            ),
                          ),
                        ],
                      ),
                    ),
            )
          ],
        ),
      ),
    );
  }

  _onAddPressed() async {
    if (!_isLoggedIn) {
      Styles.showToast('Please login to add items to cart');
      return;
    }
    await _userService.addItem(item);

    setState(() {
      itemCount++;
    });
  }

  _onRemovePressed() async {
    await _userService.removeItem(item);

    setState(() {
      itemCount--;
    });
  }

  _checkIsLoggedIn() async {
    final res = await _authService.isLoggedIn();
    setState(() {
      _isLoggedIn = res;
      if (_isLoggedIn) {
        itemCount = _userService.getQuantity(item.id);
      }
    });
  }
}
