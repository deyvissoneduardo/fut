// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class TextButtionCancel extends StatelessWidget {
  final VoidCallback onPressed;
  const TextButtionCancel({
    Key? key,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(onPressed: onPressed, child: const Text('Cancelar'));
  }
}
