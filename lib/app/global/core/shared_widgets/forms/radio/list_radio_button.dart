import 'package:flutter/material.dart';
import 'package:safe2biz/app/global/core/core.dart';
import 'package:safe2biz/app/global/core/shared_widgets/forms/radio/radio_buton_option.dart';

class ListRadioButton extends StatelessWidget {
  /// Creates a  List radio button.
  ///
  /// The [item] and [isChecked] and  [onTap]  argument must not be null.
  const ListRadioButton({
    Key? key,
    required this.item,
    this.isChecked = false,
    required this.onTap,
  }) : super(key: key);
  final RadioButtonOption item;
  final bool isChecked;
  final VoidCallback? onTap;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: S2BSpacing.sm,
      ),
      decoration: BoxDecoration(
        color: S2BColors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: InkWell(
        onTap: onTap,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            RadioButton(
              outerCircleColor:
                  isChecked ? S2BColors.primaryColor : S2BColors.white,
              outerBorderCircleColor:
                  isChecked ? S2BColors.white : S2BColors.graySecondary,
            ),
            const SizedBox(
              width: S2BSpacing.sl,
            ),
            TextLabel.labelText(
              item.label,
              color: item.color,
            ),
          ],
        ),
      ),
    );
  }
}
