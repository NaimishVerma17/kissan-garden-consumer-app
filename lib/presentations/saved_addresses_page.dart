import 'package:flutter/material.dart';
import 'package:kissan_garden/presentations/add_address_page.dart';
import 'package:kissan_garden/utils/route_utils.dart';
import 'package:kissan_garden/utils/styles.dart';

class SavedAddressesPage extends StatefulWidget {
  @override
  _SavedAddressesPage createState() => _SavedAddressesPage();
}

class _SavedAddressesPage extends State<SavedAddressesPage> {
  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Delivery Addresses',
          style: Styles.pageTitleText(),
        ),
        elevation: 0.0,
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Styles.primaryColor),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 5.0),
        child: Column(
          children: <Widget>[
            Container(
              width: _width,
              height: 54.0,
              child: FlatButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => AddAddressPage(),
                  );
                },
                color: Styles.textBackgroundColor,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(
                      Icons.add_circle_outline,
                      color: Styles.linkColor,
                    ),
                    SizedBox(
                      width: 5.0,
                    ),
                    Text(
                      'ADD NEW ADDRESS',
                      style: TextStyle(color: Styles.linkColor, fontSize: 16.0),
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
}
