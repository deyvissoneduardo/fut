import 'package:flutter/material.dart';
import 'package:fut/app/modules/home/home_bindings.dart';
import 'package:fut/app/modules/home/home_page.dart';
import 'package:get/get.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(GetMaterialApp(
    initialBinding: HomeBindings(),
    initialRoute: '/home',
    home: const HomePage(),
  ));
}
