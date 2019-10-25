import 'package:flutter/material.dart';
import 'package:kissan_garden/utils/route_utils.dart';

class KisaanGardenApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Kisaan Garden',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: RouteUtils.home,
      routes: RouteUtils.routes,
    );
  }
}
