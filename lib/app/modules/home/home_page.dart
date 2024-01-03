import 'package:get/get.dart';
import 'package:flutter/material.dart';
import './home_controller.dart';
import 'page/amount_persons_page.dart';
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
          IconButton(
            onPressed: () {
              Get.dialog(
                AlertDialog.adaptive(
                  title: const Text('Deletar Times ?'),
                  actions: [
                    TextButton(
                      onPressed: () => Get.back(),
                      style: const ButtonStyle(
                        side: MaterialStatePropertyAll<BorderSide>(
                          BorderSide(color: Colors.redAccent),
                        ),
                      ),
                      child: const Text(
                        'Cancelar',
                        style: TextStyle(color: Colors.redAccent),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        controller.allNames.clear();
                        controller.dividedLists.clear();
                        Get.back();
                      },
                      child: const Text('Confirmar'),
                    )
                  ],
                ),
              );
            },
            icon: const Icon(
              Icons.delete_forever,
              color: Colors.red,
              size: 30,
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () {
            final name = controller.nameController.text.trim();
            if (name.isNotEmpty) {
              controller.allNames.add(name);
              controller.nameController.clear();
            }
          }),
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
                controller.divideList();
              },
              child: const Text('Sortear'),
            ),
            const SizedBox(height: 20),
            const AmountPersonsPage(),
            const ListTimePage(),
          ],
        ),
      ),
    );
  }
}
