import 'package:flutter/material.dart';
import 'package:kissan_garden/services/auth_service.dart';
import 'package:kissan_garden/utils/route_utils.dart';
import 'package:kissan_garden/utils/styles.dart';

class SplashPage extends StatelessWidget {
  AuthService _authService = AuthService.getInstance();

  @override
  Widget build(BuildContext context) {
    _loadHomeScreen(context);
    return Scaffold(
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Kisaan Garden',
                style: Styles.pageTitleText(),
              ),
              SizedBox(
                height: 15.0,
              ),
              CircularProgressIndicator(),
            ],
          ),
        ),
      ),
    );
  }

  void _loadHomeScreen(BuildContext context) async {
    bool _isLoggedIn = await _authService.isLoggedIn();
    Navigator.pushReplacementNamed(context, RouteUtils.home,
        arguments: _isLoggedIn);
  }
}
