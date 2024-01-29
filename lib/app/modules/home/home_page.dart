import 'package:fut/app/modules/home/page/amount_persons_page.dart';
import 'package:fut/app/modules/home/page/list_time_page.dart';
import 'package:fut/app/modules/home/page/text_buttion_cancel.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/get_navigation.dart';
import './home_controller.dart';

class HomePage extends GetView<HomeController> {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // parte de cima
      appBar: AppBar(
        title: const Icon(Icons.sports_soccer),
        centerTitle: true,
        actions: [
          IconButton(
            // pop para limpar a lista
            onPressed: () {
              Get.dialog(
                AlertDialog.adaptive(
                  title: const Text('Deletar Lista ?'),
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
      // FAB para adc na lista fica em baixo da tela
      floatingActionButton: FloatingActionButton(
        child: const Icon(
          Icons.add,
          color: Colors.black,
        ),
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
            // input onde inseri nome
            TextField(
              controller: controller.nameController,
              decoration: const InputDecoration(labelText: 'Adicione um nome'),
            ),
            const SizedBox(height: 20),
            // btn de sortear
            ElevatedButton(
              onPressed: () {
                //controller.divideList();
                showAdaptiveDialog(
                  context: context,
                  builder: (context) => AlertDialog.adaptive(
                    title: const Text('Quantidade de Jogadores'),
                    content:
                        TextFormField(controller: controller.qtdController),
                    actions: [
                      TextButtionCancel(
                        onPressed: () => Get.back(),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          controller.divideList();
                          Navigator.of(context).pop();
                          controller.qtdController.clear();
                        },
                        child: const Text('Confirmar'),
                      ),
                    ],
                  ),
                );
              },
              child: const Text('Sortear'),
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
