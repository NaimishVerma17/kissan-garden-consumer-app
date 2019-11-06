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
        padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 5.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
              margin: EdgeInsets.only(left: 30.0),
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
            _isLoggedIn
                ? Container(
                    child: itemCount == 0
                        ? Container(
                            width: 58.0,
                            child: FlatButton(
                              color: Styles.primaryColor,
                              onPressed: _onAddPressed,
                              child: Text(
                                'Add',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 12.0),
                              ),
                            ),
                          )
                        : Container(
                            child: Row(
                              children: <Widget>[
                                IconButton(
                                  onPressed: _onRemovePressed,
                                  icon: Icon(
                                    Icons.remove_circle_outline,
                                    color: Styles.primaryColor,
                                    size: 20.0,
                                  ),
                                ),
                                Text(
                                  itemCount.toString(),
                                  style: TextStyle(fontSize: 15.0),
                                ),
                                IconButton(
                                  onPressed: _onAddPressed,
                                  icon: Icon(
                                    Icons.add_circle_outline,
                                    color: Styles.primaryColor,
                                    size: 20.0,
                                  ),
                                ),
                              ],
                            ),
                          ),
                  )
                : Container(),
          ],
        ),
      ),
    );
  }

  _onAddPressed() async {
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
      if(_isLoggedIn) {
        itemCount = _userService.getQuantity(item.id);
      }
    });
  }
}
