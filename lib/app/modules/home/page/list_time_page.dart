import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../home_controller.dart';

class ListTimePage extends GetView<HomeController> {
  const ListTimePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        return SizedBox(
          height: Get.height,
          child: Column(
            children: [
              for (var i = 0; i < controller.dividedLists.length; i++)
                Card(
                  key: UniqueKey(),
                  color:
                      controller.cardColors[i % controller.cardColors.length],
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          'Time ${i + 1}:',
                          style: const TextStyle(
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(controller.dividedLists[i].join(', ')),
                      ],
                    ),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}
