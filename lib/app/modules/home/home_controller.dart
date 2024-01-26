import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  RxList<String> allNames = <String>[].obs;
  RxList<List<String>> dividedLists = <List<String>>[].obs;
  final TextEditingController nameController = TextEditingController();
  RxBool isLoading = false.obs;

  final List<int> items = List<int>.generate(50, (int index) => index).obs;

  String get totalNamesText => 'Total de Nomes: ${allNames.length}';
  String get addedNamesText => 'Nomes Adicionados: ${allNames.join(', ')}';

  void onReorder(int oldIndex, int newIndex) {
    if (oldIndex < newIndex) {
      newIndex -= 1;
    }
    final int item = items.removeAt(oldIndex);
    items.insert(newIndex, item);
    update();
  }

  void divideList() async {
    dividedLists.clear();

    final List<String> shuffledNames = List.from(allNames);
    shuffledNames.shuffle();

    const chunkSize = 5;
    for (var i = 0; i < shuffledNames.length; i += chunkSize) {
      final chunk = shuffledNames.sublist(
          i,
          i + chunkSize > shuffledNames.length
              ? shuffledNames.length
              : i + chunkSize);
      dividedLists.add(chunk);
    }
  }
}
