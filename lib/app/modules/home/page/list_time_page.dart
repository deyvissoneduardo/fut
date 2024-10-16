import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../home_controller.dart';
import 'button_delete.dart';
import 'button_impa_par.dart';

class ListTimePage extends GetView<HomeController> {
  const ListTimePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: const SizedBox(),
        title: Obx(
          () => Text(
            controller.formatarTempo(controller.tempoRestante.value),
            style: const TextStyle(fontSize: 48),
          ),
        ),
        actions: [
          const ButtonImpaPar(),
          const SizedBox(width: 20),
          ButtonDelete(
            onPressed: () {
              controller.allNames.clear();
              controller.dividedLists.clear();
              Get.back();
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: Get.width * .6,
                    padding: const EdgeInsets.symmetric(horizontal: 0),
                    child: TextField(
                      controller: controller.minutosController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        labelText: 'Digite o tempo (minutos)',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      final int minutos =
                          int.tryParse(controller.minutosController.text) ??
                              6; // Padrão: 2 minutos
                      controller.definirTempoPersonalizado(minutos);
                    },
                    child: const Text('Tempo'),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
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
                  ElevatedButton(
                    onPressed: () {
                      controller.iniciarCronometro();
                    },
                    child: const Text('Iniciar Cronômetro'),
                  ),
                ],
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
