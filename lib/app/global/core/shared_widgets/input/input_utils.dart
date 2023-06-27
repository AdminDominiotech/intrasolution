import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

typedef InputTextValidator<T> = String? Function(T value);

class InputTrailingIcon {
  const InputTrailingIcon(
    this.icon, {
    this.color,
    this.size,
    this.backgroundColor,
  });

  final IconData icon;
  final Color? color;
  final double? size;
  final Color? backgroundColor;
}

class InputLeadingIcon {
  const InputLeadingIcon(
    this.icon, {
    this.color,
    this.size,
    this.backgroundColor,
  });

  final IconData icon;
  final Color? color;
  final double? size;
  final Color? backgroundColor;
}

const double inputWidthBorder = 1.5;
const double inputBorderRadius = 4;
const double inputHeight = 45;
const double inputMinWidth = 300;
const TextStyle inputErrorStyle = TextStyle(
  color: Colors.transparent,
  fontSize: kIsWeb ? 0.5 : 0.01,
  height: kIsWeb ? 0.5 : 0.01,
);

enum InputType { text, password }
