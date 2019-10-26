import 'package:flutter/widgets.dart';
import 'package:kissan_garden/pages.dart';

abstract class RouteUtils {
  static const splash = '/';
  static const home = '/home';
  static const login = '/login';
  static const verifyOTP = '/verify-otp';

  static final Map<String, WidgetBuilder> routes = {
    splash: (context) => SplashPage(),
    home: (context) => HomePage(),
    login: (context) => LoginPage(),
    verifyOTP: (context) => VerifyOtpPage(),
  };
}
