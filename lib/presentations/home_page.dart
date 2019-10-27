import 'package:flutter/material.dart';
import 'package:kissan_garden/models/mixins/unsubscribe.dart';
import 'package:kissan_garden/presentations/shared/drawer.dart';
import 'package:kissan_garden/presentations/shared/search_bar.dart';
import 'package:kissan_garden/services/broadcaster_service.dart';
import 'package:kissan_garden/utils/route_utils.dart';
import 'package:kissan_garden/utils/styles.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomePage();
  }
}

class _HomePage extends State<HomePage> with UnsubscribeMixin {
  BroadcasterService _broadcasterService = BroadcasterService.getInstance();
  bool _isLoggedIn = false;

  @override
  void initState() {
    _broadcasterService
        .on(BroadcasterEventType.loginComplete)
        .takeUntil(distroy$)
        .listen((data) {
      setState(() {
        _isLoggedIn = true;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _isLoggedIn = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(
        leading: Builder(
          builder: (context) => IconButton(
              icon: Icon(
                Icons.menu,
                size: 30.0,
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
          !_isLoggedIn
              ? IconButton(
                  icon: Icon(
                    Icons.exit_to_app,
                    size: 32.0,
                    color: Styles.primaryColor,
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 20.0),
                  onPressed: () {
                    Navigator.pushNamed(context, RouteUtils.login);
                  },
                )
              : IconButton(
                  icon: Icon(
                    Icons.shopping_cart,
                    size: 32.0,
                    color: Styles.primaryColor,
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 20.0),
                  onPressed: () {
                    print('Cart pressed');
                  },
                )
        ],
      ),
      body: Container(
        decoration: BoxDecoration(color: Styles.homeBackgroundColor),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 18.0),
          child: Column(
            children: <Widget>[
              SearchBar()
            ],
          ),
        ),
      ),
      drawer: KisaanDrawer(_isLoggedIn),
    );
  }

  @override
  void dispose() {
    onDispose();
    super.dispose();
  }
}
