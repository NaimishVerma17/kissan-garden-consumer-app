import 'package:flutter/material.dart';
import 'package:kissan_garden/models/category_item.dart';
import 'package:kissan_garden/utils/styles.dart';

class ItemCard extends StatelessWidget {
  CategoryItem item;

  ItemCard(this.item);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 180.0,
      child: Stack(
        children: <Widget>[
          Positioned(
            top: 20.0,
            left: 20.0,
            right: 0.0,
            child: Container(
              height: 140.0,
              child: Card(
                  elevation: 5.0,
                  child: Container(
                    padding: const EdgeInsets.only(top: 10.0, right: 20.0),
                    margin: const EdgeInsets.only(left: 130.0),
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
                  )),
            ),
          ),
          Align(
            alignment: Alignment.topLeft,
            child: Container(
              height: 130.0,
              width: 130.0,
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/images/vegi.jpeg'),
                    fit: BoxFit.cover),
                borderRadius: BorderRadius.all(
                  Radius.circular(8.0),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
