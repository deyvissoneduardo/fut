import 'package:fut/app/core/form_helper.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import './home_controller.dart';

class HomePage extends GetView<HomeController> {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sorteio de Nomes'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => controller.adicionarNome(),
        elevation: 15,
        focusElevation: 15.0,
        child: const Icon(Icons.add),
      ),
      body: Container(
        padding: const EdgeInsets.all(15),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              TextFormField(
                controller: controller.nomeController,
                onTapOutside: (value) => context.unfocus(),
                textInputAction: TextInputAction.done,
                decoration: const InputDecoration(
                  labelText: 'Nome',
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: ElevatedButton(
                  onPressed: () {
                    controller.sortearNomes();
                  },
                  child: const Text('Sortear'),
                ),
              ),
              Obx(() {
                return Column(
                  children: [
                    Text('Total: ${controller.nomes.length}'),
                    controller.view.isFalse
                        ? const SizedBox()
                        : Column(
                            children: controller.nomes
                                .map((nome) => Text(nome))
                                .toList(),
                          ),
                  ],
                );
              }),
              Obx(
                () {
                  return Column(
                    children: [
                      const Text('Nomes Sorteados:'),
                      for (int i = 0;
                          i <
                              controller
                                  .dividirNomesSorteados(
                                      controller.nomesSorteados, 5)
                                  .length;
                          i++)
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            alignment: Alignment.centerLeft,
                            width: double.infinity,
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color:
                                  controller.cores[i % controller.cores.length],
                            ),
                            child: Column(
                              children: controller
                                  .dividirNomesSorteados(
                                      controller.nomesSorteados, 5)[i]
                                  .map((nome) {
                                return Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(nome),
                                );
                              }).toList(),
                            ),
                          ),
                        ),
                    ],
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
