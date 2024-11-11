import 'package:flutter/material.dart';

class TitleTimeWidget extends StatelessWidget {
  final int i;
  const TitleTimeWidget({
    Key? key,
    required this.i,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      i == 0
          ? 'Jogando Time 01'
          : i == 1
              ? 'Jogando Time 02'
              : i == 2
                  ? 'Primeira'
                  : i == 3
                      ? 'Segunda'
                      : i == 4
                          ? 'Terceira'
                          : i == 5
                              ? 'Quarta'
                              : i == 6
                                  ? 'Quinta'
                                  : 'Time ${i + 1}',
      style: const TextStyle(
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
