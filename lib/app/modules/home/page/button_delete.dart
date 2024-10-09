import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ButtonDelete extends StatelessWidget {
  final VoidCallback onPressed;
  const ButtonDelete({
    Key? key,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
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
                onPressed: onPressed,
                child: const Text('Confirmar'),
              ),
            ],
          ),
        );
      },
      icon: const Icon(
        Icons.delete_forever,
        color: Colors.red,
        size: 30,
      ),
    );
  }
}
