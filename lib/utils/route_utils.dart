import 'package:flutter/widgets.dart';
import 'package:kissan_garden/pages.dart';

abstract class RouteUtils {
  static const home = '/';
  static const login = '/login';
  static const verifyOTP = '/verify-otp';

  static final Map<String, WidgetBuilder> routes = {
    home: (context) => HomePage(),
    login: (context) => LoginPage(),
    verifyOTP: (context) => VerifyOtpPage(),
  };
}
