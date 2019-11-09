import 'package:flutter/material.dart';
import 'package:kissan_garden/services/auth_service.dart';
import 'package:kissan_garden/utils/styles.dart';
import 'package:kissan_garden/utils/route_utils.dart';

class KisaanDrawer extends StatelessWidget {
  bool _isLoggedIn;

  AuthService _authService = AuthService.getInstance();

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
                size: 24.0,
                color: Colors.white,
              ),
              title: Text(
                'Home',
                style: Styles.drawerItemsText(),
              ),
            ),
//            _isLoggedIn
//                ?
            ListTile(
              onTap: () => _navigateToPage(RouteUtils.savedAddresses, context),
                    leading: Icon(
                      Icons.location_on,
                      size: 24.0,
                      color: Colors.white,
                    ),
                    title: Text(
                      'Saved addresses',
                      style: Styles.drawerItemsText(),
                    ),
                  ),
//                : Container(),
            _isLoggedIn
                ? ListTile(
                    leading: Icon(
                      Icons.local_grocery_store,
                      size: 24.0,
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
                      size: 24.0,
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
                size: 24.0,
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
                size: 24.0,
                color: Colors.white,
              ),
              title: Text(
                'Contact us',
                style: Styles.drawerItemsText(),
              ),
            ),
            _isLoggedIn
                ? ListTile(
                    onTap: () => _logout(context),
                    leading: Icon(
                      Icons.exit_to_app,
                      size: 24.0,
                      color: Colors.white,
                    ),
                    title: Text(
                      'Logout',
                      style: Styles.drawerItemsText(),
                    ),
                  )
                : Container(),
          ],
        ),
      ),
    );
  }

  _logout(BuildContext context) async {
    await _authService.logout();
    Navigator.of(context).pop();
  }

  _navigateToPage(String route, BuildContext context) {
    if (route == null) {
      return;
    }
    Navigator.of(context).pop();
    Navigator.of(context).pushNamed(route);
  }
}
