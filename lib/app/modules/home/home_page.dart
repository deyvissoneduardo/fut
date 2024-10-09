import 'package:get/get.dart';
import 'package:flutter/material.dart';
import './home_controller.dart';
import 'page/amount_persons_page.dart';
import 'page/button_add_nome.dart';
import 'page/button_delete.dart';
import 'page/button_impa_par.dart';
import 'page/list_time_page.dart';

class HomePage extends GetView<HomeController> {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Icon(Icons.sports_soccer),
        centerTitle: true,
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
      floatingActionButton: ButtonAddNome(
        onPressed: () {
          final name = controller.nameController.text.trim();
          if (name.isNotEmpty) {
            controller.allNames.add(name);
            controller.nameController.clear();
          }
        },
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            TextField(
              controller: controller.nameController,
              decoration: const InputDecoration(labelText: 'Adicione um nome'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                for (var i = 0; i <= 3; i++) {
                  controller.divideList();
                }
              },
              child: const Text('Sortear'),
            ),
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
            const SizedBox(height: 20),
            const Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                AmountPersonsPage(),
                ListTimePage(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
