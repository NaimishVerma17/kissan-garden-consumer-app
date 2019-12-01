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
      child: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Container(
          height: 160.0,
          width: 160.0,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(0),
            image: DecorationImage(
              fit: BoxFit.cover,
              image: NetworkImage(item.imageUrl),
            ),
          ),
        ),
        SizedBox(
          width: 20.0,
        ),
        Container(
          child: Column(children: [
            Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    item.title,
                    style: TextStyle(
                        fontSize: 18.0,
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
                        fontSize: 15.0,
                        fontWeight: FontWeight.w500),
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                  Text(
                    'Rs. ${item.price}',
                    style: TextStyle(
                        color: Styles.subHeadingColor,
                        fontSize: 15.0,
                        fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            Container(
              margin: EdgeInsets.only(left: 22.0),
              child: itemCount == 0
                  ? Container(
                width: 92.0,
                child: FlatButton(
                  color: Styles.primaryColor,
                  onPressed: _onAddPressed,
                  child: Text(
                    'ADD',
                    style: TextStyle(
                        color: Colors.white, fontSize: 14.0),
                  ),
                ),
              )
                  : Container(
                child: Row(
                  children: <Widget>[
                    GestureDetector(
                      onTap: _onRemovePressed,
                      child: Container(
                        padding: EdgeInsets.all(10.0),
                        width: 32.0,
                        height: 32.0,
                        color: Styles.primaryColor,
                        child: Image.asset('assets/images/minus.png'),
                      ),
                    ),
                    SizedBox(
                      width: 8.0,
                    ),
                    Text(
                      itemCount.toString(),
                      style: TextStyle(fontSize: 18.0),
                    ),
                    SizedBox(
                      width: 8.0,
                    ),
                    GestureDetector(
                      onTap: _onAddPressed,
                      child: Container(
                        padding: EdgeInsets.all(10.0),
                        width: 32.0,
                        height: 32.0,
                        color: Styles.primaryColor,
                        child:
                        Image.asset('assets/images/add_icon.png'),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ]),
        )
      ],
    ),
      shape: RoundedRectangleBorder(
        borderRadius: const BorderRadius.all(
          Radius.circular(0),
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
