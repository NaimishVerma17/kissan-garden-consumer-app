import 'package:flutter/widgets.dart';
import 'package:kissan_garden/pages.dart';

abstract class RouteUtils {
  static const home = '/';
  static const login = '/login';

  static final Map<String, WidgetBuilder> routes = {
    home: (context) => HomePage(),
    login: (context) => LoginPage()
  };
}
