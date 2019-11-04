import 'package:flutter/material.dart';
import 'package:kissan_garden/models/category_item.dart';
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
  bool _isAdded = false;
  int _itemCount = 0;

  _ItemCard(this.item);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          children: <Widget>[
            Expanded(
              flex: 1,
              child: Container(
                height: 120.0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(3.0),
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(item.imageUrl),
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Container(
                margin: EdgeInsets.only(left: 30.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      item.title,
                      style: Styles.pageTitleText(),
                    ),
                    SizedBox(
                      height: 5.0,
                    ),
                    Text(
                      item.minQuantity,
                      style: TextStyle(
                          color: Styles.subHeadingColor,
                          fontSize: 16.0,
                          fontWeight: FontWeight.w600),
                    ),
                    SizedBox(
                      height: 15.0,
                    ),
                    Text(
                      'Rs. ${item.price}',
                      style: TextStyle(
                          color: Styles.subHeadingColor,
                          fontSize: 16.0,
                          fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Center(
                child: !_isAdded
                    ? Container(
                        width: 70.0,
                        child: FlatButton(
                          color: Styles.primaryColor,
                          onPressed: () {
                            setState(() {
                              _isAdded = true;
                            });
                          },
                          child: Text(
                            'Add',
                            style:
                                TextStyle(color: Colors.white, fontSize: 15.0),
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
                                size: 30.0,
                              ),
                            ),
                            SizedBox(
                              width: 2.5,
                            ),
                            Text(
                              _itemCount.toString(),
                              style: TextStyle(fontSize: 17.0),
                            ),
                            SizedBox(
                              width: 2.5,
                            ),
                            IconButton(
                              onPressed: _onAddPressed,
                              icon: Icon(
                                Icons.add_circle_outline,
                                color: Styles.primaryColor,
                                size: 30.0,
                              ),
                            ),
                          ],
                        ),
                      ),
              ),
            )
          ],
        ),
      ),
    );
  }

  _onAddPressed() {
    print('Add');
    setState(() {
      _itemCount++;
    });
  }

  _onRemovePressed() {
    print('Remove');
    setState(() {
      _itemCount--;
    });
  }
}
