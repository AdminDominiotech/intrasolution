import 'package:flutter/material.dart';
import 'package:safe2biz/app/global/core/core.dart';

class RadioButton extends StatelessWidget {
  const RadioButton({
    Key? key,
    this.outerCircleColor = S2BColors.white,
    this.outerBorderCircleColor = S2BColors.graySecondary,
    this.innerCircleColor = S2BColors.white,
    this.outerCircleSize = 22,
    this.innerCircleSize = 9,
    this.onTap,
  }) : super(key: key);

  final Color outerCircleColor;
  final Color outerBorderCircleColor;
  final Color innerCircleColor;
  final double innerCircleSize;
  final double outerCircleSize;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: outerCircleSize,
        height: outerCircleSize,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: outerBorderCircleColor,
            width: 1,
          ),
          color: outerCircleColor,
        ),
        child: Center(
          child: Container(
            width: innerCircleSize,
            height: innerCircleSize,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: innerCircleColor,
            ),
          ),
        ),
      ),
    );
  }
}
