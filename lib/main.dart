import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  runApp(MyApp());
}

class ListController extends GetxController {
  RxList<String> allNames = <String>[].obs;
  RxList<List<String>> dividedLists = <List<String>>[].obs;

  String get totalNamesText => 'Total: ${allNames.length}';
  String get addedNamesText => 'Nomes Adicionados: ${allNames.join(', ')}';

  void divideList() {
    dividedLists.clear();

    const chunkSize = 5;
    for (var i = 0; i < allNames.length; i += chunkSize) {
      final chunk = allNames.sublist(
          i, i + chunkSize > allNames.length ? allNames.length : i + chunkSize);
      dividedLists.add(chunk);
    }
  }
}

class MyApp extends StatelessWidget {
  final ListController listController = Get.put(ListController());
  final TextEditingController nameController = TextEditingController();

  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Icon(Icons.sports_soccer),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView(
            children: [
              TextField(
                controller: nameController,
                decoration:
                    const InputDecoration(labelText: 'Adicione um nome'),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  final name = nameController.text.trim();
                  if (name.isNotEmpty) {
                    listController.allNames.add(name);
                    nameController.clear();
                  }
                },
                child: const Text('Adicionar Nome'),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  listController.divideList();
                },
                child: const Text('Dividir Lista'),
              ),
              const SizedBox(height: 20),
              Obx(() {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(listController.totalNamesText),
                    const SizedBox(height: 8),
                    Text(listController.addedNamesText),
                    const SizedBox(height: 20),
                    if (listController.dividedLists.isNotEmpty)
                      for (var i = 0;
                          i < listController.dividedLists.length;
                          i++)
                        Card(
                          margin: const EdgeInsets.symmetric(vertical: 8),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Text('Lista ${i + 1}:'),
                                const SizedBox(height: 8),
                                Text(listController.dividedLists[i].join(', ')),
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
      ),
    );
  }
}
