import 'package:flutter/material.dart';
import 'package:kissan_garden/utils/styles.dart';

class KisaanDrawer extends StatelessWidget {
  bool _isLoggedIn;

  KisaanDrawer(this._isLoggedIn);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      elevation: 10.0,
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/drawer-bg.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: ListView(
          children: <Widget>[
            DrawerHeader(
              child: Image.asset("assets/images/shopping-basket.png"),
            ),
            ListTile(
              leading: Icon(
                Icons.home,
                size: 28.0,
                color: Colors.white,
              ),
              title: Text(
                'Home',
                style: Styles.drawerItemsText(),
              ),
            ),
            _isLoggedIn
                ? ListTile(
                    leading: Icon(
                      Icons.location_on,
                      size: 28.0,
                      color: Colors.white,
                    ),
                    title: Text(
                      'Saved addresses',
                      style: Styles.drawerItemsText(),
                    ),
                  )
                : Container(),
            _isLoggedIn
                ? ListTile(
                    leading: Icon(
                      Icons.local_grocery_store,
                      size: 28.0,
                      color: Colors.white,
                    ),
                    title: Text(
                      'My orders',
                      style: Styles.drawerItemsText(),
                    ),
                  )
                : Container(),
            _isLoggedIn
                ? ListTile(
                    leading: Icon(
                      Icons.account_circle,
                      size: 28.0,
                      color: Colors.white,
                    ),
                    title: Text(
                      'My account',
                      style: Styles.drawerItemsText(),
                    ),
                  )
                : Container(),
            ListTile(
              leading: Icon(
                Icons.info_outline,
                size: 28.0,
                color: Colors.white,
              ),
              title: Text(
                'About us',
                style: Styles.drawerItemsText(),
              ),
            ),
            ListTile(
              leading: Icon(
                Icons.local_phone,
                size: 28.0,
                color: Colors.white,
              ),
              title: Text(
                'Contact us',
                style: Styles.drawerItemsText(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
