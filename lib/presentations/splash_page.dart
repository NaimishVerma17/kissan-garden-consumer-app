import 'package:flutter/material.dart';
import 'package:kissan_garden/models/mixins/unsubscribe.dart';
import 'package:kissan_garden/services/auth_service.dart';
import 'package:kissan_garden/services/broadcaster_service.dart';
import 'package:kissan_garden/services/user_service.dart';
import 'package:kissan_garden/utils/route_utils.dart';
import 'package:kissan_garden/utils/styles.dart';

class SplashPage extends StatelessWidget with UnsubscribeMixin {
  AuthService _authService = AuthService.getInstance();

  BroadcasterService _broadcasterService = BroadcasterService.getInstance();

  UserService _userService = UserService.getInstance();

  bool _isLoggedIn;

  @override
  Widget build(BuildContext context) {
    _broadcasterService
        .on(BroadcasterEventType.bootstrapped)
        .takeUntil(distroy$)
        .listen((data) {
      Navigator.pushReplacementNamed(context, RouteUtils.home,
          arguments: _isLoggedIn);
      this._disposeBroadcaster();
    });

    _broadcasterService
        .on(BroadcasterEventType.logout)
        .takeUntil(distroy$)
        .listen((data) {
      _loadHomeScreen(context);
    });
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
    _isLoggedIn = await _authService.isLoggedIn();
    if (_isLoggedIn) {
      _userService.bootstrapApp();
    } else {
      _broadcasterService.emit(eventType: BroadcasterEventType.bootstrapped);
    }
  }

  _disposeBroadcaster() {
    super.onDispose();
  }
}
