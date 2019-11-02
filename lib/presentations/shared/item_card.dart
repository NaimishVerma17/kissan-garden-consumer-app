import 'package:flutter/material.dart';
import 'package:kissan_garden/models/category_item.dart';
import 'package:kissan_garden/utils/styles.dart';

class ItemCard extends StatelessWidget {
  CategoryItem item;

  ItemCard(this.item);

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
            flex: 2,
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
          )
        ],
      ),
    ));
  }
}
