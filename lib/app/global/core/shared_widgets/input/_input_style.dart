import 'package:flutter/material.dart';
import 'package:safe2biz/app/global/core/core.dart';

class InputStyle {
  InputStyle({
    required this.colorBorder,
    required this.labelColor,
  });

  final Color colorBorder;
  final Color labelColor;

  static const colorError = S2BColors.colorError;
  static const colorHover = S2BColors.colorHover;
  static const colorFocused = S2BColors.colorFocused;
  static const colorInactive = S2BColors.colorInactive;
  static const colorSuccess = S2BColors.colorSuccess;

  static InputStyle inactive = InputStyle(
    colorBorder: colorInactive,
    labelColor: colorInactive,
  );

  static InputStyle focused = InputStyle(
    colorBorder: colorFocused,
    labelColor: colorFocused,
  );

  static InputStyle error = InputStyle(
    colorBorder: colorError,
    labelColor: colorError,
  );

  static InputStyle success = InputStyle(
    colorBorder: colorSuccess,
    labelColor: colorSuccess,
  );
}

class InputStatus {
  InputStatus({
    required this.status,
    required this.message,
  });

  final bool status;
  final String message;
}
