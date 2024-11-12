import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../home_controller.dart';

class ButtonImpaPar extends GetView<HomeController> {
  const ButtonImpaPar({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      color: Colors.white,
      onPressed: () {
        controller.sort.value = 0;
        controller.generateRandomNumber();
        showAdaptiveDialog(
          context: context,
          builder: (context) => AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            backgroundColor: const Color(0xFF424141),
            title: Obx(
              () => controller.isLoading.value
                  ? const SizedBox(
                      height: 50,
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 90),
                        child: CircularProgressIndicator(
                          color: Colors.white,
                        ),
                      ),
                    )
                  : Text(
                      '${controller.sort} é ${controller.sort % 2 == 0 ? 'par' : 'ímpar'}',
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                    ),
            ),
            actions: [
              ElevatedButton(
                onPressed: () => Get.back(),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text(
                  'OK',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        );
      },
      icon: const Icon(
        Icons.numbers,
        size: 30,
      ),
    );
  }
}
