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
    const defualtBorder = OutlineInputBorder(
      borderRadius: BorderRadius.all(
        Radius.circular(10),
      ),
      borderSide: BorderSide(
        color: Colors.blue,
        width: 2.0,
      ),
    );
    return Scaffold(
      backgroundColor: const Color(0xFF424141),
      appBar: AppBar(
        backgroundColor: const Color(0xFF424141),
        title: const Icon(
          Icons.sports_soccer,
          color: Colors.white,
          size: 35,
        ),
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
            TextFormField(
              controller: controller.nameController,
              cursorColor: Colors.white,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w500,
              ),
              decoration: const InputDecoration(
                hintText: 'Adicione nome',
                hintStyle: TextStyle(color: Colors.white),
                border: defualtBorder,
                enabledBorder: defualtBorder,
                focusedBorder: defualtBorder,
                errorBorder: defualtBorder,
                disabledBorder: defualtBorder,
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Text(
                'SORTEAR',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: Colors.white,
                    ),
              ),
              onPressed: () {
                Get.off(const ListTimePage());
                for (var i = 0; i <= 10; i++) {
                  controller.divideList();
                }
              },
            ),
            const SizedBox(height: 20),
            const AmountPersonsPage(),
          ],
        ),
      ),
    );
  }
}
