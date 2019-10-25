import 'package:flutter/material.dart';
import 'package:kissan_garden/presentations/shared/drawer.dart';
import 'package:kissan_garden/utils/route_utils.dart';
import 'package:kissan_garden/utils/styles.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Builder(
          builder: (context) => IconButton(
              icon: Icon(
                Icons.menu,
                size: 32.0,
                color: Styles.primaryColor,
              ),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              }),
        ),
        title: Text('Kissan Garden', style: Styles.pageTitleText()),
        elevation: 0.0,
        backgroundColor: Colors.white,
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.exit_to_app,
              size: 35.0,
              color: Styles.primaryColor,
            ),
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            onPressed: () {
              Navigator.pushNamed(context, RouteUtils.login);
            },
          )
        ],
      ),
      body: Center(
        child: Text('Kissan Garden'),
      ),
      drawer: KisaanDrawer(),
    );
  }
}
