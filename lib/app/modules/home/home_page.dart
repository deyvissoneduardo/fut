import 'package:get/get.dart';
import 'package:flutter/material.dart';
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
                controller.divideList();
              },
              child: const Text('Sortear'),
            ),
            const SizedBox(height: 20),

            Obx(() {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(controller.totalNamesText),
                  const SizedBox(height: 8),
                  Text(controller.addedNamesText),
                  const SizedBox(height: 20),
                  // mudar a coluna parar ReorderableListView
                  // assim sera possivel reodernar
                  if (controller.isLoading.isTrue)
                    const Center(
                      child: CircularProgressIndicator.adaptive(),
                    ),
                  if (controller.dividedLists.isNotEmpty)
                    for (var i = 0; i < controller.dividedLists.length; i++)
                      Card(
                        margin: const EdgeInsets.symmetric(vertical: 8),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Text('Lista ${i + 1}:'),
                              const SizedBox(height: 8),
                              Text(controller.dividedLists[i].join(', ')),
                            ],
                          ),
                        ),
                      ),
                ],
              );
            }),
          ],
        ),
      ),
    );
  }
}
