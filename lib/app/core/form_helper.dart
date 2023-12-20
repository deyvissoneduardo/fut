import 'package:flutter/material.dart';

extension UnFocusExtension on BuildContext {
  void unfocus() => FocusScope.of(this).unfocus();
}