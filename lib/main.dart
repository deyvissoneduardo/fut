import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'app/modules/home/home_bindings.dart';
import 'app/modules/home/home_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    GetMaterialApp(
      initialBinding: HomeBindings(),
      initialRoute: '/',
      home: const HomePage(),
      debugShowCheckedModeBanner: false,
    ),
  );
}
