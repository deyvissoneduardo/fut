import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  RxList<String> nomes = <String>[].obs;
  RxList<String> nomesSorteados = <String>[].obs;
  RxBool view = true.obs;

  final nomeController = TextEditingController();

  List<Color> cores = [
    Colors.blue,
    Colors.green,
    Colors.red,
    Colors.orange,
    Colors.purple,
    Colors.brown,
    Colors.pink,
  ];

  void adicionarNome() {
    final nome = nomeController.text;
    if (nome.isNotEmpty) {
      nomes.add(nome);
      nomeController.clear();
    }
  }

  void sortearNomes() {
    view.value = false;
    final random = Random();
    nomesSorteados = nomes;
    nomesSorteados.shuffle(random);
  }

  List<List<String>> dividirNomesSorteados(
      List<String> nomesSorteados, int tamanho) {
    List<List<String>> grupos = [];
    for (int i = 0; i < nomesSorteados.length; i += tamanho) {
      grupos.add(
          nomesSorteados.sublist(i, min(i + tamanho, nomesSorteados.length)));
    }
    return grupos;
  }
}
