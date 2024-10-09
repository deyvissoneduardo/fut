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
                  child: Column(
                    children: [
                      ListTile(
                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Time ${i + 1}:',
                              style: const TextStyle(
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                showAdaptiveDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                    title: const Text(
                                      'Remover Nome',
                                    ),
                                    content: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: controller.dividedLists[i]
                                          .asMap()
                                          .entries
                                          .map(
                                            (entry) => ListTile(
                                              title: Text(
                                                entry.value,
                                              ),
                                              trailing: IconButton(
                                                icon: const Icon(
                                                  Icons.delete,
                                                ),
                                                onPressed: () {
                                                  controller.dividedLists[i]
                                                      .removeAt(
                                                    entry.key,
                                                  );

                                                  if (controller.dividedLists[i]
                                                      .isEmpty) {
                                                    controller.dividedLists
                                                        .removeAt(
                                                      i,
                                                    );
                                                  } else if (controller
                                                              .dividedLists[i]
                                                              .length <
                                                          5 &&
                                                      controller.dividedLists
                                                              .length >
                                                          2 &&
                                                      controller.dividedLists[2]
                                                          .isNotEmpty) {
                                                    final firstItemFromThirdList =
                                                        controller
                                                            .dividedLists[2]
                                                            .removeAt(
                                                      0,
                                                    );
                                                    controller.dividedLists[i]
                                                        .add(
                                                      firstItemFromThirdList,
                                                    );
                                                  }

                                                  controller.dividedLists
                                                      .refresh();
                                                  controller.saveLists();
                                                  Get.back();
                                                },
                                              ),
                                            ),
                                          )
                                          .toList(),
                                    ),
                                    actions: [
                                      TextButton(
                                        onPressed: () => Get.back(),
                                        child: const Text(
                                          'Cancelar',
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                              child: Container(
                                height: 30,
                                width: 30,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30),
                                  border: Border.all(
                                    color: Colors.black,
                                  ),
                                ),
                                child: const Icon(Icons.remove),
                              ),
                            ),
                            if (controller.dividedLists[i].length < 5)
                              InkWell(
                                onTap: () => showAdaptiveDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                    title: const Text(
                                      'Adicionar Nome',
                                    ),
                                    content: TextField(
                                      controller: controller.nameController,
                                      decoration: const InputDecoration(
                                        labelText: 'Digite o nome',
                                      ),
                                    ),
                                    actions: [
                                      TextButton(
                                        onPressed: () => Get.back(),
                                        child: const Text('Cancelar'),
                                      ),
                                      ElevatedButton(
                                        onPressed: () {
                                          final name = controller
                                              .nameController.text
                                              .trim();
                                          if (name.isNotEmpty) {
                                            controller.dividedLists[i]
                                                .add(name);
                                            controller.nameController.clear();
                                            controller.dividedLists.refresh();
                                            controller.saveLists();
                                            Get.back();
                                          }
                                        },
                                        child: const Text('Adicionar'),
                                      ),
                                    ],
                                  ),
                                ),
                                child: Container(
                                  height: 30,
                                  width: 30,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(30),
                                    border: Border.all(
                                      color: Colors.black,
                                    ),
                                  ),
                                  child: const Icon(Icons.add),
                                ),
                              ),
                          ],
                        ),
                        subtitle: Text(
                          controller.dividedLists[i].join(', '),
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                        trailing: InkWell(
                          onTap: () => controller.moveListToEnd(i),
                          child: Container(
                            height: 30,
                            width: 30,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              border: Border.all(color: Colors.black),
                            ),
                            child: const Align(
                              alignment: Alignment.center,
                              child: Icon(
                                Icons.arrow_downward,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}
