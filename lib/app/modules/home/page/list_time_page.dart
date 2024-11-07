import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../count_down_timer_page.dart';
import '../home_controller.dart';
import 'button_impa_par.dart';

class ListTimePage extends GetView<HomeController> {
  const ListTimePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            InkWell(
              onTap: () => controller.countTime01(),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  border: Border.all(color: Colors.black, width: 2.0),
                ),
                child: const Icon(Icons.add),
              ),
            ),
            Row(
              children: [
                const Text('Time 01'),
                const SizedBox(width: 10),
                Obx(
                  () => Text(
                    '${controller.time1.value}',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.teal,
                      fontSize: 35,
                    ),
                  ),
                ),
              ],
            ),
            const Text('VS'),
            Row(
              children: [
                Obx(
                  () => Text(
                    '${controller.time2.value}',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.teal,
                      fontSize: 35,
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                const Text('Time 02'),
              ],
            ),
            InkWell(
              onTap: () => controller.countTime02(),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  border: Border.all(color: Colors.black, width: 2.0),
                ),
                child: const Icon(Icons.add),
              ),
            ),
          ],
        ),
        actions: const [
          ButtonImpaPar(),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),
              const CountDownTimerPage(),
              ElevatedButton(
                onPressed: () {
                  if (controller.areAllListsFull()) {
                    final name = controller.nameController.text.trim();
                    if (name.isNotEmpty) {
                      controller.createNewListWithName(name);
                      controller.nameController.clear();
                    } else {
                      controller.createNewList();
                    }
                  }
                },
                child: const Text('Novo Time'),
              ),
              Obx(
                () {
                  return SizedBox(
                    height: Get.height,
                    child: Column(
                      children: [
                        for (var i = 0; i < controller.dividedLists.length; i++)
                          Card(
                            key: UniqueKey(),
                            color: controller
                                .cardColors[i % controller.cardColors.length],
                            margin: const EdgeInsets.symmetric(vertical: 8),
                            child: Column(
                              children: [
                                ListTile(
                                  title: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
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
                                                children: controller
                                                    .dividedLists[i]
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
                                                          onPressed: () =>
                                                              controller
                                                                  .removeItemFromList(
                                                            i,
                                                            entry,
                                                          ),
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
                                            borderRadius:
                                                BorderRadius.circular(30),
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
                                                controller:
                                                    controller.nameController,
                                                decoration:
                                                    const InputDecoration(
                                                  labelText: 'Digite o nome',
                                                ),
                                              ),
                                              actions: [
                                                TextButton(
                                                  onPressed: () => Get.back(),
                                                  child: const Text('Cancelar'),
                                                ),
                                                ElevatedButton(
                                                  onPressed: () => controller
                                                      .addNameFromList(i),
                                                  child:
                                                      const Text('Adicionar'),
                                                ),
                                              ],
                                            ),
                                          ),
                                          child: Container(
                                            height: 30,
                                            width: 30,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(30),
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
                                    style:
                                        Theme.of(context).textTheme.bodyLarge,
                                  ),
                                  trailing: InkWell(
                                    onTap: () {
                                      controller.time1.value = 0;
                                      controller.time2.value = 0;
                                      controller.moveListToEnd(i);
                                    },
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
