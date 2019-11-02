import 'package:flutter/material.dart';
import 'package:kissan_garden/models/category.dart';
import 'package:kissan_garden/utils/styles.dart';

class CategoryCard extends StatelessWidget {
  Category category;
  Function onClick;

  CategoryCard(this.category, this.onClick);

  @override
  Widget build(BuildContext context) {
    final _width = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: () => onClick(category.id),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0),
          child: Column(
            children: <Widget>[
              Container(
                width: _width - 65.0,
                height: 200.0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(3.0),
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(category.imageUrl),
                  ),
                ),
              ),
              SizedBox(
                height: 5.0,
              ),
              Text(
                category.title,
                style: Styles.pageTitleText(),
              )
            ],
          ),
        ),
      ),
    );
  }
}
