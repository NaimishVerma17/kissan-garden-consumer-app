import 'package:flutter/material.dart';
import 'package:kissan_garden/models/category.dart';
import 'package:kissan_garden/utils/styles.dart';

class CategoryCard extends StatelessWidget {
  Category category;
  Function onClick;

  CategoryCard(this.category, this.onClick);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onClick(category.id),
      child: Container(
        height: 260.0,
        child: Stack(
          children: <Widget>[
            Positioned(
              top: 40.0,
              left: 0.0,
              right: 0.0,
              child: Container(
                height: 215.0,
                child: Card(
                    elevation: 5.0,
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 10.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          Center(
                            child: Text(
                              category.title,
                              style: Styles.pageTitleText(),
                            ),
                          ),
                        ],
                      ),
                    )),
              ),
            ),
            Align(
              alignment: Alignment.topCenter,
              child: Container(
                height: 200.0,
                width: 320.0,
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
      ),
    );
  }
}
