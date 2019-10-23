import 'package:flutter/material.dart';
import 'package:kissan_garden/app_config.dart';
import 'package:kissan_garden/main.dart';

void main() {
  AppConfig.setUpEnv(Environment.prod);
  runApp(KisaanGardenApp());
}
