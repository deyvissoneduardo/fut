import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../home_controller.dart';

class AmountPersonsPage extends GetView<HomeController> {
  const AmountPersonsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            controller.totalNamesText,
            style: const TextStyle(color: Colors.white),
          ),
          const SizedBox(height: 8),
          Text(
            controller.addedNamesText,
            style: const TextStyle(color: Colors.white),
          ),
          const SizedBox(height: 20),
        ],
      );
    });
  }
}
