import 'package:flutter/material.dart';
import 'package:kissan_garden/utils/styles.dart';

class MyAccountPage extends StatefulWidget {
  @override
  _MyAccountPage createState() => _MyAccountPage();
}

class _MyAccountPage extends State<MyAccountPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'My Account',
          style: Styles.pageTitleText(),
        ),
        elevation: 0.0,
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Styles.primaryColor),
      ),
      body: Column(
        children: <Widget>[

        ],
      ),
    );
  }
}
