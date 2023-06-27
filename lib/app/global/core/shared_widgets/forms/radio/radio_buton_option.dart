import 'package:flutter/widgets.dart';
import 'package:safe2biz/app/global/core/core.dart';

class RadioButtonOption {
  RadioButtonOption({
    required this.id,
    required this.code,
    required this.label,
    this.isChecked = false,
    this.color = S2BColors.black,
  });

  final String id;
  final String code;
  final String label;
  final bool isChecked;
  final Color color;
}
