import 'package:flutter/material.dart';

class ButtonAddNome extends StatelessWidget {
  final VoidCallback onPressed;
  const ButtonAddNome({
    Key? key,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: onPressed,
      child: const Icon(
        Icons.add,
        color: Colors.black,
      ),
    );
  }
}
