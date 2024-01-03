import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  RxList<String> allNames = <String>[].obs;
  RxList<List<String>> dividedLists = <List<String>>[].obs;
  ScrollController scrollController = ScrollController();

  String get totalNamesText => 'Total de Nomes: ${allNames.length}';
  String get addedNamesText => 'Nomes Adicionados: ${allNames.join(', ')}';

  TextEditingController nameController = TextEditingController();

  void divideList() {
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
