import 'package:flutter/material.dart';
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
                size: 35.0,
                color: Styles.primaryColor,
              ),
              onPressed: () {
                  Scaffold.of(context).openDrawer();
              }),
        ),
        title: Text('Kissan Garden'),
        elevation: 0.0,
        backgroundColor: Colors.white,
      ),
      body: Center(
        child: Text('Kissan Garden'),
      ),
      drawer: Drawer(),
    );
  }
}
