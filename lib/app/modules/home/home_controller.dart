import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeController extends GetxController {
  RxList<String> allNames = <String>[].obs;
  RxList<List<String>> dividedLists = <List<String>>[].obs;
  List<List<List<String>>> history = [];

  final TextEditingController nameController = TextEditingController();
  final TextEditingController minutosController = TextEditingController();
  RxBool isLoading = false.obs;

  final List<int> items = List<int>.generate(50, (int index) => index).obs;
  RxInt sort = 0.obs;
  String get totalNamesText => 'Total de Nomes: ${allNames.length}';
  String get addedNamesText => 'Nomes Adicionados: ${allNames.join(', ')}';

  var tempoRestante = 0.obs;
  RxInt time = 0.obs;
  RxInt time1 = 0.obs;
  RxInt time2 = 0.obs;

  Timer? _timer;

  List<Color> cardColors = [
    Colors.blue,
    Colors.green,
    Colors.orange,
    Colors.purple,
    Colors.grey,
    Colors.amber,
    Colors.pink,
    Colors.blueGrey,
    Colors.brown,
  ];

  @override
  void onInit() {
    super.onInit();
    loadLists();
  }

  @override
  void onClose() {
    nameController.dispose();
    _timer?.cancel();
    FlutterRingtonePlayer().stop();
    super.onClose();
  }

  void countTime01() {
    time1.value += 1;
  }

  void countTime02() {
    time2.value += 1;
  }

  void saveCurrentState() {
    history.add(
      List<List<String>>.from(
        dividedLists.map((list) => List<String>.from(list)),
      ),
    );
  }

  Future<void> undoLastChange() async {
    if (history.isNotEmpty) {
      dividedLists.value = history.removeLast();
      await saveLists();
      dividedLists.refresh();
    }
  }

  void generateRandomNumber() async {
    isLoading.value = true;
    final Random random = Random();
    await Future.delayed(const Duration(seconds: 2));
    sort.value = ((random.nextInt(10) * 2) + (random.nextInt(10) * 4)) +
        ((random.nextInt(10) * 3) + ((random.nextInt(10) * 5)));
    isLoading.value = false;
  }

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
    for (var i = 0; i < shuffledNames.length; i += 5) {
      final chunk = shuffledNames.sublist(
        i,
        i + chunkSize > shuffledNames.length
            ? shuffledNames.length
            : i + chunkSize,
      );
      dividedLists.add(chunk);
    }
  }

  Future<void> loadLists() async {
    final prefs = await SharedPreferences.getInstance();
    final savedLists = prefs.getString('dividedLists');

    if (savedLists != null) {
      final List<dynamic> jsonList = json.decode(savedLists);
      dividedLists.value =
          jsonList.map((list) => List<String>.from(list)).toList();
    }
  }

  Future<void> saveLists() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonList = json.encode(dividedLists.toList());
    await prefs.setString('dividedLists', jsonList);
  }

  void moveListToEnd(int index) {
    saveCurrentState();
    if (index < dividedLists.length) {
      final listToMove = dividedLists[index];
      dividedLists.removeAt(index);
      dividedLists.add(listToMove);

      for (var i = 0; i < dividedLists.length - 1; i++) {
        while (dividedLists[i].length < 5) {
          if (listToMove.isNotEmpty) {
            dividedLists[i].add(listToMove[0]);
            listToMove.removeAt(0);
          } else {
            break;
          }
        }
      }
    }
    saveLists();
  }

  bool areAllListsFull() {
    return dividedLists.isNotEmpty &&
        dividedLists.every((list) => list.length == 5);
  }

  void addNameToList(String name) {
    if (name.isEmpty) return;

    final bool allListsFull = dividedLists.every((list) => list.length == 5);

    if (!allListsFull) {
      for (var list in dividedLists) {
        if (list.length < 5) {
          list.add(name);
          break;
        }
      }
    } else {
      dividedLists.add([name]);
    }

    saveLists();
  }

  void createNewListWithName(String name) {
    dividedLists.add([name]);
    saveLists();
    dividedLists.refresh();
  }

  void createNewList() {
    dividedLists.add([]);
    saveLists();
    dividedLists.refresh();
  }

  void clearLists() {
    dividedLists.clear();
    saveLists();
  }

  void tocarSomNativo() {
    FlutterRingtonePlayer().playNotification(
      asAlarm: false,
      looping: true,
      volume: 100.0,
    );
  }

  void removeItemFromList(int i, MapEntry<int, String> entry) {
    dividedLists[i].removeAt(
      entry.key,
    );

    if (dividedLists[i].isEmpty) {
      dividedLists.removeAt(i);
    }

    dividedLists.refresh();
    Get.back();
  }

  void addNameFromList(int i) {
    saveCurrentState();
    final name = nameController.text.trim();
    if (name.isNotEmpty) {
      dividedLists[i].add(name);
      nameController.clear();
      dividedLists.refresh();
      saveLists();
      Get.back();
    }
  }
}
