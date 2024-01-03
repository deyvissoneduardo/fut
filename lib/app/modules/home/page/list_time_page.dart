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
          child: ReorderableListView(
            onReorder: (oldIndex, newIndex) {
              if (newIndex >= controller.allNames.length) {
                newIndex = controller.allNames.length - 1;
              }
              if (oldIndex < newIndex) {
                newIndex -= 1;
              }
              controller.allNames
                  .insert(newIndex, controller.allNames.removeAt(oldIndex));
              controller.update(); // Atualize o estado após a reordenação
            },
            children: [
              for (var i = 0; i < controller.dividedLists.length; i++)
                Card(
                  key: Key('$i'),
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text('Time ${i + 1}:'),
                        const SizedBox(height: 8),
                        Text(controller.dividedLists[i].join(', ')),
                      ],
                    ),
                  ),
                )
            ],
          ),
        );
      },
    );
  }
}
