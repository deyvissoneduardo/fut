import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../home_controller.dart';

class ButtonImpaPar extends GetView<HomeController> {
  const ButtonImpaPar({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        controller.sort.value = 0;
        controller.generateRandomNumber();
        showAdaptiveDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Obx(
              () => controller.isLoading.value
                  ? const SizedBox(
                      height: 50,
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 90),
                        child: CircularProgressIndicator(),
                      ),
                    )
                  : Text(
                      '${controller.sort} é ${controller.sort % 2 == 0 ? 'par' : 'ímpar'}',
                    ),
            ),
            actions: [
              ElevatedButton(
                onPressed: () => Get.back(),
                child: const Text('OK'),
              ),
            ],
          ),
        );
      },
      icon: const Icon(Icons.numbers),
    );
  }
}
