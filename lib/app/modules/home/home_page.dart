import 'package:get/get.dart';
import 'package:flutter/material.dart';
import './home_controller.dart';
import 'page/amount_persons_page.dart';
import 'page/button_add_nome.dart';
import 'page/list_time_page.dart';

class HomePage extends GetView<HomeController> {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Icon(Icons.sports_soccer),
        centerTitle: true,
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
      body: Container(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            TextField(
              controller: controller.nameController,
              decoration: const InputDecoration(labelText: 'Adicione nome'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Get.off(const ListTimePage());
                for (var i = 0; i <= 10; i++) {
                  controller.divideList();
                }
              },
              child: const Text('Sortear'),
            ),
            const SizedBox(height: 20),
            const AmountPersonsPage(),
          ],
        ),
      ),
    );
  }
}
