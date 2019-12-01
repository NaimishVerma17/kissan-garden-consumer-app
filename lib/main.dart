import 'package:flutter/material.dart';
import 'package:kissan_garden/utils/route_utils.dart';
import 'package:kissan_garden/utils/styles.dart';

class KisaanGardenApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Kisaan Garden',
      theme: ThemeData(
        primaryColor: Styles.primaryColor,
        accentColor: Styles.subHeadingColor,
        fontFamily: 'Lato'
      ),
      initialRoute: RouteUtils.splash,
      routes: RouteUtils.routes,
    );
  }
}
