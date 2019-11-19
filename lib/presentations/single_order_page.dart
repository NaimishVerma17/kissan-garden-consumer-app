import 'package:flutter/material.dart';
import 'package:kissan_garden/models/order.dart';
import 'package:kissan_garden/utils/styles.dart';

class SingleOrderPage extends StatelessWidget {
  Order _order;
  bool _isNew = false;

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> _args = ModalRoute.of(context).settings.arguments;
    _order = _args['order'];
    _isNew = _args['is_new'];
    print(_order.address);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Order',
          style: Styles.pageTitleText(),
        ),
        elevation: 0.0,
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Styles.primaryColor),
      ),
      body: Container(
        decoration: BoxDecoration(color: Styles.homeBackgroundColor),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: CustomScrollView(
            slivers: <Widget>[
              SliverList(
                delegate: SliverChildListDelegate(
                  [
                    _isNew
                        ? Text(
                            'Thanks you for placing your order. You will receive an sms confirmation shortly.',
                            style: TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.w700,
                                color: Colors.green),
                          )
                        : Container(),
                    SizedBox(
                      height: 10.0,
                    ),
                    Text(
                      'Order Id: ${_order.orderId}',
                      style: Styles.pageTitleText(),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Row(
                      children: <Widget>[
                        Text(
                          'Status:',
                          style: Styles.labelText(),
                        ),
                        SizedBox(
                          width: 10.0,
                        ),
                        Text(
                          _order.status.toUpperCase(),
                          style: TextStyle(
                              fontSize: 15.0,
                              color: _order.status == 'pending'
                                  ? Colors.deepOrangeAccent
                                  : Colors.green),
                        ),
                      ],
                    ),
                    Divider(
                      thickness: 0.5,
                    ),
                    _getItemsList(),
                    SizedBox(
                      height: 10.0,
                    ),
                    Wrap(
                      children: <Widget>[
                        Text(
                          'Delivery Address:',
                          style: Styles.labelText(),
                        ),
                        SizedBox(
                          width: 10.0,
                        ),
                        Text(
                          _order.address,
                          style: TextStyle(fontSize: 15.0),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Wrap(
                      children: <Widget>[
                        Text(
                          'Delivery Time:',
                          style: Styles.labelText(),
                        ),
                        SizedBox(
                          width: 10.0,
                        ),
                        Text(
                          _order.deliveryTime,
                          style: TextStyle(fontSize: 15.0),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Wrap(
                      children: <Widget>[
                        Text(
                          'Total Amount:',
                          style: Styles.labelText(),
                        ),
                        SizedBox(
                          width: 10.0,
                        ),
                        Text(
                          'Rs. ${_order.totalAmount.toString()}',
                          style: TextStyle(fontSize: 15.0),
                        ),
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _getItemsList() {
//    int _itemNos = int.parse(_order.items.length);
    return new ListView.builder(
      shrinkWrap: true,
      physics: ClampingScrollPhysics(),
      itemCount: 1,
      itemBuilder: (context, index) => Container(
        child: Row(
          children: <Widget>[
            Container(
              height: 100.0,
              width: 100.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(3.0),
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(_order.items[index]['image_url']),
                ),
              ),
            ),
            SizedBox(
              width: 10.0,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(_order.items[index]['title'], style: Styles.labelText()),
                SizedBox(
                  height: 10.0,
                ),
                Wrap(
                  children: <Widget>[
                    Text('Quantity:', style: Styles.labelText()),
                    SizedBox(
                      width: 5.0,
                    ),
                    Text(
                      _order.items[index]['qty'].toString(),
                      style: TextStyle(fontSize: 15.0),
                    )
                  ],
                ),
                SizedBox(
                  height: 8.0,
                ),
                Wrap(
                  children: <Widget>[
                    Text('Total:', style: Styles.labelText()),
                    SizedBox(
                      width: 5.0,
                    ),
                    Text(
                      _order.items[index]['total'].toString(),
                      style: TextStyle(fontSize: 15.0),
                    )
                  ],
                ),
                SizedBox(
                  height: 8.0,
                ),
                Divider(
                  thickness: 0.5,
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
