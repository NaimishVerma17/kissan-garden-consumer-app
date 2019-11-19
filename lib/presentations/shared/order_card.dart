import 'package:flutter/material.dart';
import 'package:kissan_garden/models/order.dart';
import 'package:kissan_garden/utils/styles.dart';

class OrderCard extends StatelessWidget {
  Order order;
  Function onClick;

  OrderCard(this.order, this.onClick);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        this.onClick(order);
      },
      child: Card(
        elevation: 5.0,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                decoration: BoxDecoration(color: Styles.accentColor),
                height: 40.0,
                child: Center(
                  child: Text(
                    'ORDER ID: #KG1573579337',
                    style: Styles.drawerItemsText(),
                  ),
                ),
              ),
              SizedBox(
                height: 8.0,
              ),
              Wrap(
                children: <Widget>[
                  Text('Status:', style: Styles.labelText()),
                  SizedBox(
                    width: 8.0,
                  ),
                  Text(
                    'PENDING',
                    style: TextStyle(fontSize: 16.0),
                  ),
                ],
              ),
              SizedBox(
                height: 8.0,
              ),
              Wrap(
                children: <Widget>[
                  Text('Total items:', style: Styles.labelText()),
                  SizedBox(
                    width: 8.0,
                  ),
                  Text(
                    '8',
                    style: TextStyle(fontSize: 16.0),
                  ),
                ],
              ),
              SizedBox(
                height: 8.0,
              ),
              Wrap(
                children: <Widget>[
                  Text('Delivery address:', style: Styles.labelText()),
                  SizedBox(
                    width: 8.0,
                  ),
                  Text(
                    'Kumar cement works, lucknow public school',
                    style: TextStyle(fontSize: 16.0),
                  ),
                ],
              ),
              SizedBox(
                height: 8.0,
              ),
              Wrap(
                children: <Widget>[
                  Text('Delivery time:', style: Styles.labelText()),
                  SizedBox(
                    width: 8.0,
                  ),
                  Text(
                    '10am - 12pm',
                    style: TextStyle(fontSize: 16.0),
                  ),
                ],
              ),
              SizedBox(
                height: 8.0,
              ),
              Wrap(
                children: <Widget>[
                  Text('Total amount:', style: Styles.labelText()),
                  SizedBox(
                    width: 8.0,
                  ),
                  Text(
                    '280',
                    style: TextStyle(fontSize: 16.0),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
